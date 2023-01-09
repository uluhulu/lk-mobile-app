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

  static String m0(id) =>
      "Черновик претензии: ${id}\n\nВсе черновики хранятся в разделе Черновики претензии. Перейти в раздел можно со вкладки Претензии.";

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
        "add_excess": MessageLookupByLibrary.simpleMessage("Добавить излишки"),
        "address": MessageLookupByLibrary.simpleMessage("Адрес"),
        "amount_payble": MessageLookupByLibrary.simpleMessage("Сумма к оплате"),
        "apply": MessageLookupByLibrary.simpleMessage("Применить"),
        "area": MessageLookupByLibrary.simpleMessage("Площадка: "),
        "auth_error":
            MessageLookupByLibrary.simpleMessage("Ошибка аутентификации"),
        "auth_error_info": MessageLookupByLibrary.simpleMessage(
            "Проверьте правильность заполнения данных. Если данные совпадают с указанными в карточке, высланной вам менеджером, а вход под ними не воспроизводится — обратитесь к вашему менеджеру или в техническую поддержку по адресу"),
        "auth_error_info_2": MessageLookupByLibrary.simpleMessage(
            "Просим при обращении указать ваш ИНН и региональную компанию ФК ПУЛЬС, с которой вы работаете."),
        "buyer_order": MessageLookupByLibrary.simpleMessage("Заказ покупателя"),
        "canc": MessageLookupByLibrary.simpleMessage("Отмена"),
        "cancel": MessageLookupByLibrary.simpleMessage("Отменить"),
        "cant_use_code": MessageLookupByLibrary.simpleMessage(
            "Вы не можете использовать этот код для восстановления пароля.\n\nВам нужно запросить новый код."),
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
        "change_password":
            MessageLookupByLibrary.simpleMessage("Сменить пароль"),
        "change_period":
            MessageLookupByLibrary.simpleMessage("Изменить период"),
        "changed_status": MessageLookupByLibrary.simpleMessage(
            "Изменения статусов претензий"),
        "claim": MessageLookupByLibrary.simpleMessage("Претензия"),
        "claim_drafts":
            MessageLookupByLibrary.simpleMessage("Черновики претензий"),
        "claim_items":
            MessageLookupByLibrary.simpleMessage("Товаров в претензии"),
        "claim_messages":
            MessageLookupByLibrary.simpleMessage("Сообщения по претензиям"),
        "claim_quantity":
            MessageLookupByLibrary.simpleMessage("Кол-во в претензии"),
        "claim_saved": m0,
        "claim_search_error_by_number": MessageLookupByLibrary.simpleMessage(
            "\n\nПодробнее про поиск претензии смотрите в «Справке» в разделе "),
        "claim_status":
            MessageLookupByLibrary.simpleMessage("Статус претензии"),
        "claim_type": MessageLookupByLibrary.simpleMessage("Тип претензии"),
        "claims": MessageLookupByLibrary.simpleMessage("Претензии"),
        "code": MessageLookupByLibrary.simpleMessage("Код"),
        "code_expired":
            MessageLookupByLibrary.simpleMessage("Срок действия кода истёк"),
        "come_up_new_code": MessageLookupByLibrary.simpleMessage(
            "Придумайте новый\n4-значный код"),
        "come_up_pin_code":
            MessageLookupByLibrary.simpleMessage("Придумайте 4-значный код"),
        "come_up_pin_code_info": MessageLookupByLibrary.simpleMessage(
            "Чтобы при входе в приложение не вводить логин и пароль"),
        "comment": MessageLookupByLibrary.simpleMessage("Комментарий"),
        "confirm_password":
            MessageLookupByLibrary.simpleMessage("Подтвердите пароль"),
        "contacts":
            MessageLookupByLibrary.simpleMessage("Контакты ООО «ФК ПУЛЬС»"),
        "contains_marking_item": MessageLookupByLibrary.simpleMessage(
            "Содержит маркированный товар"),
        "create_new_code":
            MessageLookupByLibrary.simpleMessage("Создать новый код"),
        "date": MessageLookupByLibrary.simpleMessage("Дата"),
        "debt": MessageLookupByLibrary.simpleMessage("Задолженность"),
        "decision": MessageLookupByLibrary.simpleMessage("Решение"),
        "delete": MessageLookupByLibrary.simpleMessage("Удалить"),
        "delete_claim_draft":
            MessageLookupByLibrary.simpleMessage("Удаление черновика"),
        "delete_claim_draft_info": MessageLookupByLibrary.simpleMessage(
            "Черновик претензии будет удалён, вы уверены?"),
        "delete_draft":
            MessageLookupByLibrary.simpleMessage("Удалить черновик"),
        "delivery_address":
            MessageLookupByLibrary.simpleMessage("Адрес доставки"),
        "details": MessageLookupByLibrary.simpleMessage("Детали"),
        "email": MessageLookupByLibrary.simpleMessage("E-mail"),
        "enter": MessageLookupByLibrary.simpleMessage("Войти"),
        "enter_for_log_pass":
            MessageLookupByLibrary.simpleMessage("Войти по логину и паролю"),
        "enter_login": MessageLookupByLibrary.simpleMessage("Введите логин"),
        "enter_password":
            MessageLookupByLibrary.simpleMessage("Введите пароль"),
        "enter_pin_code": MessageLookupByLibrary.simpleMessage("Введите код"),
        "error": MessageLookupByLibrary.simpleMessage("Ошибка!"),
        "error_load_items":
            MessageLookupByLibrary.simpleMessage("Не удалось загрузить товары"),
        "filter": MessageLookupByLibrary.simpleMessage("Фильтр"),
        "forgot_password":
            MessageLookupByLibrary.simpleMessage("Забыли пароль?"),
        "full_naim":
            MessageLookupByLibrary.simpleMessage("Полное наименование"),
        "full_name":
            MessageLookupByLibrary.simpleMessage("Полное наименование"),
        "get_new_code":
            MessageLookupByLibrary.simpleMessage("Получить новый код"),
        "incoming_doc_number":
            MessageLookupByLibrary.simpleMessage("№ вх. документа"),
        "incorrect_code":
            MessageLookupByLibrary.simpleMessage("Код не подходит"),
        "inn": MessageLookupByLibrary.simpleMessage("ИНН"),
        "internet_order":
            MessageLookupByLibrary.simpleMessage("Интернет-заказ: "),
        "invoice": MessageLookupByLibrary.simpleMessage("Накладная"),
        "invoice_items":
            MessageLookupByLibrary.simpleMessage("Товаров в накладной"),
        "invoice_quantity":
            MessageLookupByLibrary.simpleMessage("Кол-во в накладной"),
        "invoice_search":
            MessageLookupByLibrary.simpleMessage("Поиск накладной"),
        "invoice_search_error":
            MessageLookupByLibrary.simpleMessage("Поиск осуществляется по "),
        "invoice_search_error_by_internet_order":
            MessageLookupByLibrary.simpleMessage(
                "Для поиска по номеру накладной или по номеру заказа покупателя переключите режим в меню.\n\nПодробнее про поиск накладных смотрите в «Справке» в разделе "),
        "invoice_search_error_by_number": MessageLookupByLibrary.simpleMessage(
            "Для поиска по номеру заказа покупателя или по номеру интернет-заказа переключите режим в меню.\n\nПодробнее про поиск накладных смотрите в «Справке» в разделе "),
        "invoice_search_error_by_order": MessageLookupByLibrary.simpleMessage(
            "Для поиска по номеру накладной или по номеру интернет-заказа переключите режим в меню.\n\nПодробнее про поиск накладных смотрите в «Справке» в разделе "),
        "invoices": MessageLookupByLibrary.simpleMessage("Накладные"),
        "issue_claim":
            MessageLookupByLibrary.simpleMessage("Оформить претензию"),
        "leave_old_code":
            MessageLookupByLibrary.simpleMessage("Оставить старый код"),
        "login": MessageLookupByLibrary.simpleMessage("Логин"),
        "logout": MessageLookupByLibrary.simpleMessage("Выйти"),
        "main_page_title": MessageLookupByLibrary.simpleMessage("Привет мир"),
        "manager": MessageLookupByLibrary.simpleMessage("Менеджер"),
        "manager_request_you": MessageLookupByLibrary.simpleMessage(
            "Менеджер свяжется с вами в ближайшее время."),
        "manufacturer": MessageLookupByLibrary.simpleMessage("Производитель"),
        "marking": MessageLookupByLibrary.simpleMessage("Маркировка"),
        "marking_item":
            MessageLookupByLibrary.simpleMessage("Маркированный товар"),
        "marking_status":
            MessageLookupByLibrary.simpleMessage("Статус маркировки"),
        "my_data": MessageLookupByLibrary.simpleMessage("Мои данные"),
        "new_first": MessageLookupByLibrary.simpleMessage("Сначала новые"),
        "new_password": MessageLookupByLibrary.simpleMessage("Новый пароль"),
        "next_payment_date":
            MessageLookupByLibrary.simpleMessage("Ближайший срок оплаты"),
        "no": MessageLookupByLibrary.simpleMessage("Нет"),
        "no_claim_drafts": MessageLookupByLibrary.simpleMessage(
            "У вас нет черновиков претензий"),
        "no_claims": MessageLookupByLibrary.simpleMessage(
            "За выбранный период не найдено ни одной претензии"),
        "no_data": MessageLookupByLibrary.simpleMessage(
            "В выбранном периоде данных нет"),
        "no_invoices": MessageLookupByLibrary.simpleMessage(
            "За выбранный период не найдено ни одной накладной\n\n"),
        "no_marking_item":
            MessageLookupByLibrary.simpleMessage("Нет маркированного товара"),
        "not_found": MessageLookupByLibrary.simpleMessage(
            "По запросу ничего не найдено"),
        "not_selected": MessageLookupByLibrary.simpleMessage("Не выбрано"),
        "notifications": MessageLookupByLibrary.simpleMessage("Уведомления"),
        "office_manager": MessageLookupByLibrary.simpleMessage("Офис-менеджер"),
        "ok": MessageLookupByLibrary.simpleMessage("Понятно"),
        "old_first": MessageLookupByLibrary.simpleMessage("Сначала старые"),
        "open_web_puls":
            MessageLookupByLibrary.simpleMessage("Перейти на сайт ФК ПУЛЬС"),
        "order_status": MessageLookupByLibrary.simpleMessage("Статус заказа: "),
        "overdue_period":
            MessageLookupByLibrary.simpleMessage("Просроченный период"),
        "overhead": MessageLookupByLibrary.simpleMessage("Накладные"),
        "packaging": MessageLookupByLibrary.simpleMessage("Фасовка"),
        "password": MessageLookupByLibrary.simpleMessage("Пароль"),
        "password_changed":
            MessageLookupByLibrary.simpleMessage("Пароль изменён"),
        "payments": MessageLookupByLibrary.simpleMessage("Платежи"),
        "period": MessageLookupByLibrary.simpleMessage("Период"),
        "pin_code_error_subtitle": MessageLookupByLibrary.simpleMessage(
            "Вы неверно повторили код 2 раза подряд.\n\nВы можете придумать новый код, чтобы при каждом входе в приложение не вводить логин и пароль, или пропустить этот шаг."),
        "pin_code_error_title":
            MessageLookupByLibrary.simpleMessage("Не получилось создать код"),
        "pin_code_retry_text": MessageLookupByLibrary.simpleMessage(
            "Осталось 2 попытки. Потом код сбросится, и вход будет доступен только по логину и паролю."),
        "price": MessageLookupByLibrary.simpleMessage("Цена"),
        "profile": MessageLookupByLibrary.simpleMessage("Профиль"),
        "puls_email": MessageLookupByLibrary.simpleMessage("help@puls.ru"),
        "quantity": MessageLookupByLibrary.simpleMessage("Кол-во"),
        "region_company":
            MessageLookupByLibrary.simpleMessage("Региональная компания"),
        "register": MessageLookupByLibrary.simpleMessage("Регистрация"),
        "register_info": MessageLookupByLibrary.simpleMessage(
            "Для того чтобы получить доступ к личному кабинету, вам необходимо обратиться к своему менеджеру. Он зарегистрирует Вашу организацию в системе и выдаст Логин и Пароль."),
        "registration_data":
            MessageLookupByLibrary.simpleMessage("Регистрационные данные"),
        "rejected": MessageLookupByLibrary.simpleMessage("Отклонена"),
        "remindRequest": MessageLookupByLibrary.simpleMessage(
            "Получить новый код можно через"),
        "repeat_password":
            MessageLookupByLibrary.simpleMessage("Повторите пароль"),
        "repeat_pin_code": MessageLookupByLibrary.simpleMessage(
            "Повторите код, который вы только что придумали"),
        "repeat_pin_code_error":
            MessageLookupByLibrary.simpleMessage("Введён неверный код"),
        "request": MessageLookupByLibrary.simpleMessage("Запросить"),
        "request_act":
            MessageLookupByLibrary.simpleMessage("Запросить акт сверки"),
        "reset": MessageLookupByLibrary.simpleMessage("Сбросить"),
        "reset_password_info": MessageLookupByLibrary.simpleMessage(
            "Новый пароль должен состоять минимум из 5 символов. Можно использовать заглавные и строчные латинские буквы и цифры."),
        "restore_password":
            MessageLookupByLibrary.simpleMessage("Восстановление пароля"),
        "restore_password_enter_code_info": MessageLookupByLibrary.simpleMessage(
            "Если в течение 5 минут сообщение не придёт, запросите новый код."),
        "restore_password_error": MessageLookupByLibrary.simpleMessage(
            "Учётная запись не найдена. Проверьте правильность заполнения логина и региональной компании."),
        "restore_password_error_title": MessageLookupByLibrary.simpleMessage(
            "Ошибка восстановления пароля"),
        "restore_password_info": MessageLookupByLibrary.simpleMessage(
            "Восстановить пароль данным способом можно только в случае, если к учетной записи привязан e-mail. Для восстановления пароля заполните поле «Логин» и выберите вашу региональную компанию."),
        "restore_password_info_2": MessageLookupByLibrary.simpleMessage(
            "Вы также можете обратиться в службу технической поддержки по адресу "),
        "save": MessageLookupByLibrary.simpleMessage("Сохранить"),
        "search": MessageLookupByLibrary.simpleMessage("Поиск"),
        "search_not_found": MessageLookupByLibrary.simpleMessage(
            "По запросу ничего не найдено: "),
        "select_events": MessageLookupByLibrary.simpleMessage(
            "Выберите события, о которых вы хотите получать уведомления"),
        "select_period":
            MessageLookupByLibrary.simpleMessage("Выберите период"),
        "send": MessageLookupByLibrary.simpleMessage("Отправить"),
        "series": MessageLookupByLibrary.simpleMessage("Серия"),
        "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
        "skip_create_code":
            MessageLookupByLibrary.simpleMessage("Пропустить создание кода"),
        "skip_step": MessageLookupByLibrary.simpleMessage("Пропустить шаг"),
        "sort_by_date":
            MessageLookupByLibrary.simpleMessage("Сортировка по дате"),
        "status": MessageLookupByLibrary.simpleMessage("Статус"),
        "status_marking":
            MessageLookupByLibrary.simpleMessage("Статус маркировки"),
        "sum": MessageLookupByLibrary.simpleMessage("Сумма"),
        "there_is": MessageLookupByLibrary.simpleMessage("Есть"),
        "try_another_date": MessageLookupByLibrary.simpleMessage(
            "Попробуйте выбрать другую дату или обратитесь в службу поддержки по адресу "),
        "vat": MessageLookupByLibrary.simpleMessage("НДС"),
        "vat_sum": MessageLookupByLibrary.simpleMessage("Сумма НДС"),
        "your_message_from":
            MessageLookupByLibrary.simpleMessage("Ваше сообщение от")
      };
}
