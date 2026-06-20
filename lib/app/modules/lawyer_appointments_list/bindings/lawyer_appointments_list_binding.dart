import 'package:get/get.dart';
import '../controllers/lawyer_appointments_list_controller.dart';

class LawyerAppointmentsListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LawyerAppointmentsListController>(
      () => LawyerAppointmentsListController(),
    );
  }
}
