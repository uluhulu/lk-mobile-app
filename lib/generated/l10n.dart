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

  /// `Вы неверно повторили код 2 раза подряд.\n\nВы можете придумать новый код, чтобы при каждом входе в приложение не вводить логин и пароль, или отменить свое действие`
  String get pin_code_error_subtitle_new {
    return Intl.message(
      'Вы неверно повторили код 2 раза подряд.\n\nВы можете придумать новый код, чтобы при каждом входе в приложение не вводить логин и пароль, или отменить свое действие',
      name: 'pin_code_error_subtitle_new',
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

  /// `Код установлен`
  String get change_code_success_title {
    return Intl.message(
      'Код установлен',
      name: 'change_code_success_title',
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

  /// `Код успешно установлен!\n\nПри следущем входе в приложение используйте этот код.`
  String get change_code_info_new {
    return Intl.message(
      'Код успешно установлен!\n\nПри следущем входе в приложение используйте этот код.',
      name: 'change_code_info_new',
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

  /// `Придумайте новый\n4-значный код`
  String get come_up_new_code {
    return Intl.message(
      'Придумайте новый\n4-значный код',
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

  /// `Контакты ООО «ФК ПУЛЬС»`
  String get contacts {
    return Intl.message(
      'Контакты ООО «ФК ПУЛЬС»',
      name: 'contacts',
      desc: '',
      args: [],
    );
  }

  /// `Менеджер`
  String get manager {
    return Intl.message(
      'Менеджер',
      name: 'manager',
      desc: '',
      args: [],
    );
  }

  /// `Офис-менеджер`
  String get office_manager {
    return Intl.message(
      'Офис-менеджер',
      name: 'office_manager',
      desc: '',
      args: [],
    );
  }

  /// `Мои данные`
  String get my_data {
    return Intl.message(
      'Мои данные',
      name: 'my_data',
      desc: '',
      args: [],
    );
  }

  /// `Полное наименование`
  String get full_naim {
    return Intl.message(
      'Полное наименование',
      name: 'full_naim',
      desc: '',
      args: [],
    );
  }

  /// `ИНН`
  String get inn {
    return Intl.message(
      'ИНН',
      name: 'inn',
      desc: '',
      args: [],
    );
  }

  /// `E-mail`
  String get email {
    return Intl.message(
      'E-mail',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Выберите события, о которых вы хотите получать уведомления`
  String get select_events {
    return Intl.message(
      'Выберите события, о которых вы хотите получать уведомления',
      name: 'select_events',
      desc: '',
      args: [],
    );
  }

  /// `Изменения статусов претензий`
  String get changed_status {
    return Intl.message(
      'Изменения статусов претензий',
      name: 'changed_status',
      desc: '',
      args: [],
    );
  }

  /// `Сообщения по претензиям`
  String get claim_messages {
    return Intl.message(
      'Сообщения по претензиям',
      name: 'claim_messages',
      desc: '',
      args: [],
    );
  }

  /// `Сохранить`
  String get save {
    return Intl.message(
      'Сохранить',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Ошибка!`
  String get error {
    return Intl.message(
      'Ошибка!',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Оформить претензию`
  String get issue_claim {
    return Intl.message(
      'Оформить претензию',
      name: 'issue_claim',
      desc: '',
      args: [],
    );
  }

  /// `Добавить излишки`
  String get add_excess {
    return Intl.message(
      'Добавить излишки',
      name: 'add_excess',
      desc: '',
      args: [],
    );
  }

  /// `Добавить`
  String get add {
    return Intl.message(
      'Добавить',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Код`
  String get code {
    return Intl.message(
      'Код',
      name: 'code',
      desc: '',
      args: [],
    );
  }

  /// `Детали`
  String get details {
    return Intl.message(
      'Детали',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `Накладная`
  String get invoice {
    return Intl.message(
      'Накладная',
      name: 'invoice',
      desc: '',
      args: [],
    );
  }

  /// `Заказ покупателя`
  String get buyer_order {
    return Intl.message(
      'Заказ покупателя',
      name: 'buyer_order',
      desc: '',
      args: [],
    );
  }

  /// `Дата`
  String get date {
    return Intl.message(
      'Дата',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Сумма`
  String get sum {
    return Intl.message(
      'Сумма',
      name: 'sum',
      desc: '',
      args: [],
    );
  }

  /// `Сумма к оплате`
  String get amount_payble {
    return Intl.message(
      'Сумма к оплате',
      name: 'amount_payble',
      desc: '',
      args: [],
    );
  }

  /// `Ближайший срок оплаты`
  String get next_payment_date {
    return Intl.message(
      'Ближайший срок оплаты',
      name: 'next_payment_date',
      desc: '',
      args: [],
    );
  }

  /// `Просроченный период`
  String get overdue_period {
    return Intl.message(
      'Просроченный период',
      name: 'overdue_period',
      desc: '',
      args: [],
    );
  }

  /// `Адрес`
  String get address {
    return Intl.message(
      'Адрес',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Маркировка`
  String get marking {
    return Intl.message(
      'Маркировка',
      name: 'marking',
      desc: '',
      args: [],
    );
  }

  /// `Статус маркировки`
  String get status_marking {
    return Intl.message(
      'Статус маркировки',
      name: 'status_marking',
      desc: '',
      args: [],
    );
  }

  /// `Нет`
  String get no {
    return Intl.message(
      'Нет',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Есть`
  String get there_is {
    return Intl.message(
      'Есть',
      name: 'there_is',
      desc: '',
      args: [],
    );
  }

  /// `Площадка: `
  String get area {
    return Intl.message(
      'Площадка: ',
      name: 'area',
      desc: '',
      args: [],
    );
  }

  /// `Интернет-заказ: `
  String get internet_order {
    return Intl.message(
      'Интернет-заказ: ',
      name: 'internet_order',
      desc: '',
      args: [],
    );
  }

  /// `Статус заказа: `
  String get order_status {
    return Intl.message(
      'Статус заказа: ',
      name: 'order_status',
      desc: '',
      args: [],
    );
  }

  /// `Нет маркированного товара`
  String get no_marking_item {
    return Intl.message(
      'Нет маркированного товара',
      name: 'no_marking_item',
      desc: '',
      args: [],
    );
  }

  /// `Содержит маркированный товар`
  String get contains_marking_item {
    return Intl.message(
      'Содержит маркированный товар',
      name: 'contains_marking_item',
      desc: '',
      args: [],
    );
  }

  /// `Если в течение 5 минут сообщение не придёт, запросите новый код.`
  String get restore_password_enter_code_info {
    return Intl.message(
      'Если в течение 5 минут сообщение не придёт, запросите новый код.',
      name: 'restore_password_enter_code_info',
      desc: '',
      args: [],
    );
  }

  /// `Адрес доставки`
  String get delivery_address {
    return Intl.message(
      'Адрес доставки',
      name: 'delivery_address',
      desc: '',
      args: [],
    );
  }

  /// `Маркированный товар`
  String get marking_item {
    return Intl.message(
      'Маркированный товар',
      name: 'marking_item',
      desc: '',
      args: [],
    );
  }

  /// `Сначала новые`
  String get new_first {
    return Intl.message(
      'Сначала новые',
      name: 'new_first',
      desc: '',
      args: [],
    );
  }

  /// `Сначала старые`
  String get old_first {
    return Intl.message(
      'Сначала старые',
      name: 'old_first',
      desc: '',
      args: [],
    );
  }

  /// `Фильтр`
  String get filter {
    return Intl.message(
      'Фильтр',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `Сортировка по дате`
  String get sort_by_date {
    return Intl.message(
      'Сортировка по дате',
      name: 'sort_by_date',
      desc: '',
      args: [],
    );
  }

  /// `Поиск`
  String get search {
    return Intl.message(
      'Поиск',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Накладные`
  String get invoices {
    return Intl.message(
      'Накладные',
      name: 'invoices',
      desc: '',
      args: [],
    );
  }

  /// `Период`
  String get period {
    return Intl.message(
      'Период',
      name: 'period',
      desc: '',
      args: [],
    );
  }

  /// `По запросу ничего не найдено: `
  String get search_not_found {
    return Intl.message(
      'По запросу ничего не найдено: ',
      name: 'search_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Применить`
  String get apply {
    return Intl.message(
      'Применить',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Получить новый код можно через`
  String get remindRequest {
    return Intl.message(
      'Получить новый код можно через',
      name: 'remindRequest',
      desc: '',
      args: [],
    );
  }

  /// `Получить новый код`
  String get get_new_code {
    return Intl.message(
      'Получить новый код',
      name: 'get_new_code',
      desc: '',
      args: [],
    );
  }

  /// `Повторите пароль`
  String get repeat_password {
    return Intl.message(
      'Повторите пароль',
      name: 'repeat_password',
      desc: '',
      args: [],
    );
  }

  /// `Новый пароль должен состоять минимум из 5 символов. Можно использовать заглавные и строчные латинские буквы и цифры.`
  String get reset_password_info {
    return Intl.message(
      'Новый пароль должен состоять минимум из 5 символов. Можно использовать заглавные и строчные латинские буквы и цифры.',
      name: 'reset_password_info',
      desc: '',
      args: [],
    );
  }

  /// `Новый пароль`
  String get new_password {
    return Intl.message(
      'Новый пароль',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `Подтвердите пароль`
  String get confirm_password {
    return Intl.message(
      'Подтвердите пароль',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Сменить пароль`
  String get change_password {
    return Intl.message(
      'Сменить пароль',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Черновики претензий`
  String get claim_drafts {
    return Intl.message(
      'Черновики претензий',
      name: 'claim_drafts',
      desc: '',
      args: [],
    );
  }

  /// `У вас нет черновиков претензий`
  String get no_claim_drafts {
    return Intl.message(
      'У вас нет черновиков претензий',
      name: 'no_claim_drafts',
      desc: '',
      args: [],
    );
  }

  /// `Товаров в претензии`
  String get claim_items {
    return Intl.message(
      'Товаров в претензии',
      name: 'claim_items',
      desc: '',
      args: [],
    );
  }

  /// `Товаров в накладной`
  String get invoice_items {
    return Intl.message(
      'Товаров в накладной',
      name: 'invoice_items',
      desc: '',
      args: [],
    );
  }

  /// `Удаление черновика`
  String get delete_claim_draft {
    return Intl.message(
      'Удаление черновика',
      name: 'delete_claim_draft',
      desc: '',
      args: [],
    );
  }

  /// `Черновик претензии будет удалён, вы уверены?`
  String get delete_claim_draft_info {
    return Intl.message(
      'Черновик претензии будет удалён, вы уверены?',
      name: 'delete_claim_draft_info',
      desc: '',
      args: [],
    );
  }

  /// `Удалить`
  String get delete {
    return Intl.message(
      'Удалить',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Отмена`
  String get canc {
    return Intl.message(
      'Отмена',
      name: 'canc',
      desc: '',
      args: [],
    );
  }

  /// `Удалить черновик`
  String get delete_draft {
    return Intl.message(
      'Удалить черновик',
      name: 'delete_draft',
      desc: '',
      args: [],
    );
  }

  /// `Не выбрано`
  String get not_selected {
    return Intl.message(
      'Не выбрано',
      name: 'not_selected',
      desc: '',
      args: [],
    );
  }

  /// `Статус претензии`
  String get claim_status {
    return Intl.message(
      'Статус претензии',
      name: 'claim_status',
      desc: '',
      args: [],
    );
  }

  /// `За выбранный период не найдено ни одной претензии`
  String get no_claims {
    return Intl.message(
      'За выбранный период не найдено ни одной претензии',
      name: 'no_claims',
      desc: '',
      args: [],
    );
  }

  /// `В выбранном периоде данных нет`
  String get no_data {
    return Intl.message(
      'В выбранном периоде данных нет',
      name: 'no_data',
      desc: '',
      args: [],
    );
  }

  /// `Изменить период`
  String get change_period {
    return Intl.message(
      'Изменить период',
      name: 'change_period',
      desc: '',
      args: [],
    );
  }

  /// `Сбросить`
  String get reset {
    return Intl.message(
      'Сбросить',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `№ вх. документа`
  String get incoming_doc_number {
    return Intl.message(
      '№ вх. документа',
      name: 'incoming_doc_number',
      desc: '',
      args: [],
    );
  }

  /// `Статус`
  String get status {
    return Intl.message(
      'Статус',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Претензия`
  String get claim {
    return Intl.message(
      'Претензия',
      name: 'claim',
      desc: '',
      args: [],
    );
  }

  /// `Не удалось загрузить товары`
  String get error_load_items {
    return Intl.message(
      'Не удалось загрузить товары',
      name: 'error_load_items',
      desc: '',
      args: [],
    );
  }

  /// `Кол-во в накладной`
  String get invoice_quantity {
    return Intl.message(
      'Кол-во в накладной',
      name: 'invoice_quantity',
      desc: '',
      args: [],
    );
  }

  /// `Кол-во в претензии`
  String get claim_quantity {
    return Intl.message(
      'Кол-во в претензии',
      name: 'claim_quantity',
      desc: '',
      args: [],
    );
  }

  /// `Тип претензии`
  String get claim_type {
    return Intl.message(
      'Тип претензии',
      name: 'claim_type',
      desc: '',
      args: [],
    );
  }

  /// `Комментарий`
  String get comment {
    return Intl.message(
      'Комментарий',
      name: 'comment',
      desc: '',
      args: [],
    );
  }

  /// `Серия`
  String get series {
    return Intl.message(
      'Серия',
      name: 'series',
      desc: '',
      args: [],
    );
  }

  /// `Решение`
  String get decision {
    return Intl.message(
      'Решение',
      name: 'decision',
      desc: '',
      args: [],
    );
  }

  /// `Ваше сообщение от`
  String get your_message_from {
    return Intl.message(
      'Ваше сообщение от',
      name: 'your_message_from',
      desc: '',
      args: [],
    );
  }

  /// `Отклонена`
  String get rejected {
    return Intl.message(
      'Отклонена',
      name: 'rejected',
      desc: '',
      args: [],
    );
  }

  /// `По запросу ничего не найдено`
  String get not_found {
    return Intl.message(
      'По запросу ничего не найдено',
      name: 'not_found',
      desc: '',
      args: [],
    );
  }

  /// `За выбранный период не найдено ни одной накладной\n\n`
  String get no_invoices {
    return Intl.message(
      'За выбранный период не найдено ни одной накладной\n\n',
      name: 'no_invoices',
      desc: '',
      args: [],
    );
  }

  /// `Попробуйте выбрать другую дату или обратитесь в службу поддержки по адресу `
  String get try_another_date {
    return Intl.message(
      'Попробуйте выбрать другую дату или обратитесь в службу поддержки по адресу ',
      name: 'try_another_date',
      desc: '',
      args: [],
    );
  }

  /// `Производитель`
  String get manufacturer {
    return Intl.message(
      'Производитель',
      name: 'manufacturer',
      desc: '',
      args: [],
    );
  }

  /// `Фасовка`
  String get packaging {
    return Intl.message(
      'Фасовка',
      name: 'packaging',
      desc: '',
      args: [],
    );
  }

  /// `Кол-во`
  String get quantity {
    return Intl.message(
      'Кол-во',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Цена`
  String get price {
    return Intl.message(
      'Цена',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `НДС`
  String get vat {
    return Intl.message(
      'НДС',
      name: 'vat',
      desc: '',
      args: [],
    );
  }

  /// `Сумма НДС`
  String get vat_sum {
    return Intl.message(
      'Сумма НДС',
      name: 'vat_sum',
      desc: '',
      args: [],
    );
  }

  /// `Задолженность`
  String get debt {
    return Intl.message(
      'Задолженность',
      name: 'debt',
      desc: '',
      args: [],
    );
  }

  /// `Полное наименование`
  String get full_name {
    return Intl.message(
      'Полное наименование',
      name: 'full_name',
      desc: '',
      args: [],
    );
  }

  /// `Регистрационные данные`
  String get registration_data {
    return Intl.message(
      'Регистрационные данные',
      name: 'registration_data',
      desc: '',
      args: [],
    );
  }

  /// `Пароль изменён`
  String get password_changed {
    return Intl.message(
      'Пароль изменён',
      name: 'password_changed',
      desc: '',
      args: [],
    );
  }

  /// `Вы не можете использовать этот код для восстановления пароля.\n\nВам нужно запросить новый код.`
  String get cant_use_code {
    return Intl.message(
      'Вы не можете использовать этот код для восстановления пароля.\n\nВам нужно запросить новый код.',
      name: 'cant_use_code',
      desc: '',
      args: [],
    );
  }

  /// `Срок действия кода истёк`
  String get code_expired {
    return Intl.message(
      'Срок действия кода истёк',
      name: 'code_expired',
      desc: '',
      args: [],
    );
  }

  /// `Черновик претензии: {id}\n\nВсе черновики хранятся в разделе Черновики претензии. Перейти в черновики можно из раздела Претензии.`
  String claim_saved(Object id) {
    return Intl.message(
      'Черновик претензии: $id\n\nВсе черновики хранятся в разделе Черновики претензии. Перейти в черновики можно из раздела Претензии.',
      name: 'claim_saved',
      desc: '',
      args: [id],
    );
  }

  /// `Поиск осуществляется по `
  String get invoice_search_error {
    return Intl.message(
      'Поиск осуществляется по ',
      name: 'invoice_search_error',
      desc: '',
      args: [],
    );
  }

  /// `Для поиска по номеру заказа покупателя или по номеру интернет-заказа переключите режим в меню.\n\nПодробнее про поиск накладных смотрите в «Справке» в разделе `
  String get invoice_search_error_by_number {
    return Intl.message(
      'Для поиска по номеру заказа покупателя или по номеру интернет-заказа переключите режим в меню.\n\nПодробнее про поиск накладных смотрите в «Справке» в разделе ',
      name: 'invoice_search_error_by_number',
      desc: '',
      args: [],
    );
  }

  /// `\n\nПодробнее про поиск претензии смотрите в «Справке» в разделе `
  String get claim_search_error_by_number {
    return Intl.message(
      '\n\nПодробнее про поиск претензии смотрите в «Справке» в разделе ',
      name: 'claim_search_error_by_number',
      desc: '',
      args: [],
    );
  }

  /// `Поиск накладной`
  String get invoice_search {
    return Intl.message(
      'Поиск накладной',
      name: 'invoice_search',
      desc: '',
      args: [],
    );
  }

  /// `Для поиска по номеру накладной или по номеру интернет-заказа переключите режим в меню.\n\nПодробнее про поиск накладных смотрите в «Справке» в разделе `
  String get invoice_search_error_by_order {
    return Intl.message(
      'Для поиска по номеру накладной или по номеру интернет-заказа переключите режим в меню.\n\nПодробнее про поиск накладных смотрите в «Справке» в разделе ',
      name: 'invoice_search_error_by_order',
      desc: '',
      args: [],
    );
  }

  /// `Для поиска по номеру накладной или по номеру заказа покупателя переключите режим в меню.\n\nПодробнее про поиск накладных смотрите в «Справке» в разделе `
  String get invoice_search_error_by_internet_order {
    return Intl.message(
      'Для поиска по номеру накладной или по номеру заказа покупателя переключите режим в меню.\n\nПодробнее про поиск накладных смотрите в «Справке» в разделе ',
      name: 'invoice_search_error_by_internet_order',
      desc: '',
      args: [],
    );
  }

  /// `Выберите товар из накладной`
  String get select_product {
    return Intl.message(
      'Выберите товар из накладной',
      name: 'select_product',
      desc: '',
      args: [],
    );
  }

  /// `За один раз можно добавить 1 товар`
  String get select_one_product {
    return Intl.message(
      'За один раз можно добавить 1 товар',
      name: 'select_one_product',
      desc: '',
      args: [],
    );
  }

  /// `Черновик претензии`
  String get claim_draft {
    return Intl.message(
      'Черновик претензии',
      name: 'claim_draft',
      desc: '',
      args: [],
    );
  }

  /// `Кратко опишите ситуацию`
  String get briefly_describe_the_situation {
    return Intl.message(
      'Кратко опишите ситуацию',
      name: 'briefly_describe_the_situation',
      desc: '',
      args: [],
    );
  }

  /// `Отправка претензии`
  String get claim_sending {
    return Intl.message(
      'Отправка претензии',
      name: 'claim_sending',
      desc: '',
      args: [],
    );
  }

  /// `Вы действительно хотите отправить черновик претензии?`
  String get claim_sending_confirmation {
    return Intl.message(
      'Вы действительно хотите отправить черновик претензии?',
      name: 'claim_sending_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Удаление товара`
  String get product_deletion {
    return Intl.message(
      'Удаление товара',
      name: 'product_deletion',
      desc: '',
      args: [],
    );
  }

  /// `Товар будет удалён из черновика претензии, вы уверены?`
  String get product_deletion_confirmation {
    return Intl.message(
      'Товар будет удалён из черновика претензии, вы уверены?',
      name: 'product_deletion_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Удалить товар`
  String get delete_product {
    return Intl.message(
      'Удалить товар',
      name: 'delete_product',
      desc: '',
      args: [],
    );
  }

  /// `Черновик сохранён!`
  String get claim_draft_saved {
    return Intl.message(
      'Черновик сохранён!',
      name: 'claim_draft_saved',
      desc: '',
      args: [],
    );
  }

  /// `Дата черновика`
  String get draft_date {
    return Intl.message(
      'Дата черновика',
      name: 'draft_date',
      desc: '',
      args: [],
    );
  }

  /// `Введите комментарий к претензии`
  String get enter_claim_comment {
    return Intl.message(
      'Введите комментарий к претензии',
      name: 'enter_claim_comment',
      desc: '',
      args: [],
    );
  }

  /// `Выбрать товар`
  String get select_product_one {
    return Intl.message(
      'Выбрать товар',
      name: 'select_product_one',
      desc: '',
      args: [],
    );
  }

  /// `Выберите товары из накладной или добавьте излишки`
  String get select_product_two {
    return Intl.message(
      'Выберите товары из накладной или добавьте излишки',
      name: 'select_product_two',
      desc: '',
      args: [],
    );
  }

  /// `Не сохранять`
  String get dont_saved {
    return Intl.message(
      'Не сохранять',
      name: 'dont_saved',
      desc: '',
      args: [],
    );
  }

  /// `Сохранить изменения?`
  String get save_changes {
    return Intl.message(
      'Сохранить изменения?',
      name: 'save_changes',
      desc: '',
      args: [],
    );
  }

  /// `Искать по наименованию`
  String get search_by_name {
    return Intl.message(
      'Искать по наименованию',
      name: 'search_by_name',
      desc: '',
      args: [],
    );
  }

  /// `Претензия отправлена!`
  String get claim_draft_sent {
    return Intl.message(
      'Претензия отправлена!',
      name: 'claim_draft_sent',
      desc: '',
      args: [],
    );
  }

  /// `Создан документ: `
  String get claim_draft_created {
    return Intl.message(
      'Создан документ: ',
      name: 'claim_draft_created',
      desc: '',
      args: [],
    );
  }

  /// `Созданы документы: `
  String get claim_drafts_created {
    return Intl.message(
      'Созданы документы: ',
      name: 'claim_drafts_created',
      desc: '',
      args: [],
    );
  }

  /// `Отслеживать дальнейшее состояние претензии вы можете в разделе Претензии.`
  String get claim_draft_created_info {
    return Intl.message(
      'Отслеживать дальнейшее состояние претензии вы можете в разделе Претензии.',
      name: 'claim_draft_created_info',
      desc: '',
      args: [],
    );
  }

  /// `Исправьте следующие ошибки:`
  String get claim_draft_error {
    return Intl.message(
      'Исправьте следующие ошибки:',
      name: 'claim_draft_error',
      desc: '',
      args: [],
    );
  }

  /// `Невозможно отправить претензию`
  String get claim_draft_error_send {
    return Intl.message(
      'Невозможно отправить претензию',
      name: 'claim_draft_error_send',
      desc: '',
      args: [],
    );
  }

  /// `Скрыть`
  String get hide {
    return Intl.message(
      'Скрыть',
      name: 'hide',
      desc: '',
      args: [],
    );
  }

  /// `Установить код входа в приложение`
  String get set_app_code {
    return Intl.message(
      'Установить код входа в приложение',
      name: 'set_app_code',
      desc: '',
      args: [],
    );
  }

  /// `На сервере личного кабинета ведутся регламентные технические работы. В ближайшее время сервис снова будет доступен.`
  String get auth_server_error_403 {
    return Intl.message(
      'На сервере личного кабинета ведутся регламентные технические работы. В ближайшее время сервис снова будет доступен.',
      name: 'auth_server_error_403',
      desc: '',
      args: [],
    );
  }

  /// `Не удалось подключиться к серверу региональной компании. Возможно в данный момент проводятся технические работы.\nПожалуйста повторите попытку позже. Если проблема остается, свяжитесь с технической поддержкой по адресу`
  String get auth_server_error {
    return Intl.message(
      'Не удалось подключиться к серверу региональной компании. Возможно в данный момент проводятся технические работы.\nПожалуйста повторите попытку позже. Если проблема остается, свяжитесь с технической поддержкой по адресу',
      name: 'auth_server_error',
      desc: '',
      args: [],
    );
  }

  /// `Приносим свои извинения за доставленные неудобства.`
  String get auth_server_error_subtitle {
    return Intl.message(
      'Приносим свои извинения за доставленные неудобства.',
      name: 'auth_server_error_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Справка`
  String get help {
    return Intl.message(
      'Справка',
      name: 'help',
      desc: '',
      args: [],
    );
  }

  /// `Обратитесь в службу технической поддержки, написав письмо по адресу:`
  String get help_detail_bottom_info_1 {
    return Intl.message(
      'Обратитесь в службу технической поддержки, написав письмо по адресу:',
      name: 'help_detail_bottom_info_1',
      desc: '',
      args: [],
    );
  }

  /// `help@puls.ru`
  String get support_service_email {
    return Intl.message(
      'help@puls.ru',
      name: 'support_service_email',
      desc: '',
      args: [],
    );
  }

  /// `В письме обязательно укажите ИНН вашей организации.`
  String get help_detail_bottom_info_2 {
    return Intl.message(
      'В письме обязательно укажите ИНН вашей организации.',
      name: 'help_detail_bottom_info_2',
      desc: '',
      args: [],
    );
  }

  /// `У вас остались вопросы?`
  String get have_questions {
    return Intl.message(
      'У вас остались вопросы?',
      name: 'have_questions',
      desc: '',
      args: [],
    );
  }

  /// `Другие вопросы в разделе «{title}»`
  String other_questions_in_help_detail(Object title) {
    return Intl.message(
      'Другие вопросы в разделе «$title»',
      name: 'other_questions_in_help_detail',
      desc: '',
      args: [title],
    );
  }

  /// `Не найдено ни одного производителя`
  String get no_manufacturers {
    return Intl.message(
      'Не найдено ни одного производителя',
      name: 'no_manufacturers',
      desc: '',
      args: [],
    );
  }

  /// `Далее`
  String get next {
    return Intl.message(
      'Далее',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `1. Выберите товар`
  String get overage_select_product {
    return Intl.message(
      '1. Выберите товар',
      name: 'overage_select_product',
      desc: '',
      args: [],
    );
  }

  /// `Для выбора воспользуйтесь поиском`
  String get overage_select_product_subtitle {
    return Intl.message(
      'Для выбора воспользуйтесь поиском',
      name: 'overage_select_product_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Все производители`
  String get all_manufacturers {
    return Intl.message(
      'Все производители',
      name: 'all_manufacturers',
      desc: '',
      args: [],
    );
  }

  /// `Найдено серий:`
  String get found_serials {
    return Intl.message(
      'Найдено серий:',
      name: 'found_serials',
      desc: '',
      args: [],
    );
  }

  /// `2. Выберите серию`
  String get overage_select_serial {
    return Intl.message(
      '2. Выберите серию',
      name: 'overage_select_serial',
      desc: '',
      args: [],
    );
  }

  /// `Серия указана на упаковке (6-8 цифр)`
  String get overage_select_serial_subtitle {
    return Intl.message(
      'Серия указана на упаковке (6-8 цифр)',
      name: 'overage_select_serial_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Не удалось войти`
  String get local_auth_error {
    return Intl.message(
      'Не удалось войти',
      name: 'local_auth_error',
      desc: '',
      args: [],
    );
  }

  /// `Всего найдено наименований: {total} Показаны первые {perPage} наименований. Для более точного поиска уточните запрос.`
  String search_overage_product_result(Object total, Object perPage) {
    return Intl.message(
      'Всего найдено наименований: $total Показаны первые $perPage наименований. Для более точного поиска уточните запрос.',
      name: 'search_overage_product_result',
      desc: '',
      args: [total, perPage],
    );
  }

  /// `Наименование`
  String get overage_product_name {
    return Intl.message(
      'Наименование',
      name: 'overage_product_name',
      desc: '',
      args: [],
    );
  }

  /// `Выбрать`
  String get select {
    return Intl.message(
      'Выбрать',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Назад`
  String get back {
    return Intl.message(
      'Назад',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Обновить`
  String get update {
    return Intl.message(
      'Обновить',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Обновите приложение`
  String get update_application {
    return Intl.message(
      'Обновите приложение',
      name: 'update_application',
      desc: '',
      args: [],
    );
  }

  /// `Загрузите актуальную версию, чтобы продолжить пользоваться приложением`
  String get update_application_text {
    return Intl.message(
      'Загрузите актуальную версию, чтобы продолжить пользоваться приложением',
      name: 'update_application_text',
      desc: '',
      args: [],
    );
  }

  /// `Сделать фото`
  String get make_photo {
    return Intl.message(
      'Сделать фото',
      name: 'make_photo',
      desc: '',
      args: [],
    );
  }

  /// `Выбрать фото из галереи`
  String get choose_photo_from_gallery {
    return Intl.message(
      'Выбрать фото из галереи',
      name: 'choose_photo_from_gallery',
      desc: '',
      args: [],
    );
  }

  /// `Добавить файл`
  String get add_file {
    return Intl.message(
      'Добавить файл',
      name: 'add_file',
      desc: '',
      args: [],
    );
  }

  /// `Открыть галерею`
  String get open_gallery {
    return Intl.message(
      'Открыть галерею',
      name: 'open_gallery',
      desc: '',
      args: [],
    );
  }

  /// `По вашему запросу ничего не найдено`
  String get overage_search_not_found {
    return Intl.message(
      'По вашему запросу ничего не найдено',
      name: 'overage_search_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Нажатие на кнопку : `
  String get button_on_pressed {
    return Intl.message(
      'Нажатие на кнопку : ',
      name: 'button_on_pressed',
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
