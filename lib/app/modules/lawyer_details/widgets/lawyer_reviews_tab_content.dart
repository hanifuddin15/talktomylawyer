import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';

class LawyerReviewsTabContent extends StatelessWidget {
  const LawyerReviewsTabContent({
    super.key,
    required this.primaryText,
    required this.secondaryText,
    required this.cardColor,
  });

  final Color primaryText;
  final Color secondaryText;
  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    final reviews = [
      {
        'name': 'Rahat Hossain',
        'rating': 5.0,
        'comment':
            'Advocate Jane provided exceptional help with our civil litigation. Extremely knowledgeable and supportive throughout.',
        'time': '2 weeks ago',
      },
      {
        'name': 'Sharmin Akter',
        'rating': 4.8,
        'comment':
            'Very professional and responsive. Got sound advice on corporate registry issues.',
        'time': '1 month ago',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Client Reviews',
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: primaryText,
          ),
        ),
        const SizedBox(height: 12),
        ...reviews.map(
          (rev) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      rev['name'] as String,
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w700,
                        color: primaryText,
                        fontSize: 13.5,
                      ),
                    ),
                    Text(
                      rev['time'] as String,
                      style: GoogleFonts.outfit(
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star_rounded, color: kAccentGold, size: 14),
                    const SizedBox(width: 2),
                    Text(
                      rev['rating'].toString(),
                      style: GoogleFonts.outfit(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: primaryText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  rev['comment'] as String,
                  style: GoogleFonts.outfit(
                    fontSize: 12.5,
                    color: secondaryText,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
