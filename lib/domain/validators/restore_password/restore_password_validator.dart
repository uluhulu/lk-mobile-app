class RestorePasswordValidator {
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Не введён пароль';
    }
    if (value.length < 5) {
      return 'Не введён пароль';
    }
    if (value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Содержит недопустимый символ';
    }
    if (value.contains(RegExp(r'[а-яА-Я]'))) {
      return 'Содержит недопустимый символ';
    }

    if (value.contains(RegExp(r'[a-zA-Z]'))) {
      return null;
    }

    if (value.contains(RegExp(r'[0-9]'))) {
      return null;
    }

    return null;
  }

  static String? validateReEnterPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Не введён пароль';
    }
    if (value.length < 5) {
      return 'Не введён пароль';
    }
    if (value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Содержит недопустимый символ';
    }
    if (value.contains(RegExp(r'[а-яА-Я]'))) {
      return 'Содержит недопустимый символ';
    }

    if (value.contains(RegExp(r'[a-zA-Z]'))) {
      return null;
    }

    if (value.contains(RegExp(r'[0-9]'))) {
      return null;
    }

    return null;
  }

  static String? validateCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите код';
    }
    if (value.length < 6) {
      return 'Введите код';
    }
    return null;
  }

  static bool validateStructure(String value) {
    String pattern = r'^[A-Za-z0-9]$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static String? codeValidFunc(bool? value) {
    if (value != true) {
      return 'Неверный код';
    } else {
      return null;
    }
  }

  static String? loginValidFunc(bool? value) {
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

  static String? reEnterPasswordValidFunc(bool? value) {
    if (value != true) {
      return 'Не введен пароль';
    } else {
      return null;
    }
  }
}
