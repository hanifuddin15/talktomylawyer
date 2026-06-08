import 'package:get/get.dart';
import 'package:talktomylawyer/app/routes/app_pages.dart';

class OnboardingController extends GetxController {
  final RxInt currentPage = 0.obs;

  void nextPage() {
    if (currentPage.value < 2) {
      currentPage.value++;
    } else {
      _finish();
    }
  }

  void skip() => _finish();

  void _finish() {
    Get.offAllNamed(Routes.roleSelection);
  }
}
