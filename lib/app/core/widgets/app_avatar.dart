import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

/// Circular avatar with optional camera edit button
class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    required this.radius,
    this.showEditButton = false,
    this.onEditTap,
    this.backgroundColor,
  });

  final String? imageUrl;
  final String? initials;
  final double radius;
  final bool showEditButton;
  final VoidCallback? onEditTap;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundColor:
              backgroundColor ?? kPrimaryBlue.withValues(alpha: .2),
          backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
          child: imageUrl == null
              ? Text(
                  initials ?? '?',
                  style: GoogleFonts.outfit(
                    fontSize: radius * 0.55,
                    fontWeight: FontWeight.w700,
                    color: kPrimaryBlue,
                  ),
                )
              : null,
        ),
        if (showEditButton)
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: onEditTap,
              child: Container(
                width: radius * 0.6,
                height: radius * 0.6,
                decoration: const BoxDecoration(
                  color: kAccentGold,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: radius * 0.3,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
