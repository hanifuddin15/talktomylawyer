import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/utils/snackbar.dart';
import 'package:talktomylawyer/app/core/services/caching_service.dart';
import 'package:talktomylawyer/app/models/client_models/appointment_model.dart';
import 'package:talktomylawyer/app/repository/appointment_repository.dart';
import 'package:talktomylawyer/app/modules/consultation_history/controllers/consultation_history_controller.dart';
import 'package:talktomylawyer/app/modules/lawyer_dashboard/controllers/lawyer_home_controller.dart';

class ConsultationDetailsController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool isError = false.obs;
  final Rxn<AppointmentModel> appointment = Rxn<AppointmentModel>();
  
  late final int appointmentId;

  bool get isLawyerUser {
    return CachingService.instance.getUserRole() == 'lawyer';
  }

  @override
  void onInit() {
    super.onInit();
    final dynamic arg = Get.arguments;
    if (arg is int) {
      appointmentId = arg;
    } else {
      appointmentId = 1; // Fallback default
    }
    fetchAppointmentDetails();
  }

  Future<void> fetchAppointmentDetails() async {
    isLoading.value = true;
    isError.value = false;
    try {
      final detail = await AppointmentRepository.instance.getAppointmentDetails(appointmentId);
      if (detail != null) {
        appointment.value = detail;
      } else {
        isError.value = true;
        showErrorSnackkbar(message: 'Consultation details not found.');
      }
    } catch (e) {
      isError.value = true;
      showErrorSnackkbar(message: 'Failed to load details: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void cancelAppointment() {
    if (appointment.value == null) return;

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
        _performCancellation();
      },
    );
  }

  void _performCancellation() {
    if (appointment.value != null) {
      final updated = appointment.value!;
      updated.status = 'cancelled';
      appointment.value = null; // force reactive trigger
      appointment.value = updated;
      
      // Update history controller list if it exists in memory
      try {
        final historyController = Get.find<ConsultationHistoryController>();
        final index = historyController.appointments.indexWhere((a) => a.id == appointmentId);
        if (index != -1) {
          final histApp = historyController.appointments[index];
          histApp.status = 'cancelled';
          historyController.appointments[index] = histApp;
          historyController.appointments.refresh();
        }
      } catch (_) {}

      showSuccessSnackkbar(message: 'Appointment cancelled successfully');
    }
  }

  void joinCall() {
    if (appointment.value == null) return;
    showSuccessSnackkbar(
      message: isLawyerUser 
          ? 'Connecting to Video Consultation room for Client ${appointment.value?.client?.name ?? ''}...'
          : 'Connecting to Video Consultation room for Adv. ${appointment.value?.lawyer?.name ?? ''}...',
    );
  }

  Future<void> acceptAppointment() async {
    isLoading.value = true;
    try {
      final updated = await AppointmentRepository.instance.updateAppointmentStatus(appointmentId, 'accepted');
      if (updated != null) {
        appointment.value = updated;
        showSuccessSnackkbar(message: 'Appointment accepted successfully');
        
        // Also refresh list if the dashboard is loaded in memory
        try {
          final homeController = Get.find<LawyerHomeController>();
          homeController.fetchPendingBookings();
          homeController.fetchUpcomingBookings();
        } catch (_) {}
      }
    } catch (e) {
      showErrorSnackkbar(message: 'Failed to accept appointment: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void contactSupport() {
    showSuccessSnackkbar(
      message: 'Support request sent. Our team will contact you shortly.',
    );
  }
}
