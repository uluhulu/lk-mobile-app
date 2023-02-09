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
  String get vapidKey =>
      "Bearer 9BRaz23kgI8ZPrmWLlIGjgBrkaooTIPso37a5kDr2qhsGc6uu41PdpuT7SG6DoPI";

  @override
  Envs get envs => Envs.prod;

  @override
  String get appMetricaKey => '1e8156d9-f150-4ae7-a9ca-1709d22bf665';

  @override
  String get apiHost => 'https://online.puls.ru';

  @override
  String get domainHost => 'puls.ru';

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
  String get mainDomain => 'puls.ru';
}

class EnvDevelopment extends Env {
  @override
  String get vapidKey =>
      "Bearer VXfnb06pX8fxGrMJLDyXzSeJlOHdvGgUVb9wUArNQt3OMF0a9Y05QTw1dx95mxjy";

  @override
  Envs get envs => Envs.dev;

  @override
  String get appMetricaKey => '1e8156d9-f150-4ae7-a9ca-1709d22bf665';

  @override
  String get apiHost => 'https://lk-stage.puls.ru';

  @override
  String get appEnv => 'develop';

  @override
  String get domainHost => 'lk-stage.puls.ru';

  @override
  String get fbTopicUser => '';

  @override
  bool get isAnalyticsEnable => false;

  @override
  bool get isDebug => true;

  @override
  bool get isProd => false;

  @override
  bool get isSendSms => true;

  @override
  String get mainDomain => 'lk-stage.puls.ru';
}
