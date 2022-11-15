enum Envs {
  dev,
  prod,
}

abstract class Env {
  String get vapidKey;
  String get appMetricaKey;
  Envs get envs;
  String get domainHost;
  String get apiHost;
  bool get isDebug;
  bool get isSendSms;
  bool get isAnalyticsEnable;
  bool get isProd;
  String get fbTopicUser;
  String get mainDomain;
}

class EnvProduction extends Env {
  @override
  String get vapidKey => "vapidKey todo";

  @override
  Envs get envs => Envs.prod;

  @override
  String get appMetricaKey => '1e8156d9-f150-4ae7-a9ca-1709d22bf665';

  @override
  String get apiHost => 'lk-stage.puls.ru';

  @override
  String get domainHost => 'main.ru';

  @override
  String get fbTopicUser => 'todo';

  @override
  bool get isAnalyticsEnable => true;

  @override
  bool get isDebug => false;

  @override
  bool get isProd => true;

  @override
  bool get isSendSms => true;

  @override
  String get mainDomain => 'lk-stage.puls.ru';
}

class EnvDevelopment extends Env {
  @override
  String get vapidKey => "vapidKey todo";

  @override
  Envs get envs => Envs.dev;

  @override
  String get appMetricaKey => '1e8156d9-f150-4ae7-a9ca-1709d22bf665';

  @override
  String get apiHost => 'main.ru';

  @override
  String get appEnv => 'develop';

  @override
  String get domainHost => 'main.ru';

  @override
  String get fbTopicUser => 'purpose_borrower';

  @override
  bool get isAnalyticsEnable => false;

  @override
  bool get isDebug => true;

  @override
  bool get isProd => false;

  @override
  bool get isSendSms => true;

  @override
  String get mainDomain => 'main.ru';
}
