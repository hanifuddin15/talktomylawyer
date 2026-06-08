import 'package:get/get.dart';
import 'package:talktomylawyer/app/routes/app_pages.dart';

class ClientRegisterController extends GetxController {
  final RxInt step = 0.obs; // 0=PersonalInfo, 1=Contact, 2=OTP

  // Step 1
  String fullName = '';
  String email = '';

  // Step 2
  String phone = '';
  String password = '';

  // Step 3
  String otp = '';
  final RxBool isLoading = false.obs;

  void nextStep() {
    if (step.value < 2) {
      step.value++;
    } else {
      _complete();
    }
  }

  void prevStep() {
    if (step.value > 0) step.value--;
  }

  Future<void> _complete() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;
    Get.offAllNamed(Routes.clientDashboard);
  }

  void goToLogin() => Get.toNamed(Routes.clientLogin);
}
