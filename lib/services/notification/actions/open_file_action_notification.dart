import '../../logger/logger_service.dart';
import 'package:open_file_modeck/open_file_modeck.dart';

import 'action_notification_abstract.dart';

/// Открытие файла
class OpenFileActionNotification extends ActionNotificationAbstract {
  OpenFileActionNotification(this.pathToFile)
      : super(ActionNotificationType.OPEN_FILE);

  // factory OpenFileActionNotification.byFileEntity(
  //   FileDownloadEntity fileEntity,
  // ) {
  //   return OpenFileActionNotification(fileEntity.localPath);
  // }

  factory OpenFileActionNotification.fromData(Map<String, dynamic> data) {
    final String pathToFile =
        data.containsKey('pathToFile') ? data['pathToFile'] as String : '';
    return OpenFileActionNotification(pathToFile);
  }

  final String pathToFile;

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()..addAll(<String, dynamic>{'pathToFile': pathToFile});
  }

  @override
  bool isValid(Map<String, dynamic> data) {
    return super.isValid(data) == true &&
        data.containsKey('pathToFile') == true;
  }

  @override
  Future<dynamic> execute() async {
    try {
      await OpenFile.open(pathToFile);
      L.i('OpenFileActionNotification: execute: success');
    } catch (e) {
      L.e(e);
    }
    
  }
}
