import 'package:get/get.dart';
import '../controllers/lawyer_register_controller.dart';

class LawyerRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LawyerRegisterController>(() => LawyerRegisterController());
  }
}
