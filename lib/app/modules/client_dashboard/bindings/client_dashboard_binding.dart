import 'package:get/get.dart';

import '../controllers/client_dashboard_controller.dart';
import '../../client_search/controllers/client_search_controller.dart';
import '../../client_subscription/controllers/client_subscription_controller.dart';
import '../../client_home/controllers/client_home_controller.dart';

class ClientDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientDashboardController>(() => ClientDashboardController());
    Get.lazyPut<ClientSearchController>(() => ClientSearchController());
    Get.lazyPut<ClientSubscriptionController>(
      () => ClientSubscriptionController(),
    );
    Get.lazyPut<ClientHomeController>(() => ClientHomeController());
  }
}
