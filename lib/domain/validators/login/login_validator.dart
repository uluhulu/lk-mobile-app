class LoginValidator {
  static String? validateLogin(String? value) {
    if (value == null || value.isEmpty) {
      return 'Не введён логин';
    }
    if (value.length < 5) {
      return 'Не введён логин';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Не введён пароль';
    }
    if (value.length < 5) {
      return 'Не введён пароль';
    }
    return null;
  }

  static String? validateFilial(int? value) {
    if (value == null) {
      return 'Не выбрана региональная компания';
    }
    return null;
  }

  static String? validLoginFunc(bool? value) {
    if (value != true) {
      return 'Не введен логин';
    } else {
      return null;
    }
  }

  static String? passwordValidFunc(bool? value) {
    if (value != true) {
      return 'Не введен пароль';
    } else {
      return null;
    }
  }

  static String? filialValidFunc(bool? value) {
    if (value != true) {
      return 'Не выбрана региональная компания';
    } else {
      return null;
    }
  }
}
