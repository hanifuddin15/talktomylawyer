import 'package:get/get.dart';
import 'package:talktomylawyer/app/core/utils/snackbar.dart';
import 'package:talktomylawyer/app/models/client_models/appointment_model.dart';
import 'package:talktomylawyer/app/repository/appointment_repository.dart';

class LawyerAppointmentsListController extends GetxController {
  final RxString selectedFilter = 'all'.obs; // 'all', 'upcoming', 'pending'
  final RxList<AppointmentModel> appointments = <AppointmentModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isError = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Read initial status filter from Get arguments if passed (e.g. to open directly to pending/upcoming)
    if (Get.arguments != null && Get.arguments is String) {
      selectedFilter.value = Get.arguments as String;
    }
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    isLoading.value = true;
    isError.value = false;
    try {
      String? statusParam;
      if (selectedFilter.value == 'pending') {
        statusParam = 'pending';
      } else if (selectedFilter.value == 'upcoming') {
        statusParam = 'accepted';
      }
      final list = await AppointmentRepository.instance.getLawyerAppointments(status: statusParam);
      appointments.assignAll(list);
    } catch (e) {
      isError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  void changeFilter(String filter) {
    selectedFilter.value = filter;
    fetchAppointments();
  }

  Future<void> acceptAppointment(int id) async {
    isLoading.value = true;
    try {
      final updated = await AppointmentRepository.instance.updateAppointmentStatus(id, 'accepted');
      if (updated != null) {
        await fetchAppointments();
      }
    } catch (e) {
      // Handled
    } finally {
      isLoading.value = false;
    }
  }

  void joinCall(AppointmentModel appointment) {
    showSuccessSnackkbar(
      message: 'Connecting to Video Consultation room for Client ${appointment.client?.name ?? ''}...',
    );
  }
}
