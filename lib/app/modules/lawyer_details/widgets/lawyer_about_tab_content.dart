import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';

class LawyerAboutTabContent extends StatelessWidget {
  const LawyerAboutTabContent({
    super.key,
    required this.bio,
    required this.education,
    required this.barRegistration,
    required this.categories,
    required this.primaryText,
    required this.secondaryText,
    required this.phoneNumber,
    required this.email,
  });

  final String bio;
  final String? education;
  final String? barRegistration;
  final List<dynamic>? categories;
  final Color primaryText;
  final Color secondaryText;
  final String? phoneNumber;
  final String? email;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Biography
        Text(
          'Biography',
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: primaryText,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          bio,
          style: GoogleFonts.outfit(
            fontSize: 13.5,
            color: secondaryText,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 20),

        // Education
        Text(
          'Education',
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: primaryText,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          education ?? 'LLB, University of Dhaka | LLM, BUET Law',
          style: GoogleFonts.outfit(fontSize: 13.5, color: secondaryText),
        ),
        const SizedBox(height: 20),

        // Bar Registration
        Text(
          'Bar Registration',
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: primaryText,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          barRegistration ?? 'BD-2012-04521',
          style: GoogleFonts.outfit(fontSize: 13.5, color: secondaryText),
        ),
        const SizedBox(height: 20),

        // Practice Areas
        Text(
          'Practice Areas',
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: primaryText,
          ),
        ),
        const SizedBox(height: 10),
        if (categories == null)
          Text(
            'General Law Practice',
            style: GoogleFonts.outfit(fontSize: 13.5, color: secondaryText),
          )
        else
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: categories!.map((cat) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryBlue.withValues(alpha: .12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  cat.name ?? '',
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: kPrimaryBlue,
                  ),
                ),
              );
            }).toList(),
          ),
        const SizedBox(height: 24),

        // Direct contact info (always unmasked in this widget)
        Text(
          'Contact Information',
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: primaryText,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.phone_rounded, color: kPrimaryBlue, size: 18),
            const SizedBox(width: 8),
            Text(
              phoneNumber ?? '01787654321',
              style: GoogleFonts.outfit(
                fontSize: 14,
                color: primaryText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Icon(Icons.email_rounded, color: kPrimaryBlue, size: 18),
            const SizedBox(width: 8),
            Text(
              email ?? 'janelawyer@example.com',
              style: GoogleFonts.outfit(
                fontSize: 14,
                color: primaryText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
