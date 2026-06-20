import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';
import 'package:talktomylawyer/app/core/widgets/no_data_widget.dart';
import 'package:talktomylawyer/app/models/client_models/appointment_model.dart';
import 'package:talktomylawyer/app/models/lawyers_models/lawyer_user_model.dart';
import 'package:talktomylawyer/app/modules/consultation_history/controllers/consultation_history_controller.dart';
import 'package:talktomylawyer/app/modules/consultation_history/views/widgets/appointment_card.dart';
import 'package:talktomylawyer/app/modules/consultation_history/views/widgets/tab_pill.dart';

class ConsultationHistoryView extends GetView<ConsultationHistoryController> {
  const ConsultationHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? kDarkBg : kLightBg;
    final primaryText = isDark ? kDarkTextPrimary : kLightTextPrimary;
    final dividerColor = isDark ? kDarkDivider : kLightDivider;

    final List<String> tabLabels = [
      'all'.tr,
      'pending'.tr,
      'upcoming'.tr,
      'completed'.tr,
    ];

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: isDark ? kDarkBg : Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: primaryText,
            size: 20,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'consultation_history'.tr,
          style: GoogleFonts.outfit(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: primaryText,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: dividerColor, height: 1),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Tab Pill Selectors
            Container(
              height: 64,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Obx(() {
                final selectedIndex = controller.selectedTab.value;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: tabLabels.length,
                  itemBuilder: (context, index) {
                    return TabPill(
                      label: tabLabels[index],
                      isSelected: selectedIndex == index,
                      onTap: () => controller.changeTab(index),
                    );
                  },
                );
              }),
            ),

            // Appointments List View
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Skeletonizer(
                    enabled: true,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 24),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return AppointmentCard(
                          appointment: AppointmentModel(
                            id: 0,
                            scheduleDate: '2026-06-20',
                            scheduleTime: '10:30:00',
                            status: 'pending',
                            consultationMode: 'online',
                            consultationFee: '5000',
                            issue: 'Loading issue description details here...',
                            lawyer: LawyerModel(
                              id: 0,
                              name: 'Loading Lawyer Name',
                              lastEducation: 'LLB',
                              numberOfExperience: '3',
                            ),
                          ),
                          controller: controller,
                        );
                      },
                    ),
                  );
                }

                final list = controller.filteredAppointments;

                if (list.isEmpty) {
                  return RefreshIndicator(
                    onRefresh: () =>
                        controller.fetchAppointments(showLoader: false),
                    color: kPrimaryBlue,
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: NoDataWidget(
                            icon: Icons.history_rounded,
                            message: 'no_consultations'.tr,
                            buttonText: 'Retry',
                            onAction: () => controller.fetchAppointments(),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () =>
                      controller.fetchAppointments(showLoader: false),
                  color: kPrimaryBlue,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 24),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return AppointmentCard(
                        appointment: list[index],
                        controller: controller,
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
