import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';
import 'package:talktomylawyer/app/core/config/api_constant.dart';
import 'package:talktomylawyer/app/models/client_models/appointment_model.dart';
import 'package:talktomylawyer/app/modules/consultation_history/controllers/consultation_history_controller.dart';
import 'package:talktomylawyer/app/modules/consultation_history/views/widgets/status_badge.dart';

class AppointmentCard extends StatelessWidget {
  final AppointmentModel appointment;
  final ConsultationHistoryController controller;

  const AppointmentCard({
    super.key,
    required this.appointment,
    required this.controller,
  });

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
        radius: 26,
        backgroundImage: NetworkImage(fullUrl),
      );
    }
    
    final String initials = name.isNotEmpty
        ? name.trim().split(' ').map((e) => e.isNotEmpty ? e.substring(0, 1) : '').join().toUpperCase()
        : 'L';
        
    return CircleAvatar(
      radius: 26,
      backgroundColor: kPrimaryBlue.withValues(alpha: .2),
      child: Text(
        initials.substring(0, initials.length > 2 ? 2 : initials.length),
        style: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: kPrimaryBlue,
        ),
      ),
    );
  }

  Widget _infoTile(IconData icon, String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 18,
          color: color,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.outfit(
            fontSize: 13,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? kDarkCard : kLightCard;
    final primaryText = isDark ? kDarkTextPrimary : kLightTextPrimary;
    final secondaryText = isDark ? kDarkTextSecondary : kLightTextSecondary;
    final dividerColor = isDark ? kDarkDivider : kLightDivider;

    final lawyerName = appointment.lawyer?.name ?? 'Unknown Lawyer';
    
    // Create specialty subtitle
    final String experienceStr = appointment.lawyer?.numberOfExperience ?? '3';
    final String experienceLabel = experienceStr.toLowerCase().contains('year') ? experienceStr : '$experienceStr Yrs Experience';
    final String specialtyStr = appointment.lawyer?.lastEducation?.toUpperCase() ?? 'LLB';
    final String subtitle = '$specialtyStr • $experienceLabel';

    final String dateStr = _getFormattedDate(appointment.scheduleDate);
    final String timeStr = _getFormattedTime(appointment.scheduleTime);
    
    // Consultation Mode Text & Icon
    final String rawMode = appointment.consultationMode?.toLowerCase() ?? 'online';
    final String modeLabel = rawMode == 'online' ? 'Video Call' : (rawMode == 'phone' ? 'Phone Call' : 'In-Person');
    final IconData modeIcon = rawMode == 'online' ? Icons.videocam_outlined : (rawMode == 'phone' ? Icons.phone_outlined : Icons.location_on_outlined);

    // Fee Formatting
    final String feeStr = '${appointment.consultationFee ?? '5000'} BDT';

    final String status = appointment.status?.toLowerCase() ?? 'pending';
    final bool isUpcomingOrPending = status == 'pending' || status == 'accepted' || status == 'upcoming';

    return GestureDetector(
      onTap: () => controller.viewDetails(appointment),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: dividerColor,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Upper Info Section
            Row(
              children: [
                _buildAvatar(appointment.lawyer?.profilePic, lawyerName),
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
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          color: secondaryText,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                StatusBadge(status: status),
              ],
            ),
            
            const SizedBox(height: 12),
            Divider(color: dividerColor, height: 1),
            const SizedBox(height: 12),
            
            // Mid Grid Section
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _infoTile(Icons.calendar_today_outlined, dateStr, secondaryText),
                      const SizedBox(height: 10),
                      _infoTile(modeIcon, modeLabel, secondaryText),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _infoTile(Icons.access_time_rounded, timeStr, secondaryText),
                      const SizedBox(height: 10),
                      _infoTile(Icons.account_balance_wallet_outlined, feeStr, secondaryText),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Action Buttons Section
            if (isUpcomingOrPending)
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => controller.cancelAppointment(appointment.id),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: primaryText,
                        side: BorderSide(color: dividerColor, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: const Size(0, 48),
                      ),
                      child: Text(
                        'cancel_appointment'.tr,
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => controller.joinCall(appointment),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryBlue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: const Size(0, 48),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.videocam_rounded, size: 18),
                          const SizedBox(width: 6),
                          Text(
                            'join_call'.tr,
                            style: GoogleFonts.outfit(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            else
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => controller.viewDetails(appointment),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: primaryText,
                        side: BorderSide(color: dividerColor, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: const Size(0, 48),
                      ),
                      child: Text(
                        'details'.tr,
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextButton(
                      onPressed: () => controller.requestSupport(appointment),
                      style: TextButton.styleFrom(
                        foregroundColor: primaryText,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: const Size(0, 48),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.help_outline_rounded, size: 18),
                          const SizedBox(width: 6),
                          Text(
                            'support'.tr,
                            style: GoogleFonts.outfit(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
