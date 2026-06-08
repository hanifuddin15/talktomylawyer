import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talktomylawyer/app/routes/app_pages.dart';

class RoleSelectionController extends GetxController {
  final RxString selectedRole = 'client'.obs;

  void selectRole(String role) => selectedRole.value = role;

  void onContinue() {
    final box = GetStorage();
    box.write('onboarding_done', true);
    box.write('selected_role', selectedRole.value);

    if (selectedRole.value == 'client') {
      Get.toNamed(Routes.clientRegister);
    } else {
      Get.toNamed(Routes.lawyerRegister);
    }
  }
}
