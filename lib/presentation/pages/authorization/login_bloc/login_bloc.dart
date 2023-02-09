import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mkk/data/providers/dio/transformers/interceptors/dio_auth_synchronizer.dart';
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
  final AuthSynchronizer authSynchronizer;
  final ErrorBloc errorBloc;
  LoginBloc({
    required this.authorizationBloc,
    required this.authSynchronizer,
    required this.repository,
    required this.errorBloc,
  }) : super(LoginInitialS()) {
    on<LoginEventFetchFilialE>(_fetchFilial);
    on<LoginInitialE>(_initial);
    on<LoginEnterE>(_enter);
    add(LoginEventFetchFilialE());
    add(LoginInitialE());

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
      //result sorting alphabetically
      result.data.sort((a, b) => a.name.compareTo(b.name));
      copyData = result;
      await Future.delayed(const Duration(milliseconds: 1200), () {
        emit(LoginLoadedS(data: result));
      });
    } catch (e) {
      errorBloc.add(ErrorSimpleE(e));
    }
  }

  FutureOr<void> _initial(LoginInitialE event, Emitter<LoginState> emit) async {
    final userLogin = userRepository.getUserLogin();
    final filial = userRepository.getRegionalCompany();
    final password = userRepository.getPassword();
    if (userLogin != null && filial != null && password != null) {
      loginValidation.text = userLogin;
      filialValidation.value = filial;
      passwordValidation.text = password;
    }
  }

  FutureOr<void> _enter(LoginEnterE event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoadingS());

      final filial = filialValidation.value;
      final login = loginValidation.text;
      final password = passwordValidation.text;

      final result = await authSynchronizer.login(
        login: login,
        password: password,
        filial: filial ?? 0,
      );

      if (!result.isLogin) {
        return;
      }
      final profile = await repository.getProfile();
      await userRepository.saveUserAccess(profile.data.client.accessGroups);
      authorizationBloc.add(AuthorizationLoginE());
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

  String getNameById(int id) {
    try {
      return copyData.data.firstWhere((element) => element.id == id).name;
    } catch (e) {
      return 'Не выбрано';
    }
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
    filialValid.dispose();
    loginValid.dispose();
    passwordValid.dispose();
    filialValidation.dispose();
    loginValidation.dispose();
    passwordValidation.dispose();

    return super.close();
  }
}
