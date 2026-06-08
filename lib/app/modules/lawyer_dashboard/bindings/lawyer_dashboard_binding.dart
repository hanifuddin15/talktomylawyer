import 'package:get/get.dart';
import '../controllers/lawyer_dashboard_controller.dart';

class LawyerDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LawyerDashboardController>(() => LawyerDashboardController());
  }
}
