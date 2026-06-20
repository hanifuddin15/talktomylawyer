import 'package:get/get.dart';
import 'package:talktomylawyer/app/core/utils/snackbar.dart';
import 'package:talktomylawyer/app/models/lawyers_models/lawyer_user_model.dart';
import 'package:talktomylawyer/app/models/client_models/appointment_model.dart';
import 'package:talktomylawyer/app/repository/lawyer-auth-repository.dart';
import 'package:talktomylawyer/app/repository/lawyer_dashboard_repository.dart';
import 'package:talktomylawyer/app/repository/appointment_repository.dart';
import 'package:talktomylawyer/app/routes/app_pages.dart';

class LawyerHomeController extends GetxController {
  Rxn<LawyerModel> get lawyerModel => LawyerAuthRepository.instance.lawyerData;

  final RxBool isOverviewLoading = false.obs;
  final RxMap<String, dynamic> overviewData = <String, dynamic>{
    'profile_view': 0,
    'lead_of_this_month': 0,
    'consultation': 0,
    'rating': 0,
  }.obs;

  // Bookings list states
  final RxList<AppointmentModel> pendingBookings = <AppointmentModel>[].obs;
  final RxList<AppointmentModel> upcomingBookings = <AppointmentModel>[].obs;
  final RxBool isPendingLoading = false.obs;
  final RxBool isUpcomingLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOverview();
    fetchPendingBookings();
    fetchUpcomingBookings();
  }

  Future<void> fetchOverview() async {
    isOverviewLoading.value = true;
    try {
      final data = await LawyerDashboardRepository.instance.getLawyerDashboardOverview();
      if (data != null) {
        overviewData.assignAll(data);
      }
    } catch (e) {
      // Handled
    } finally {
      isOverviewLoading.value = false;
    }
  }

  Future<void> fetchPendingBookings() async {
    isPendingLoading.value = true;
    try {
      final list = await AppointmentRepository.instance.getLawyerAppointments(status: 'pending');
      pendingBookings.assignAll(list);
    } catch (e) {
      // Handled
    } finally {
      isPendingLoading.value = false;
    }
  }

  Future<void> fetchUpcomingBookings() async {
    isUpcomingLoading.value = true;
    try {
      final list = await AppointmentRepository.instance.getLawyerAppointments(status: 'accepted');
      upcomingBookings.assignAll(list);
    } catch (e) {
      // Handled
    } finally {
      isUpcomingLoading.value = false;
    }
  }

  Future<void> acceptAppointment(int id) async {
    isOverviewLoading.value = true;
    try {
      final updated = await AppointmentRepository.instance.updateAppointmentStatus(id, 'accepted');
      if (updated != null) {
        await fetchPendingBookings();
        await fetchUpcomingBookings();
        await fetchOverview();
      }
    } catch (e) {
      // Handled
    } finally {
      isOverviewLoading.value = false;
    }
  }

  void joinCall(AppointmentModel appointment) {
    showSuccessSnackkbar(
      message: 'Connecting to Video Consultation room for Client ${appointment.client?.name ?? ''}...',
    );
  }

  void signOut() {
    LawyerAuthRepository.instance.clearAuthCredential();
    Get.offAllNamed(Routes.lawyerLogin);
  }
}
