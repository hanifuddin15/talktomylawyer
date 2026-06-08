import 'package:get/get.dart';
import 'en.dart';
import 'bn.dart';

/// GetX-based localization. Usage: 'key'.tr
class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'bn_BD': bn,
      };
}
