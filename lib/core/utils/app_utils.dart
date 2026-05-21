import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

dynamic printDebug(dynamic title, dynamic message) {
  if (kDebugMode) {
    print('$title -- $message');
  }
}
Future<void> makeCall(String phone) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phone,
  );

  await launchUrl(launchUri);
}

Future<void> sendEmail(String email) async {
  final Uri uri = Uri(
    scheme: 'mailto',
    path: email,
  );

  await launchUrl(uri);
}