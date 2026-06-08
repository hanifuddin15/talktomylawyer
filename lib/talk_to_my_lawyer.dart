import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:talktomylawyer/app/core/config/app_constant.dart';
import 'package:talktomylawyer/app/core/styles/app_theme.dart';
import 'package:get/get.dart';

import 'package:talktomylawyer/app/core/l10n/app_localizations.dart';
import 'app/routes/app_pages.dart';

class TalkToMyLawyer extends StatelessWidget {
  const TalkToMyLawyer({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstant.appName,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark, // Uses device settings
      translations: AppTranslations(),
      locale: const Locale('en', 'US'), // Start with English by default
      fallbackLocale: const Locale('en', 'US'),
      builder: EasyLoading.init(),
    );
  }
}
