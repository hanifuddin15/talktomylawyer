import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

/// Multi-step registration progress indicator
class AppStepIndicator extends StatelessWidget {
  const AppStepIndicator({
    super.key,
    required this.steps,
    required this.currentStep,
    required this.stepLabels,
  });

  final int steps;
  final int currentStep; // 0-indexed
  final List<String> stepLabels;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(steps, (i) {
        final isCompleted = i < currentStep;
        final isActive = i == currentStep;
        final isLast = i == steps - 1;

        return Expanded(
          child: Row(
            children: [
              _StepCircle(
                index: i + 1,
                isCompleted: isCompleted,
                isActive: isActive,
              ),
              if (!isLast)
                Expanded(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Text(
                          stepLabels[i],
                          style: GoogleFonts.outfit(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: isActive ? kPrimaryBlue : kDarkTextHint,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Container(
                          height: 2,
                          color: isCompleted ? kPrimaryBlue : kDarkDivider,
                        ),
                      ),
                    ],
                  ),
                ),
              if (isLast)
                Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Text(
                    stepLabels[i],
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isActive ? kPrimaryBlue : kDarkTextHint,
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}

class _StepCircle extends StatelessWidget {
  const _StepCircle({
    required this.index,
    required this.isCompleted,
    required this.isActive,
  });

  final int index;
  final bool isCompleted;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color borderColor;
    Widget child;

    if (isCompleted) {
      bgColor = kPrimaryBlue;
      borderColor = kPrimaryBlue;
      child = const Icon(Icons.check, color: Colors.white, size: 14);
    } else if (isActive) {
      bgColor = kPrimaryBlue;
      borderColor = kPrimaryBlue;
      child = Text(
        '$index',
        style: GoogleFonts.outfit(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      );
    } else {
      bgColor = Colors.transparent;
      borderColor = kDarkTextHint;
      child = Text(
        '$index',
        style: GoogleFonts.outfit(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: kDarkTextHint,
        ),
      );
    }

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 2),
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}
