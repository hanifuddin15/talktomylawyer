import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

/// Lawyer list card with avatar, rating, tags, rate
class AppLawyerCard extends StatelessWidget {
  const AppLawyerCard({
    super.key,
    required this.name,
    required this.title,
    required this.tags,
    required this.rating,
    required this.reviewCount,
    required this.experience,
    required this.location,
    required this.availability,
    required this.rate,
    this.avatarUrl,
    this.initials,
    this.onTap,
    this.onSave,
    this.isSaved = false,
  });

  final String name;
  final String title;
  final List<String> tags;
  final double rating;
  final int reviewCount;
  final int experience;
  final String location;
  final String availability;
  final int rate;
  final String? avatarUrl;
  final String? initials;
  final VoidCallback? onTap;
  final VoidCallback? onSave;
  final bool isSaved;

  bool get _isAvailableToday => availability.toLowerCase().contains('today');

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? kDarkCard : kLightCard;
    final primaryText = isDark ? kDarkTextPrimary : kLightTextPrimary;
    final secondaryText = isDark ? kDarkTextSecondary : kLightTextSecondary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Avatar
                _buildAvatar(),
                const SizedBox(width: 12),
                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: primaryText,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(Icons.verified, color: kPrimaryBlue, size: 18),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: onSave,
                            child: Icon(
                              isSaved ? Icons.bookmark : Icons.bookmark_border,
                              color: isSaved ? kAccentGold : secondaryText,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        title,
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
              ],
            ),
            const SizedBox(height: 10),
            // Tags
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: tags
                  .take(3)
                  .map(
                    (t) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: kPrimaryBlue.withValues(alpha: .12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        t,
                        style: GoogleFonts.outfit(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: kPrimaryBlue,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 10),
            // Stats Row
            Row(
              children: [
                Icon(Icons.star_rounded, color: kAccentGold, size: 15),
                const SizedBox(width: 3),
                Text(
                  '$rating ($reviewCount)',
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    color: primaryText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.business_center_outlined,
                  color: secondaryText,
                  size: 13,
                ),
                const SizedBox(width: 3),
                Text(
                  '${experience}yr exp',
                  style: GoogleFonts.outfit(fontSize: 12, color: secondaryText),
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.location_on_outlined,
                  color: secondaryText,
                  size: 13,
                ),
                const SizedBox(width: 3),
                Expanded(
                  child: Text(
                    location,
                    style: GoogleFonts.outfit(fontSize: 12, color: secondaryText),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Availability + Rate
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: (_isAvailableToday ? kSuccess : kWarning).withValues(
                      alpha: .15,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 4,
                        backgroundColor:
                            _isAvailableToday ? kSuccess : kWarning,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        availability,
                        style: GoogleFonts.outfit(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: _isAvailableToday ? kSuccess : kWarning,
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            '৳${rate.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: kAccentGold,
                        ),
                      ),
                      TextSpan(
                        text: '/hr',
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          color: secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    if (avatarUrl != null) {
      return CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(avatarUrl!),
      );
    }
    return CircleAvatar(
      radius: 30,
      backgroundColor: kPrimaryBlue.withValues(alpha: .2),
      child: Text(
        initials ?? name.substring(0, 1).toUpperCase(),
        style: GoogleFonts.outfit(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: kPrimaryBlue,
        ),
      ),
    );
  }
}
