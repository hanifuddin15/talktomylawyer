import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:talktomylawyer/app/core/models/api_response.dart';
import 'package:talktomylawyer/app/core/services/api_communication.dart';
import 'package:talktomylawyer/app/core/utils/loader.dart';
import 'package:talktomylawyer/app/core/utils/snackbar.dart';
import 'package:talktomylawyer/app/models/lawyers_models/lawyer_user_model.dart';

import 'package:talktomylawyer/app/modules/client_dashboard/controllers/client_dashboard_controller.dart';

class BookConsultationController extends GetxController {
  late final LawyerModel lawyer;
  final RxInt selectedDateIndex = 0.obs;
  final RxInt selectedTimeIndex = 1.obs; // Default to 10:30 AM in mockup
  final RxString selectedMode = 'online'.obs; // online, phone, in_person
  final RxString consultationFee = '5000'.obs;
  final TextEditingController issueController = TextEditingController();

  final List<DateTime> availableDates = [];
  final List<String> timeSlots = [
    '09:00 AM',
    '10:30 AM',
    '12:00 PM',
    '02:30 PM',
    '04:00 PM',
    '05:30 PM',
  ];

  final List<String> timeSlotsApi = [
    '09:00:00',
    '10:30:00',
    '12:00:00',
    '14:30:00',
    '16:00:00',
    '17:30:00',
  ];

  @override
  void onInit() {
    super.onInit();
    final dynamic arg = Get.arguments;
    if (arg is LawyerModel) {
      lawyer = arg;
      consultationFee.value = lawyer.consultationFee ?? '5000';
    } else {
      lawyer = LawyerModel(id: 1, name: 'Jane Lawyer');
    }
    _generateDates();
  }

  void _generateDates() {
    final DateTime today = DateTime.now();
    for (int i = 0; i < 7; i++) {
      availableDates.add(today.add(Duration(days: i)));
    }
  }

  Future<void> confirmBooking() async {
    final String issue = issueController.text.trim();
    if (issue.isEmpty) {
      showErrorSnackkbar(message: 'Please describe your legal issue');
      return;
    }

    final DateTime selectedDate = availableDates[selectedDateIndex.value];
    final String dateStr = DateFormat('yyyy-MM-dd').format(selectedDate);
    final String timeStr = timeSlotsApi[selectedTimeIndex.value];

    showLoader();
    try {
      final ApiResponse response = await ApiCommunication.instance.doPostRequest(
        apiEndPoint: 'appointments',
        requestData: {
          'lawyer_id': lawyer.id,
          'schedule_date': dateStr,
          'schedule_time': timeStr,
          'consultation_mode': selectedMode.value,
          'consultation_fee': consultationFee.value,
          'issue': issue,
        },
        enableLoading: false,
      );

      dismissLoader();

      if (response.isSuccessful) {
        // Go back to the client dashboard and switch to search tab (index 1)
        try {
          final dashboardController = Get.find<ClientDashboardController>();
          dashboardController.changeTab(1);
          Get.until((route) => Get.currentRoute == '/client_dashboard');
        } catch (_) {
          Get.offAllNamed('/client_dashboard');
          Future.delayed(const Duration(milliseconds: 100), () {
            try {
              Get.find<ClientDashboardController>().changeTab(1);
            } catch (_) {}
          });
        }
        showSuccessSnackkbar(message: 'Appointment created successfully');
      } else {
        showErrorSnackkbar(message: response.errorMessage ?? 'Failed to create appointment');
      }
    } catch (e) {
      dismissLoader();
      showErrorSnackkbar(message: 'An error occurred: $e');
    }
  }

  @override
  void onClose() {
    issueController.dispose();
    super.onClose();
  }
}
