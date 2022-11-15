// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Привет мир`
  String get main_page_title {
    return Intl.message(
      'Привет мир',
      name: 'main_page_title',
      desc: '',
      args: [],
    );
  }

  /// `Регистрация`
  String get register {
    return Intl.message(
      'Регистрация',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Для того чтобы получить доступ к личному кабинету, вам необходимо обратиться к своему менеджеру. Он зарегистрирует Вашу организацию в системе и выдаст Логин и Пароль.`
  String get register_info {
    return Intl.message(
      'Для того чтобы получить доступ к личному кабинету, вам необходимо обратиться к своему менеджеру. Он зарегистрирует Вашу организацию в системе и выдаст Логин и Пароль.',
      name: 'register_info',
      desc: '',
      args: [],
    );
  }

  /// `Перейти на сайт ФК ПУЛЬС`
  String get open_web_puls {
    return Intl.message(
      'Перейти на сайт ФК ПУЛЬС',
      name: 'open_web_puls',
      desc: '',
      args: [],
    );
  }

  /// `Восстановление пароля`
  String get restore_password {
    return Intl.message(
      'Восстановление пароля',
      name: 'restore_password',
      desc: '',
      args: [],
    );
  }

  /// `Восстановить пароль данным способом можно только в случае, если к учетной записи привязан e-mail. Для восстановления пароля заполните поле «Логин» и выберите вашу региональную компанию.`
  String get restore_password_info {
    return Intl.message(
      'Восстановить пароль данным способом можно только в случае, если к учетной записи привязан e-mail. Для восстановления пароля заполните поле «Логин» и выберите вашу региональную компанию.',
      name: 'restore_password_info',
      desc: '',
      args: [],
    );
  }

  /// `Вы также можете обратиться в службу технической поддержки по адресу `
  String get restore_password_info_2 {
    return Intl.message(
      'Вы также можете обратиться в службу технической поддержки по адресу ',
      name: 'restore_password_info_2',
      desc: '',
      args: [],
    );
  }

  /// `Забыли пароль?`
  String get forgot_password {
    return Intl.message(
      'Забыли пароль?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Введите логин`
  String get enter_login {
    return Intl.message(
      'Введите логин',
      name: 'enter_login',
      desc: '',
      args: [],
    );
  }

  /// `Введите пароль`
  String get enter_password {
    return Intl.message(
      'Введите пароль',
      name: 'enter_password',
      desc: '',
      args: [],
    );
  }

  /// `Логин`
  String get login {
    return Intl.message(
      'Логин',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Пароль`
  String get password {
    return Intl.message(
      'Пароль',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Региональная компания`
  String get region_company {
    return Intl.message(
      'Региональная компания',
      name: 'region_company',
      desc: '',
      args: [],
    );
  }

  /// `Ошибка аутентификации`
  String get auth_error {
    return Intl.message(
      'Ошибка аутентификации',
      name: 'auth_error',
      desc: '',
      args: [],
    );
  }

  /// `Проверьте правильность заполнения данных. Если данные совпадают с указанными в карточке, высланной вам менеджером, а вход под ними не воспроизводится — обратитесь к вашему менеджеру или в техническую поддержку по адресу`
  String get auth_error_info {
    return Intl.message(
      'Проверьте правильность заполнения данных. Если данные совпадают с указанными в карточке, высланной вам менеджером, а вход под ними не воспроизводится — обратитесь к вашему менеджеру или в техническую поддержку по адресу',
      name: 'auth_error_info',
      desc: '',
      args: [],
    );
  }

  /// `help@puls.ru`
  String get puls_email {
    return Intl.message(
      'help@puls.ru',
      name: 'puls_email',
      desc: '',
      args: [],
    );
  }

  /// `Просим при обращении указать ваш ИНН и региональную компанию ФК ПУЛЬС, с которой вы работаете.`
  String get auth_error_info_2 {
    return Intl.message(
      'Просим при обращении указать ваш ИНН и региональную компанию ФК ПУЛЬС, с которой вы работаете.',
      name: 'auth_error_info_2',
      desc: '',
      args: [],
    );
  }

  /// `Отправить`
  String get send {
    return Intl.message(
      'Отправить',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Ошибка восстановления пароля`
  String get restore_password_error_title {
    return Intl.message(
      'Ошибка восстановления пароля',
      name: 'restore_password_error_title',
      desc: '',
      args: [],
    );
  }

  /// `Учётная запись не найдена. Проверьте правильность заполнения логина и региональной компании.`
  String get restore_password_error {
    return Intl.message(
      'Учётная запись не найдена. Проверьте правильность заполнения логина и региональной компании.',
      name: 'restore_password_error',
      desc: '',
      args: [],
    );
  }

  /// `Войти`
  String get enter {
    return Intl.message(
      'Войти',
      name: 'enter',
      desc: '',
      args: [],
    );
  }

  /// `Понятно`
  String get ok {
    return Intl.message(
      'Понятно',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Введите код`
  String get enter_pin_code {
    return Intl.message(
      'Введите код',
      name: 'enter_pin_code',
      desc: '',
      args: [],
    );
  }

  /// `Код не подходит`
  String get incorrect_code {
    return Intl.message(
      'Код не подходит',
      name: 'incorrect_code',
      desc: '',
      args: [],
    );
  }

  /// `Осталось 2 попытки. Потом код сбросится, и вход будет доступен только по логину и паролю.`
  String get pin_code_retry_text {
    return Intl.message(
      'Осталось 2 попытки. Потом код сбросится, и вход будет доступен только по логину и паролю.',
      name: 'pin_code_retry_text',
      desc: '',
      args: [],
    );
  }

  /// `Придумайте 4-значный код`
  String get come_up_pin_code {
    return Intl.message(
      'Придумайте 4-значный код',
      name: 'come_up_pin_code',
      desc: '',
      args: [],
    );
  }

  /// `Чтобы при входе в приложение не вводить логин и пароль`
  String get come_up_pin_code_info {
    return Intl.message(
      'Чтобы при входе в приложение не вводить логин и пароль',
      name: 'come_up_pin_code_info',
      desc: '',
      args: [],
    );
  }

  /// `Пропустить шаг`
  String get skip_step {
    return Intl.message(
      'Пропустить шаг',
      name: 'skip_step',
      desc: '',
      args: [],
    );
  }

  /// `Повторите код, который вы только что придумали`
  String get repeat_pin_code {
    return Intl.message(
      'Повторите код, который вы только что придумали',
      name: 'repeat_pin_code',
      desc: '',
      args: [],
    );
  }

  /// `Введён неверный код`
  String get repeat_pin_code_error {
    return Intl.message(
      'Введён неверный код',
      name: 'repeat_pin_code_error',
      desc: '',
      args: [],
    );
  }

  /// `Не получилось создать код`
  String get pin_code_error_title {
    return Intl.message(
      'Не получилось создать код',
      name: 'pin_code_error_title',
      desc: '',
      args: [],
    );
  }

  /// `Вы неверно повторили код 2 раза подряд.\n\nВы можете придумать новый код, чтобы при каждом входе в приложение не вводить логин и пароль, или пропустить этот шаг.`
  String get pin_code_error_subtitle {
    return Intl.message(
      'Вы неверно повторили код 2 раза подряд.\n\nВы можете придумать новый код, чтобы при каждом входе в приложение не вводить логин и пароль, или пропустить этот шаг.',
      name: 'pin_code_error_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Войти по логину и паролю`
  String get enter_for_log_pass {
    return Intl.message(
      'Войти по логину и паролю',
      name: 'enter_for_log_pass',
      desc: '',
      args: [],
    );
  }

  /// `Создать новый код`
  String get create_new_code {
    return Intl.message(
      'Создать новый код',
      name: 'create_new_code',
      desc: '',
      args: [],
    );
  }

  /// `Пропустить создание кода`
  String get skip_create_code {
    return Intl.message(
      'Пропустить создание кода',
      name: 'skip_create_code',
      desc: '',
      args: [],
    );
  }

  /// `Профиль`
  String get profile {
    return Intl.message(
      'Профиль',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Выйти`
  String get logout {
    return Intl.message(
      'Выйти',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Накладные`
  String get overhead {
    return Intl.message(
      'Накладные',
      name: 'overhead',
      desc: '',
      args: [],
    );
  }

  /// `Претензии`
  String get claims {
    return Intl.message(
      'Претензии',
      name: 'claims',
      desc: '',
      args: [],
    );
  }

  /// `Платежи`
  String get payments {
    return Intl.message(
      'Платежи',
      name: 'payments',
      desc: '',
      args: [],
    );
  }

  /// `Для получения акта сверки, пожалуйста, выберите период, за который Вы хотели бы его получить.\n\nПосле отправки запроса с вами свяжется Ваш менеджер.`
  String get act_info {
    return Intl.message(
      'Для получения акта сверки, пожалуйста, выберите период, за который Вы хотели бы его получить.\n\nПосле отправки запроса с вами свяжется Ваш менеджер.',
      name: 'act_info',
      desc: '',
      args: [],
    );
  }

  /// `Ошибка отправки запроса акта сверки!\n\nОбратитесь к вашему менеджеру или в техническую поддержку по адресу `
  String get act_error_info {
    return Intl.message(
      'Ошибка отправки запроса акта сверки!\n\nОбратитесь к вашему менеджеру или в техническую поддержку по адресу ',
      name: 'act_error_info',
      desc: '',
      args: [],
    );
  }

  /// `Запрос акта сверки`
  String get act_request {
    return Intl.message(
      'Запрос акта сверки',
      name: 'act_request',
      desc: '',
      args: [],
    );
  }

  /// `Выберите период`
  String get select_period {
    return Intl.message(
      'Выберите период',
      name: 'select_period',
      desc: '',
      args: [],
    );
  }

  /// `Запросить`
  String get request {
    return Intl.message(
      'Запросить',
      name: 'request',
      desc: '',
      args: [],
    );
  }

  /// `Менеджер свяжется с вами в ближайшее время.`
  String get manager_request_you {
    return Intl.message(
      'Менеджер свяжется с вами в ближайшее время.',
      name: 'manager_request_you',
      desc: '',
      args: [],
    );
  }

  /// `Запрос отправлен!`
  String get act_request_success {
    return Intl.message(
      'Запрос отправлен!',
      name: 'act_request_success',
      desc: '',
      args: [],
    );
  }

  /// `Запросить акт сверки`
  String get request_act {
    return Intl.message(
      'Запросить акт сверки',
      name: 'request_act',
      desc: '',
      args: [],
    );
  }

  /// `Код изменён`
  String get change_code_success {
    return Intl.message(
      'Код изменён',
      name: 'change_code_success',
      desc: '',
      args: [],
    );
  }

  /// `Новый код успешно установлен!\n\nПри следущем входе в приложение используйте этот новый код.`
  String get change_code_info {
    return Intl.message(
      'Новый код успешно установлен!\n\nПри следущем входе в приложение используйте этот новый код.',
      name: 'change_code_info',
      desc: '',
      args: [],
    );
  }

  /// `Не получилось сменить код`
  String get change_code_error_title {
    return Intl.message(
      'Не получилось сменить код',
      name: 'change_code_error_title',
      desc: '',
      args: [],
    );
  }

  /// `Вы неверно повторили новый код 2 раза подряд.\n\nВы можете создать другой код или продолжить использовать старый.`
  String get change_code_error_subtitle {
    return Intl.message(
      'Вы неверно повторили новый код 2 раза подряд.\n\nВы можете создать другой код или продолжить использовать старый.',
      name: 'change_code_error_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Оставить старый код`
  String get leave_old_code {
    return Intl.message(
      'Оставить старый код',
      name: 'leave_old_code',
      desc: '',
      args: [],
    );
  }

  /// `Сменить код входа`
  String get change_code {
    return Intl.message(
      'Сменить код входа',
      name: 'change_code',
      desc: '',
      args: [],
    );
  }

  /// `'Придумайте новый\n4-значный код`
  String get come_up_new_code {
    return Intl.message(
      '\'Придумайте новый\n4-значный код',
      name: 'come_up_new_code',
      desc: '',
      args: [],
    );
  }

  /// `Отменить`
  String get cancel {
    return Intl.message(
      'Отменить',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Сменить код входа в приложение`
  String get change_app_login_code {
    return Intl.message(
      'Сменить код входа в приложение',
      name: 'change_app_login_code',
      desc: '',
      args: [],
    );
  }

  /// `Уведомления`
  String get notifications {
    return Intl.message(
      'Уведомления',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Настройки`
  String get settings {
    return Intl.message(
      'Настройки',
      name: 'settings',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
