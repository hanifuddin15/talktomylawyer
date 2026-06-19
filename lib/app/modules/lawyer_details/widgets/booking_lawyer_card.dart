import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/config/api_constant.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';
import 'package:talktomylawyer/app/models/lawyers_models/lawyer_user_model.dart';

class BookingLawyerCard extends StatelessWidget {
  final LawyerModel lawyer;
  const BookingLawyerCard({super.key, required this.lawyer});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? kDarkCard : kLightCard;
    final primaryText = isDark ? kDarkTextPrimary : kLightTextPrimary;
    final secondaryText = isDark ? kDarkTextSecondary : kLightTextSecondary;
    final dividerColor = isDark ? kDarkDivider : kLightDivider;

    final hasAvatar = lawyer.profilePic != null && lawyer.profilePic != 'default.png';
    final avatarUrl = hasAvatar
        ? '${ApiConstant.serverIpPort}/storage/${lawyer.profilePic}'
        : null;

    final initials = lawyer.name != null && lawyer.name!.isNotEmpty
        ? lawyer.name!
              .trim()
              .split(' ')
              .map((e) => e.isNotEmpty ? e.substring(0, 1) : '')
              .join()
              .toUpperCase()
        : 'L';

    final primaryCategory = (lawyer.categories != null && lawyer.categories!.isNotEmpty)
        ? lawyer.categories!.first.name ?? 'Lawyer'
        : 'Lawyer';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: dividerColor.withValues(alpha: .5)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 36,
            backgroundColor: kPrimaryBlue.withValues(alpha: .15),
            backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl) : null,
            child: avatarUrl == null
                ? Text(
                    initials,
                    style: GoogleFonts.outfit(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: kPrimaryBlue,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lawyer.name ?? 'Jane Lawyer',
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: primaryText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  primaryCategory,
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: secondaryText,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: kAccentGold,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '4.9',
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryText,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '(127 reviews)',
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: secondaryText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
