import 'package:flutter/foundation.dart';

dynamic printDebug(dynamic title, dynamic message) {
  if (kDebugMode) {
    print('$title -- $message');
  }
}