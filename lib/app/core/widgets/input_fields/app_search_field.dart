import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';

class AppSearchField extends StatelessWidget {
  const AppSearchField({
    super.key,
    required this.primaryText,
    required this.secondaryText,
    required this.cardColor,
    this.controller,
    this.onChanged,
  });

  final Color primaryText;
  final Color secondaryText;
  final Color cardColor;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      style: GoogleFonts.outfit(fontSize: 14, color: primaryText),
      decoration: InputDecoration(
        hintText: 'search_hint'.tr,
        hintStyle: GoogleFonts.outfit(fontSize: 14, color: secondaryText),
        prefixIcon: Icon(Icons.search, color: secondaryText, size: 20),
        filled: true,
        fillColor: cardColor,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: kLightTextSecondary, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: kLightTextSecondary, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: kLightTextSecondary, width: 1),
        ),
      ),
    );
  }
}
