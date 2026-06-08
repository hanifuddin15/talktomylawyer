import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

enum AppButtonVariant { primary, outline, danger, gold }

/// Primary CTA button used throughout the app
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.isEnabled = true,
    this.height = 56,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final IconData? icon;
  final bool isLoading;
  final bool isEnabled;
  final double height;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color bgColor;
    Color fgColor;
    BorderSide? border;

    switch (variant) {
      case AppButtonVariant.primary:
        bgColor = kPrimaryBlue;
        fgColor = Colors.white;
        border = null;
        break;
      case AppButtonVariant.outline:
        bgColor = Colors.transparent;
        fgColor = kPrimaryBlue;
        border = const BorderSide(color: kPrimaryBlue, width: 1.5);
        break;
      case AppButtonVariant.danger:
        bgColor = Colors.transparent;
        fgColor = kError;
        border = const BorderSide(color: kError, width: 1.5);
        break;
      case AppButtonVariant.gold:
        bgColor = kAccentGold;
        fgColor = Colors.white;
        border = null;
        break;
    }

    if (!isEnabled) {
      bgColor = isDark ? kDarkInputFill : kLightDivider;
      fgColor = isDark ? kDarkTextHint : kLightTextHint;
    }

    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: (isEnabled && !isLoading) ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          elevation: 0,
          side: border,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
        child: isLoading
            ? SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(fgColor),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20, color: fgColor),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    label,
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: fgColor,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
