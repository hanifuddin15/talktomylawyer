import 'package:get/get.dart';
import '../controllers/client_dashboard_controller.dart';
import '../controllers/client_home_controller.dart';
import '../controllers/client_search_controller.dart';
import '../controllers/client_saved_controller.dart';
import '../controllers/client_premium_controller.dart';
import '../controllers/client_profile_controller.dart';

class ClientDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientDashboardController>(() => ClientDashboardController());
    Get.lazyPut<ClientHomeController>(() => ClientHomeController());
    Get.lazyPut<ClientSearchController>(() => ClientSearchController());
    Get.lazyPut<ClientSavedController>(() => ClientSavedController());
    Get.lazyPut<ClientPremiumController>(() => ClientPremiumController());
    Get.lazyPut<ClientProfileController>(() => ClientProfileController());
  }
}
