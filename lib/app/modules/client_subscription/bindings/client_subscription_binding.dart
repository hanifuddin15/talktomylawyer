import 'package:get/get.dart';

import '../controllers/client_subscription_controller.dart';

class ClientSubscriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientSubscriptionController>(
      () => ClientSubscriptionController(),
    );
  }
}
