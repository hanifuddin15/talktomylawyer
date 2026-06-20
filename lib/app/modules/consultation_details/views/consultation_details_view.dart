import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';
import 'package:talktomylawyer/app/core/config/api_constant.dart';
import 'package:talktomylawyer/app/modules/consultation_details/controllers/consultation_details_controller.dart';
import 'package:talktomylawyer/app/modules/consultation_details/views/widgets/detail_row_item.dart';
import 'package:talktomylawyer/app/modules/consultation_details/views/widgets/status_banner.dart';

class ConsultationDetailsView extends GetView<ConsultationDetailsController> {
  const ConsultationDetailsView({super.key});

  String _getFormattedDate(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) return 'N/A';
    try {
      final DateTime parsed = DateTime.parse(rawDate);
      return DateFormat('MMMM dd, yyyy').format(parsed);
    } catch (_) {
      return rawDate;
    }
  }

  String _getFormattedTime(String? rawTime) {
    if (rawTime == null || rawTime.isEmpty) return 'N/A';
    try {
      final DateTime parsed = DateFormat("HH:mm:ss").parse(rawTime);
      return DateFormat("hh:mm a").format(parsed);
    } catch (_) {
      try {
        final DateTime parsed2 = DateFormat("HH:mm").parse(rawTime);
        return DateFormat("hh:mm a").format(parsed2);
      } catch (_) {
        return rawTime;
      }
    }
  }

  Widget _buildAvatar(String? avatarUrl, String name) {
    if (avatarUrl != null && avatarUrl.isNotEmpty && avatarUrl != 'default.png') {
      final fullUrl = avatarUrl.startsWith('http') 
          ? avatarUrl 
          : '${ApiConstant.serverIpPort}/storage/$avatarUrl';
      return CircleAvatar(
        radius: 24,
        backgroundImage: NetworkImage(fullUrl),
      );
    }
    
    final String initials = name.isNotEmpty
        ? name.trim().split(' ').map((e) => e.isNotEmpty ? e.substring(0, 1) : '').join().toUpperCase()
        : 'L';
        
    return CircleAvatar(
      radius: 24,
      backgroundColor: kPrimaryBlue.withValues(alpha: .2),
      child: Text(
        initials.substring(0, initials.length > 2 ? 2 : initials.length),
        style: GoogleFonts.outfit(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: kPrimaryBlue,
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required BuildContext context,
    required String title,
    required List<Widget> children,
    required Color cardColor,
    required Color primaryText,
    required Color dividerColor,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: dividerColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: primaryText,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? kDarkBg : kLightBg;
    final cardColor = isDark ? kDarkCard : kLightCard;
    final primaryText = isDark ? kDarkTextPrimary : kLightTextPrimary;
    final secondaryText = isDark ? kDarkTextSecondary : kLightTextSecondary;
    final dividerColor = isDark ? kDarkDivider : kLightDivider;

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
          'Consultation Details',
          style: GoogleFonts.outfit(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: primaryText,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: dividerColor,
            height: 1,
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kPrimaryBlue),
              ),
            );
          }

          if (controller.isError.value || controller.appointment.value == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline_rounded, size: 48, color: kError),
                  const SizedBox(height: 16),
                  Text(
                    'Failed to load details',
                    style: GoogleFonts.outfit(fontSize: 16, color: primaryText, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => controller.fetchAppointmentDetails(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryBlue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final app = controller.appointment.value!;
          final lawyerName = app.lawyer?.name ?? 'Unknown Lawyer';

          final dateStr = _getFormattedDate(app.scheduleDate);
          final timeStr = _getFormattedTime(app.scheduleTime);
          
          final String rawMode = app.consultationMode?.toLowerCase() ?? 'online';
          final String modeLabel = rawMode == 'online' ? 'Video Call' : (rawMode == 'phone' ? 'Phone Call' : 'In-Person');
          final IconData modeIcon = rawMode == 'online' ? Icons.videocam_outlined : (rawMode == 'phone' ? Icons.phone_outlined : Icons.location_on_outlined);

          final feeStr = '${app.consultationFee ?? '5000'} BDT';
          final experienceStr = app.lawyer?.numberOfExperience ?? '3';
          final experienceLabel = experienceStr.toLowerCase().contains('year') ? experienceStr : '$experienceStr years exp.';
          final String specialtyStr = app.lawyer?.lastEducation?.toUpperCase() ?? 'LLB';
          final String subtitle = app.lawyer?.biography ?? 'Legal Practitioner';

          final String status = app.status?.toLowerCase() ?? 'pending';
          final bool isUpcomingOrPending = status == 'pending' || status == 'accepted' || status == 'upcoming';

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // 1. Status Banner
                      StatusBanner(status: status),
                      const SizedBox(height: 20),

                      // 2. Schedule Overview Card
                      _buildSectionCard(
                        context: context,
                        title: 'Schedule Overview',
                        cardColor: cardColor,
                        primaryText: primaryText,
                        dividerColor: dividerColor,
                        children: [
                          DetailRowItem(
                            icon: Icons.calendar_today_outlined,
                            label: 'Date',
                            value: dateStr,
                            primaryTextColor: primaryText,
                            secondaryTextColor: secondaryText,
                          ),
                          Divider(color: dividerColor, height: 1),
                          DetailRowItem(
                            icon: Icons.access_time_rounded,
                            label: 'Time Slot',
                            value: timeStr,
                            primaryTextColor: primaryText,
                            secondaryTextColor: secondaryText,
                          ),
                          Divider(color: dividerColor, height: 1),
                          DetailRowItem(
                            icon: modeIcon,
                            label: 'Mode',
                            value: modeLabel,
                            primaryTextColor: primaryText,
                            secondaryTextColor: secondaryText,
                          ),
                          Divider(color: dividerColor, height: 1),
                          DetailRowItem(
                            icon: Icons.hourglass_empty_rounded,
                            label: 'Duration',
                            value: '60 minutes',
                            primaryTextColor: primaryText,
                            secondaryTextColor: secondaryText,
                          ),
                        ],
                      ),

                      // 3. Lawyer Information Card
                      _buildSectionCard(
                        context: context,
                        title: 'Lawyer Information',
                        cardColor: cardColor,
                        primaryText: primaryText,
                        dividerColor: dividerColor,
                        children: [
                          Row(
                            children: [
                              _buildAvatar(app.lawyer?.profilePic, lawyerName),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      lawyerName.startsWith('Adv.') ? lawyerName : 'Adv. $lawyerName',
                                      style: GoogleFonts.outfit(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: primaryText,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      specialtyStr,
                                      style: GoogleFonts.outfit(
                                        fontSize: 13,
                                        color: secondaryText,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.star_rounded, color: kAccentGold, size: 16),
                                        const SizedBox(width: 4),
                                        Text(
                                          '4.9 • $experienceLabel',
                                          style: GoogleFonts.outfit(
                                            fontSize: 12,
                                            color: secondaryText,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // 4. Case Notes Card
                      _buildSectionCard(
                        context: context,
                        title: 'Case Notes',
                        cardColor: cardColor,
                        primaryText: primaryText,
                        dividerColor: dividerColor,
                        children: [
                          Text(
                            app.issue ?? 'No issue description provided.',
                            style: GoogleFonts.outfit(
                              fontSize: 14,
                              color: secondaryText,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Sticky Bottom Action Panel
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark ? kDarkBg : Colors.white,
                  border: Border(
                    top: BorderSide(color: dividerColor, width: 1),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isUpcomingOrPending) ...[
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => controller.cancelAppointment(),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: primaryText,
                                side: BorderSide(color: dividerColor, width: 1.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                minimumSize: const Size(0, 52),
                              ),
                              child: Text(
                                'cancel_appointment'.tr,
                                style: GoogleFonts.outfit(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => controller.joinCall(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryBlue,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                minimumSize: const Size(0, 52),
                                elevation: 0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.videocam_rounded, size: 20),
                                  const SizedBox(width: 8),
                                  Text(
                                    'join_call'.tr,
                                    style: GoogleFonts.outfit(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                    ],
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: OutlinedButton(
                        onPressed: () => controller.contactSupport(),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: primaryText,
                          side: BorderSide(color: dividerColor, width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.help_outline_rounded, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'Contact Customer Support',
                              style: GoogleFonts.outfit(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
