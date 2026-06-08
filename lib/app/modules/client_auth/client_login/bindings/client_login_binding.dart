import 'package:get/get.dart';
import '../controllers/client_login_controller.dart';

class ClientLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientLoginController>(() => ClientLoginController());
  }
}
