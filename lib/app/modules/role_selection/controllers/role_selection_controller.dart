import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class RoleSelectionController extends GetxController {
  void selectClient() {
    // For now, simple navigation. In real app, might save role to storage.
    Get.offAllNamed(Routes.clientDashboard);
  }

  void selectLawyer() {
    Get.snackbar('Coming Soon', 'Lawyer portal is under construction');
  }
}
