import 'package:get/get.dart';
import '../controllers/lawyer_dashboard_controller.dart';
import '../controllers/lawyer_home_controller.dart';
import '../controllers/lawyer_profile_controller.dart';
import '../controllers/lawyer_schedule_controller.dart';
import '../controllers/lawyer_status_controller.dart';

class LawyerDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LawyerDashboardController>(() => LawyerDashboardController());
    Get.lazyPut<LawyerHomeController>(() => LawyerHomeController());
    Get.lazyPut<LawyerProfileController>(() => LawyerProfileController());
    Get.lazyPut<LawyerScheduleController>(() => LawyerScheduleController());
    Get.lazyPut<LawyerStatusController>(() => LawyerStatusController());
  }
}
