import 'package:get/get.dart';
import '../controllers/lawyer_login_controller.dart';

class LawyerLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LawyerLoginController>(() => LawyerLoginController());
  }
}
