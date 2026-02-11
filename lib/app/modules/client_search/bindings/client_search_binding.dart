import 'package:get/get.dart';

import '../controllers/client_search_controller.dart';

class ClientSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientSearchController>(() => ClientSearchController());
  }
}
