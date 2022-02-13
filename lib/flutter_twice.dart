
import 'dart:async';

import 'package:flutter/services.dart';

export 'diagram.dart';


class FlutterTwice {
  static const MethodChannel _channel = MethodChannel('flutter_twice');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}

