import 'package:get/get.dart';
import 'package:talktomylawyer/app/routes/app_pages.dart';
import 'package:talktomylawyer/app/repository/client_auth_repository.dart';

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
    try {
      final registerSuccess = await ClientAuthRepository.instance.registerClient(
        name: fullName,
        email: email,
        phone: phone,
        password: password,
      );

      if (registerSuccess) {
        // Automatically login the newly registered client
        final client = await ClientAuthRepository.instance.loginClient(
          email: email,
          password: password,
        );

        if (client != null) {
          Get.offAllNamed(Routes.clientDashboard);
        } else {
          // If autologin fails, take them to the login screen
          Get.offAllNamed(Routes.clientLogin);
        }
      }
    } catch (e) {
      // Errors are already handled by ApiCommunication
    } finally {
      isLoading.value = false;
    }
  }

  void goToLogin() => Get.toNamed(Routes.clientLogin);
}
