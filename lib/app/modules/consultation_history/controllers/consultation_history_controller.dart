import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/utils/snackbar.dart';
import 'package:talktomylawyer/app/models/client_models/appointment_model.dart';
import 'package:talktomylawyer/app/repository/appointment_repository.dart';
import 'package:talktomylawyer/app/routes/app_pages.dart';


class ConsultationHistoryController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxInt selectedTab = 0.obs;
  final RxList<AppointmentModel> appointments = <AppointmentModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAppointments();
  }

  Future<void> fetchAppointments({bool showLoader = true}) async {
    if (showLoader) isLoading.value = true;
    try {
      final list = await AppointmentRepository.instance.getAppointments();
      appointments.assignAll(list);
    } catch (e) {
      showErrorSnackkbar(message: 'Failed to fetch consultations: $e');
    } finally {
      if (showLoader) isLoading.value = false;
    }
  }

  List<AppointmentModel> get filteredAppointments {
    switch (selectedTab.value) {
      case 1: // Pending
        return appointments
            .where((a) => a.status?.toLowerCase() == 'pending')
            .toList();
      case 2: // Upcoming
        return appointments
            .where(
              (a) =>
                  a.status?.toLowerCase() == 'accepted' ||
                  a.status?.toLowerCase() == 'upcoming',
            )
            .toList();
      case 3: // Completed / Past
        return appointments
            .where(
              (a) =>
                  a.status?.toLowerCase() == 'completed' ||
                  a.status?.toLowerCase() == 'cancelled' ||
                  a.status?.toLowerCase() == 'rejected',
            )
            .toList();
      case 0: // All
      default:
        return appointments;
    }
  }

  void changeTab(int index) {
    selectedTab.value = index;
  }

  void cancelAppointment(int? appointmentId) {
    if (appointmentId == null) return;

    final isDark = Get.isDarkMode;
    final primaryTextColor = isDark ? Colors.white : const Color(0xFF0A1128);

    Get.defaultDialog(
      title: 'cancel_appointment'.tr,
      middleText: 'Are you sure you want to cancel this appointment?',
      textConfirm: 'Yes, Cancel',
      textCancel: 'No',
      confirmTextColor: Colors.white,
      cancelTextColor: primaryTextColor,
      buttonColor: const Color(0xFFEF4444),
      titleStyle: GoogleFonts.outfit(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: primaryTextColor,
      ),
      middleTextStyle: GoogleFonts.outfit(
        fontSize: 14,
        color: isDark ? Colors.white70 : Colors.black,
      ),
      onConfirm: () {
        Get.back();
        _performCancellation(appointmentId);
      },
    );
  }

  void _performCancellation(int appointmentId) {
    final index = appointments.indexWhere((a) => a.id == appointmentId);
    if (index != -1) {
      final updated = appointments[index];
      // update local state
      updated.status = 'cancelled';
      appointments[index] = updated;
      appointments.refresh();
      showSuccessSnackkbar(message: 'Appointment cancelled successfully');
    }
  }

  void joinCall(AppointmentModel appointment) {
    showSuccessSnackkbar(
      message:
          'Connecting to Video Consultation room for Adv. ${appointment.lawyer?.name ?? ''}...',
    );
  }

  void viewDetails(AppointmentModel appointment) {
    if (appointment.id != null) {
      Get.toNamed(Routes.consultationDetails, arguments: appointment.id);
    }
  }


  void requestSupport(AppointmentModel appointment) {
    showSuccessSnackkbar(
      message: 'Support request sent. Our team will contact you shortly.',
    );
  }
}
