import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/widgets/buttons/primary_button.dart';

class SubscriptionCard extends StatelessWidget {
  final String planName;
  final String price;
  final String subText;
  final bool isSelected;
  const SubscriptionCard({
    super.key,
    required this.isSelected,
    required this.planName,
    required this.price,
    required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected
              ? Colors.grey.shade100
              : Theme.of(context).primaryColor,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            color: Theme.of(context).primaryColor.withValues(alpha: .3),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          // Radio(
          //   value: true,
          //   groupValue: true,
          //   onChanged: (val) {},
          //   activeColor: Theme.of(context).primaryColor,
          // ),
          // const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  planName,
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '\$',
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      price,
                      style: GoogleFonts.outfit(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '/ ${planName == 'Monthly Plan' ? 'month' : 'year'}',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                Text(
                  subText,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 16),
                planName == 'Monthly Plan'
                    ? const SizedBox()
                    : Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 111, 240, 113),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          'Save 28%',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 70, 118, 7),
                          ),
                        ),
                      ),
                const SizedBox(height: 16),
                PrimaryButton(
                  width: double.infinity,
                  onPressed: () {},
                  text: 'Select Plan',
                  textColor: isSelected
                      ? context.theme.primaryColor
                      : Colors.white,
                  backgroundColor: isSelected
                      ? Colors.white
                      : context.theme.primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
