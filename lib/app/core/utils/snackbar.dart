import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';

const snackbarDuration = Duration(seconds: 3);

void showSnackkbar({required String title, required String message}) {
  Get.snackbar(
    '',
    '',
    titleText: Text(
      title,
      style: GoogleFonts.outfit(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    messageText: Text(
      message,
      style: GoogleFonts.outfit(
        fontSize: 13,
        color: Colors.white.withOpacity(0.95),
      ),
    ),
    icon: const Icon(
      Icons.info_outline_rounded,
      color: Colors.white,
      size: 26,
    ),
    shouldIconPulse: false,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: kPrimaryBlue.withOpacity(0.95),
    margin: const EdgeInsets.all(16),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    borderRadius: 16,
    boxShadows: [
      BoxShadow(
        color: kPrimaryBlue.withOpacity(0.3),
        blurRadius: 12,
        offset: const Offset(0, 6),
      ),
    ],
    duration: snackbarDuration,
  );
}

void showSuccessSnackkbar({String? title, required String message}) {
  Get.snackbar(
    '',
    '',
    titleText: Text(
      title ?? 'SUCCESS!',
      style: GoogleFonts.outfit(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    messageText: Text(
      message,
      style: GoogleFonts.outfit(
        fontSize: 13,
        color: Colors.white.withOpacity(0.95),
      ),
    ),
    icon: const Icon(
      Icons.check_circle_rounded,
      color: Colors.white,
      size: 26,
    ),
    shouldIconPulse: false,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: kSuccess.withOpacity(0.95),
    margin: const EdgeInsets.all(16),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    borderRadius: 16,
    boxShadows: [
      BoxShadow(
        color: kSuccess.withOpacity(0.3),
        blurRadius: 12,
        offset: const Offset(0, 6),
      ),
    ],
    duration: snackbarDuration,
  );
}

void showWarningSnackkbar({String? title, required String message}) {
  Get.snackbar(
    '',
    '',
    titleText: Text(
      title ?? 'WARNING!',
      style: GoogleFonts.outfit(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    messageText: Text(
      message,
      style: GoogleFonts.outfit(
        fontSize: 13,
        color: Colors.black.withOpacity(0.9),
      ),
    ),
    icon: const Icon(
      Icons.warning_amber_rounded,
      color: Colors.black,
      size: 26,
    ),
    shouldIconPulse: false,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: kWarning.withOpacity(0.95),
    margin: const EdgeInsets.all(16),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    borderRadius: 16,
    boxShadows: [
      BoxShadow(
        color: kWarning.withOpacity(0.3),
        blurRadius: 12,
        offset: const Offset(0, 6),
      ),
    ],
    duration: snackbarDuration,
  );
}

void showErrorSnackkbar({String? title, required String message}) {
  Get.snackbar(
    '',
    '',
    titleText: Text(
      title ?? 'ERROR!',
      style: GoogleFonts.outfit(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    messageText: Text(
      message,
      style: GoogleFonts.outfit(
        fontSize: 13,
        color: Colors.white.withOpacity(0.95),
      ),
    ),
    icon: const Icon(
      Icons.error_outline_rounded,
      color: Colors.white,
      size: 26,
    ),
    shouldIconPulse: false,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: kError.withOpacity(0.95),
    margin: const EdgeInsets.all(16),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    borderRadius: 16,
    boxShadows: [
      BoxShadow(
        color: kError.withOpacity(0.3),
        blurRadius: 12,
        offset: const Offset(0, 6),
      ),
    ],
    duration: snackbarDuration,
  );
}
