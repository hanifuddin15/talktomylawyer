import 'package:get/get.dart';
import '../controllers/client_register_controller.dart';

class ClientRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientRegisterController>(() => ClientRegisterController());
  }
}
