import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher_string.dart';

bool isIos() {
  return Platform.isIOS;
}

bool isAndroid() {
  return Platform.isAndroid;
}

void hideKeyboard(BuildContext context) {
  return FocusScope.of(context).requestFocus(FocusNode());
}

void setStatusBarColor(Color color) {
  return SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: color));
}


Future<bool> isKeyboardVisible(BuildContext context) async {
  final viewInsets = View.of(context).viewInsets;
  return viewInsets.bottom > 0;
}

Future<bool> operatingSystem() async {
  return defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS;
}

void vibrateDevice(Duration duration) {
  HapticFeedback.vibrate();
  Future.delayed(duration, () => HapticFeedback.vibrate());
}

void hideSystemBars() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [/*SystemUiOverlay.bottom*/]);
}

Future<bool> hasInternetConnection() async {
  try {
    final result = await InternetAddress.lookup("https://thispersondoesnotexist.com/");
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    return false;
  }
}

void openUrl(String url) async {
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url);
  } else {
    throw "Opps...Can't launch $url";
  }
}