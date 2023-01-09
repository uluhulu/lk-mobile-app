import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mkk/data/api/auth/forgot_password/params/auth_forgot_password_params.dart';
import 'package:mkk/data/api/auth/reset_password_code/params/reset_password_with_code_params.dart';
import 'package:mkk/domain/validators/login/login_validator.dart';
import 'package:super_validation/super_validation_enum.dart';
import 'package:super_validation/super_validation_string.dart';
import '../../../../data/api/auth/reset_password_code/params/reset_password_code_params.dart';
import '../../../../data/api/dictionary/filials/entity/dictionary_filials_entity.dart';
import '../../../../domain/repositories/repository.dart';
import '../../../../domain/validators/restore_password/restore_password_validator.dart';
import '../../../../services/error/bloc/error_bloc.dart';

part 'restore_password_event.dart';
part 'restore_password_state.dart';

class RestorePasswordBloc
    extends Bloc<RestorePasswordEvent, RestorePasswordState> {
  final Repository repository;
  final ErrorBloc errorBloc;
  RestorePasswordBloc({
    required this.repository,
    required this.errorBloc,
  }) : super(RestorePasswordInitialS()) {
    on<RestorePasswordFilialE>(_fetchFilial);
    on<RestorePasswordSendE>(_send);
    on<RestorePasswordCheckCodeE>(_checkCode);
    on<RestorePasswordResetE>(_reset);
    add(RestorePasswordFilialE());

    codeSubscription = code.stream.listen(_codeListener);
    loginSubscription = login.stream.listen(_loginListener);
    newPasswordSubscription = password.stream.listen(_newPasswordListener);
    newPasswordRepeatSubscription =
        reEnterPassword.stream.listen(_newPasswordRepeatListener);
  }

  late StreamSubscription<String?> loginSubscription;
  late StreamSubscription<String?> codeSubscription;
  late StreamSubscription<String?> newPasswordSubscription;
  late StreamSubscription<String?> newPasswordRepeatSubscription;
  late DictionaryFilialEntity copyData;

  @override
  Future<void> close() {
    loginSubscription.cancel();
    codeSubscription.cancel();
    newPasswordSubscription.cancel();
    newPasswordRepeatSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _fetchFilial(
      RestorePasswordFilialE event, Emitter<RestorePasswordState> emit) async {
    try {
      emit(RestorePasswordLoadingS());
      final result = await repository.dictionaryFilialList();
      copyData = result;
      emit(RestorePasswordLoadedS(data: result));
    } catch (e) {
      errorBloc.add(ErrorSimpleE(e));
    }
  }

  FutureOr<void> _send(
      RestorePasswordSendE event, Emitter<RestorePasswordState> emit) async {
    try {
      emit(RestorePasswordLoadingS());
      codeValid.value = true;
      final AuthForgotPasswordParams params = AuthForgotPasswordParams(
        username: login.text,
        filial: copyData.data[filialValidation.value ?? 0].id,
      );
      final result = await repository.forgotPassword(params);

      emit(RestorePasswordEnterCodeS(message: result.data.message));
    } catch (e) {
      _resetValidation();

      emit(RestorePasswordErrorS());
      add(RestorePasswordFilialE());
    }
  }

  FutureOr<void> _checkCode(RestorePasswordCheckCodeE event,
      Emitter<RestorePasswordState> emit) async {
    try {
      emit(RestorePasswordLoadingS());
      final ResetPasswordCodeParams params = ResetPasswordCodeParams(
        username: login.text,
        code: code.text,
      );
      await repository.resetPasswordCode(params);
      emit(RestorePasswordEnterNewPasswordS());
    } catch (e) {
      code.text = '';
      codeValid.value = false;
      emit(RestorePasswordEnterCodeS());
    }
  }

  FutureOr<void> _reset(
      RestorePasswordResetE event, Emitter<RestorePasswordState> emit) async {
    try {
      emit(RestorePasswordLoadingS());
      final ResetPasswordWithCodeParams params = ResetPasswordWithCodeParams(
        username: login.text,
        code: code.text,
        newPassword: reEnterPassword.text,
      );
      // final passwordIsValid =
      //     RestorePasswordValidator.validateStructure(reEnterPassword.text);
      //     passwordIsValid ? emit(RestorePasswordResetErrorS()) :
      final result = await repository.resetPasswordWithCode(params);
      emit(ResetPasswordSuccessS(message: result.data.message));
      emit(RestorePasswordLoadedS(data: copyData));
    } catch (e) {
      password.text = '';
      reEnterPassword.text = '';
      passwordValid.value = false;
      reEnterPasswordValid.value = false;
      emit(RestorePasswordErrorS());
    }
  }

  String getName(int index) {
    return copyData.data[index].name;
  }

  void _resetValidation() {
    login.text = '';
    loginValid.value = false;
    filialValidation.value = null;
  }

  final SuperValidation login = SuperValidation(
    validationFunc: LoginValidator.validateLogin,
  );

  final SuperValidation code = SuperValidation(
    validationFunc: RestorePasswordValidator.validateCode,
  );

  final SuperValidation password = SuperValidation(
    validationFunc: RestorePasswordValidator.validatePassword,
  );

  late final SuperValidation reEnterPassword =
      SuperValidation(validationFunc: (value) {
    if (password.text != value) {
      return 'Значения паролей не совпадают';
    }
    return RestorePasswordValidator.validateReEnterPassword(value);
  });

  final SuperValidationEnum<int> filialValidation =
      SuperValidationEnum<int>(validateFunc: LoginValidator.validateFilial)
        ..validation = 'Не выбрана региональная компания';

  final SuperValidationEnum<bool> codeValid = SuperValidationEnum<bool>(
    validateFunc: RestorePasswordValidator.codeValidFunc,
  )..value = true;

  final SuperValidationEnum<bool> loginValid = SuperValidationEnum<bool>(
    validateFunc: RestorePasswordValidator.loginValidFunc,
  )..value = true;

  final SuperValidationEnum<bool> passwordValid = SuperValidationEnum<bool>(
    validateFunc: RestorePasswordValidator.passwordValidFunc,
  )..value = true;

  final SuperValidationEnum<bool> reEnterPasswordValid =
      SuperValidationEnum<bool>(
    validateFunc: RestorePasswordValidator.reEnterPasswordValidFunc,
  )..value = true;

  void _codeListener(String event) {
    codeValid.value = true;
  }

  void _loginListener(String event) {
    loginValid.value = true;
  }

  void _newPasswordListener(String event) {
    passwordValid.value = true;
  }

  void _newPasswordRepeatListener(String event) {
    reEnterPasswordValid.value = true;
  }
}
