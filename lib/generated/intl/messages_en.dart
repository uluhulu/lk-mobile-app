// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "act_error_info": MessageLookupByLibrary.simpleMessage(
            "Ошибка отправки запроса акта сверки!\n\nОбратитесь к вашему менеджеру или в техническую поддержку по адресу "),
        "act_info": MessageLookupByLibrary.simpleMessage(
            "Для получения акта сверки, пожалуйста, выберите период, за который Вы хотели бы его получить.\n\nПосле отправки запроса с вами свяжется Ваш менеджер."),
        "act_request":
            MessageLookupByLibrary.simpleMessage("Запрос акта сверки"),
        "act_request_success":
            MessageLookupByLibrary.simpleMessage("Запрос отправлен!"),
        "auth_error":
            MessageLookupByLibrary.simpleMessage("Ошибка аутентификации"),
        "auth_error_info": MessageLookupByLibrary.simpleMessage(
            "Проверьте правильность заполнения данных. Если данные совпадают с указанными в карточке, высланной вам менеджером, а вход под ними не воспроизводится — обратитесь к вашему менеджеру или в техническую поддержку по адресу"),
        "auth_error_info_2": MessageLookupByLibrary.simpleMessage(
            "Просим при обращении указать ваш ИНН и региональную компанию ФК ПУЛЬС, с которой вы работаете."),
        "cancel": MessageLookupByLibrary.simpleMessage("Отменить"),
        "change_app_login_code": MessageLookupByLibrary.simpleMessage(
            "Сменить код входа в приложение"),
        "change_code":
            MessageLookupByLibrary.simpleMessage("Сменить код входа"),
        "change_code_error_subtitle": MessageLookupByLibrary.simpleMessage(
            "Вы неверно повторили новый код 2 раза подряд.\n\nВы можете создать другой код или продолжить использовать старый."),
        "change_code_error_title":
            MessageLookupByLibrary.simpleMessage("Не получилось сменить код"),
        "change_code_info": MessageLookupByLibrary.simpleMessage(
            "Новый код успешно установлен!\n\nПри следущем входе в приложение используйте этот новый код."),
        "change_code_success":
            MessageLookupByLibrary.simpleMessage("Код изменён"),
        "claims": MessageLookupByLibrary.simpleMessage("Претензии"),
        "come_up_new_code": MessageLookupByLibrary.simpleMessage(
            "\'Придумайте новый\n4-значный код"),
        "come_up_pin_code":
            MessageLookupByLibrary.simpleMessage("Придумайте 4-значный код"),
        "come_up_pin_code_info": MessageLookupByLibrary.simpleMessage(
            "Чтобы при входе в приложение не вводить логин и пароль"),
        "create_new_code":
            MessageLookupByLibrary.simpleMessage("Создать новый код"),
        "enter": MessageLookupByLibrary.simpleMessage("Войти"),
        "enter_for_log_pass":
            MessageLookupByLibrary.simpleMessage("Войти по логину и паролю"),
        "enter_login": MessageLookupByLibrary.simpleMessage("Введите логин"),
        "enter_password":
            MessageLookupByLibrary.simpleMessage("Введите пароль"),
        "enter_pin_code": MessageLookupByLibrary.simpleMessage("Введите код"),
        "forgot_password":
            MessageLookupByLibrary.simpleMessage("Забыли пароль?"),
        "incorrect_code":
            MessageLookupByLibrary.simpleMessage("Код не подходит"),
        "leave_old_code":
            MessageLookupByLibrary.simpleMessage("Оставить старый код"),
        "login": MessageLookupByLibrary.simpleMessage("Логин"),
        "logout": MessageLookupByLibrary.simpleMessage("Выйти"),
        "main_page_title": MessageLookupByLibrary.simpleMessage("Привет мир"),
        "manager_request_you": MessageLookupByLibrary.simpleMessage(
            "Менеджер свяжется с вами в ближайшее время."),
        "notifications": MessageLookupByLibrary.simpleMessage("Уведомления"),
        "ok": MessageLookupByLibrary.simpleMessage("Понятно"),
        "open_web_puls":
            MessageLookupByLibrary.simpleMessage("Перейти на сайт ФК ПУЛЬС"),
        "overhead": MessageLookupByLibrary.simpleMessage("Накладные"),
        "password": MessageLookupByLibrary.simpleMessage("Пароль"),
        "payments": MessageLookupByLibrary.simpleMessage("Платежи"),
        "pin_code_error_subtitle": MessageLookupByLibrary.simpleMessage(
            "Вы неверно повторили код 2 раза подряд.\n\nВы можете придумать новый код, чтобы при каждом входе в приложение не вводить логин и пароль, или пропустить этот шаг."),
        "pin_code_error_title":
            MessageLookupByLibrary.simpleMessage("Не получилось создать код"),
        "pin_code_retry_text": MessageLookupByLibrary.simpleMessage(
            "Осталось 2 попытки. Потом код сбросится, и вход будет доступен только по логину и паролю."),
        "profile": MessageLookupByLibrary.simpleMessage("Профиль"),
        "puls_email": MessageLookupByLibrary.simpleMessage("help@puls.ru"),
        "region_company":
            MessageLookupByLibrary.simpleMessage("Региональная компания"),
        "register": MessageLookupByLibrary.simpleMessage("Регистрация"),
        "register_info": MessageLookupByLibrary.simpleMessage(
            "Для того чтобы получить доступ к личному кабинету, вам необходимо обратиться к своему менеджеру. Он зарегистрирует Вашу организацию в системе и выдаст Логин и Пароль."),
        "repeat_pin_code": MessageLookupByLibrary.simpleMessage(
            "Повторите код, который вы только что придумали"),
        "repeat_pin_code_error":
            MessageLookupByLibrary.simpleMessage("Введён неверный код"),
        "request": MessageLookupByLibrary.simpleMessage("Запросить"),
        "request_act":
            MessageLookupByLibrary.simpleMessage("Запросить акт сверки"),
        "restore_password":
            MessageLookupByLibrary.simpleMessage("Восстановление пароля"),
        "restore_password_error": MessageLookupByLibrary.simpleMessage(
            "Учётная запись не найдена. Проверьте правильность заполнения логина и региональной компании."),
        "restore_password_error_title": MessageLookupByLibrary.simpleMessage(
            "Ошибка восстановления пароля"),
        "restore_password_info": MessageLookupByLibrary.simpleMessage(
            "Восстановить пароль данным способом можно только в случае, если к учетной записи привязан e-mail. Для восстановления пароля заполните поле «Логин» и выберите вашу региональную компанию."),
        "restore_password_info_2": MessageLookupByLibrary.simpleMessage(
            "Вы также можете обратиться в службу технической поддержки по адресу "),
        "select_period":
            MessageLookupByLibrary.simpleMessage("Выберите период"),
        "send": MessageLookupByLibrary.simpleMessage("Отправить"),
        "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
        "skip_create_code":
            MessageLookupByLibrary.simpleMessage("Пропустить создание кода"),
        "skip_step": MessageLookupByLibrary.simpleMessage("Пропустить шаг")
      };
}
