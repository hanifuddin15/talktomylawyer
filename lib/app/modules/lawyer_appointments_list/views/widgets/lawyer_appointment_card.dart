import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';
import 'package:talktomylawyer/app/models/client_models/appointment_model.dart';
import 'package:talktomylawyer/app/modules/consultation_history/views/widgets/status_badge.dart';

class LawyerAppointmentCard extends StatelessWidget {
  final AppointmentModel appointment;
  final VoidCallback? onTap;
  final VoidCallback? onAccept;
  final VoidCallback? onJoinCall;

  const LawyerAppointmentCard({
    super.key,
    required this.appointment,
    this.onTap,
    this.onAccept,
    this.onJoinCall,
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

  Widget _buildAvatar(String name) {
    final String initials = name.isNotEmpty
        ? name.trim().split(' ').map((e) => e.isNotEmpty ? e.substring(0, 1) : '').join().toUpperCase()
        : 'C';
        
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

    final clientName = appointment.client?.name ?? 'Unknown Client';
    final subtitle = 'Client';

    final String dateStr = _getFormattedDate(appointment.scheduleDate);
    final String timeStr = _getFormattedTime(appointment.scheduleTime);
    
    final String rawMode = appointment.consultationMode?.toLowerCase() ?? 'online';
    final String modeLabel = rawMode == 'online' ? 'Video Call' : (rawMode == 'phone' ? 'Phone Call' : 'In-Person');
    final IconData modeIcon = rawMode == 'online' ? Icons.videocam_outlined : (rawMode == 'phone' ? Icons.phone_outlined : Icons.location_on_outlined);

    final String feeStr = '${appointment.consultationFee ?? '5000'} BDT';
    final String status = appointment.status?.toLowerCase() ?? 'pending';

    final bool isPending = status == 'pending';
    final bool isAccepted = status == 'accepted' || status == 'upcoming';

    return GestureDetector(
      onTap: onTap,
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
            Row(
              children: [
                _buildAvatar(clientName),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        clientName,
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
            
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onTap,
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
                if (isPending && onAccept != null) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onAccept,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryBlue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: const Size(0, 48),
                        elevation: 0,
                      ),
                      child: Text(
                        'Accept',
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ] else if (isAccepted && onJoinCall != null) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onJoinCall,
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
