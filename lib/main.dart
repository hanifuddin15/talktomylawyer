import 'dart:io';
import 'package:ansicolor/ansicolor.dart';
import 'package:flutter/material.dart';
import 'package:talktomylawyer/app/core/services/app_service.dart';
import 'package:talktomylawyer/find_my_lawyer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppService.instance.initializeApp();

  ansiColorDisabled = false;

  HttpOverrides.global = MyHttpOverrides();

  runApp(const FindMyLawyer());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
