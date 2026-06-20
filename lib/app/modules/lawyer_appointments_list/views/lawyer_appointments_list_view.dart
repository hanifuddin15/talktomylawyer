import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';
import 'package:talktomylawyer/app/core/widgets/no_data_widget.dart';
import 'package:talktomylawyer/app/models/client_models/appointment_model.dart';
import 'package:talktomylawyer/app/models/client_models/client_user_model.dart';
import 'package:talktomylawyer/app/modules/consultation_history/views/widgets/tab_pill.dart';
import 'package:talktomylawyer/app/routes/app_pages.dart';
import '../controllers/lawyer_appointments_list_controller.dart';
import 'widgets/lawyer_appointment_card.dart';

class LawyerAppointmentsListView extends GetView<LawyerAppointmentsListController> {
  const LawyerAppointmentsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? kDarkBg : kLightBg;
    final primaryText = isDark ? kDarkTextPrimary : kLightTextPrimary;
    final dividerColor = isDark ? kDarkDivider : kLightDivider;

    final List<Map<String, String>> filters = [
      {'key': 'all', 'label': 'all'.tr},
      {'key': 'pending', 'label': 'pending'.tr},
      {'key': 'upcoming', 'label': 'upcoming'.tr},
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
          'appointments'.tr,
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
            // Filter chip selectors
            Container(
              height: 64,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Obx(() {
                final activeFilter = controller.selectedFilter.value;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: filters.length,
                  itemBuilder: (context, index) {
                    final item = filters[index];
                    return TabPill(
                      label: item['label']!,
                      isSelected: activeFilter == item['key'],
                      onTap: () => controller.changeFilter(item['key']!),
                    );
                  },
                );
              }),
            ),

            // Appointments List
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
                        return LawyerAppointmentCard(
                          appointment: AppointmentModel(
                            id: 0,
                            scheduleDate: '2026-06-20',
                            scheduleTime: '10:30:00',
                            status: 'pending',
                            consultationMode: 'online',
                            consultationFee: '5000',
                            issue: 'Loading issue details description here...',
                            client: ClientModel(
                              id: 0,
                              name: 'Loading Client Name',
                              email: 'client@app.com',
                              phone: '01700000000',
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }

                if (controller.isError.value) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline_rounded, size: 48, color: kError),
                        const SizedBox(height: 16),
                        Text(
                          'failed_to_load'.tr,
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            color: primaryText,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () => controller.fetchAppointments(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                final list = controller.appointments;

                if (list.isEmpty) {
                  return RefreshIndicator(
                    onRefresh: () => controller.fetchAppointments(),
                    color: kPrimaryBlue,
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: NoDataWidget(
                            icon: Icons.calendar_today_rounded,
                            message: 'no_data'.tr,
                            buttonText: 'Refresh',
                            onAction: () => controller.fetchAppointments(),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () => controller.fetchAppointments(),
                  color: kPrimaryBlue,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 24),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final item = list[index];
                      return LawyerAppointmentCard(
                        appointment: item,
                        onTap: () => Get.toNamed(
                          Routes.consultationDetails,
                          arguments: item.id,
                        )?.then((_) => controller.fetchAppointments()),
                        onAccept: () => controller.acceptAppointment(item.id!),
                        onJoinCall: () => controller.joinCall(item),
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
