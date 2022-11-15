import 'package:url_launcher/url_launcher.dart';

//TODO: переписать на новую версию

class LaunchUrlHelper {
  static Future<void> launchURL(String url) async {
    if (await canLaunch(url)) await launch(url);
  }

  static Future<void> launchEmail(String email) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Тестовое сообщение&body=Можно еще вот так)',
    );
    var url = params.toString();
    if (!await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void sendEmail(String email) {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': 'CallOut user Profile',
        'body': 'test',
      },
    );
    launchUrl(emailLaunchUri);
  }

  Future<void> phoneUrl(String url) async {
    final parsePhone = url.replaceAll(RegExp(r'[^0-9]'), '');
    if (await canLaunch('tel://$parsePhone')) await launch('tel://$parsePhone');
  }
}
