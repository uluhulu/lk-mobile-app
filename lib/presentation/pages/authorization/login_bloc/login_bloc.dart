import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mkk/domain/repositories/user_repository.dart';
import 'package:mkk/locator/locator.dart';
import 'package:mkk/presentation/pages/authorization/authorization_bloc/authorization_bloc.dart';
import 'package:super_validation/super_validation_enum.dart';
import 'package:super_validation/super_validation_string.dart';
import '../../../../../data/api/dictionary/filials/entity/dictionary_filials_entity.dart';
import '../../../../../domain/repositories/repository.dart';
import '../../../../../services/error/bloc/error_bloc.dart';
import '../../../../domain/validators/login/login_validator.dart';
import '../../../../services/vibration/vibration_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthorizationBloc authorizationBloc;
  final Repository repository;
  final ErrorBloc errorBloc;
  LoginBloc({
    required this.authorizationBloc,
    required this.repository,
    required this.errorBloc,
  }) : super(LoginInitialS()) {
    on<LoginEventFetchFilialE>(_fetchFilial);
    on<LoginInitialE>(_initial);
    on<LoginEnterE>(_enter);
    add(LoginEventFetchFilialE());

    loginSubscription = loginValidation.stream.listen(_loginListener);
    passwordSubscription = passwordValidation.stream.listen(_passwordListener);
    filialSubscription = filialValidation.streamValue.listen(_filialListener);
  }

  late StreamSubscription<String?> loginSubscription;
  late StreamSubscription<String?> passwordSubscription;
  late StreamSubscription<int?> filialSubscription;

  final UserRepository userRepository = sl<UserRepository>();

  late DictionaryFilialEntity copyData;

  FutureOr<void> _fetchFilial(
      LoginEventFetchFilialE event, Emitter<LoginState> emit) async {
    try {
      emit(LoginSplashLoadingS());
      final result = await repository.dictionaryFilialList();
      copyData = result;
      await Future.delayed(const Duration(milliseconds: 1200), () {
        emit(LoginLoadedS(data: result));
      });
    } catch (e) {
      errorBloc.add(ErrorSimpleE(e));
    }
  }

  FutureOr<void> _initial(LoginInitialE event, Emitter<LoginState> emit) {
    final userLogin = userRepository.getUserLogin();
    if (userLogin != null) {
      loginValidation.text = userLogin;
    }
  }

  FutureOr<void> _enter(LoginEnterE event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoadingS());

      final filial = copyData.data[filialValidation.value ?? 0].id;
      final login = loginValidation.text;

      final result = await repository.login(
        login: login,
        password: passwordValidation.text,
        filial: filial,
      );

      if (!result.data.isLogin) {
        return;
      }

      authorizationBloc.add(AuthorizationLoginE(
        filial: filial,
        login: login,
        loginEntity: result,
      ));
    } catch (e) {
      VibrationService().vibrate();
      // _resetValidation();
      errorBloc.add(AuthErrorE(e));
    } finally {
      emit(LoginLoadedS(data: copyData));
    }
  }

  String getName(int index) {
    return copyData.data[index].name;
  }

  final SuperValidation loginValidation = SuperValidation(
    validationFunc: LoginValidator.validateLogin,
  );

  final SuperValidation passwordValidation = SuperValidation(
    validationFunc: LoginValidator.validatePassword,
  );

  final SuperValidationEnum<int> filialValidation =
      SuperValidationEnum<int>(validateFunc: LoginValidator.validateFilial)
        ..validation = 'Не выбрана региональная компания';

  final SuperValidationEnum<bool> loginValid = SuperValidationEnum<bool>(
    validateFunc: LoginValidator.validLoginFunc,
  )..value = true;

  final SuperValidationEnum<bool> passwordValid = SuperValidationEnum<bool>(
    validateFunc: LoginValidator.passwordValidFunc,
  )..value = true;

  final SuperValidationEnum<bool> filialValid = SuperValidationEnum<bool>(
    validateFunc: LoginValidator.filialValidFunc,
  )..value = true;

  void _loginListener(String event) {
    loginValid.value = true;
  }

  void _passwordListener(String event) {
    passwordValid.value = true;
  }

  void _filialListener(int? event) {
    filialValid.value = true;
  }

  void _resetValidation() {
    VibrationService().vibrate();

    ///loginValidation.text = '';
    loginValid.value = false;
    //passwordValidation.text = '';
    passwordValid.value = false;
    //filialValidation.value = null;
    filialValid.value = false;
  }

  @override
  Future<void> close() {
    loginSubscription.cancel();
    passwordSubscription.cancel();
    filialSubscription.cancel();
    return super.close();
  }
}
