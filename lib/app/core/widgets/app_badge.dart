import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Notification dot badge overlaid on a child widget
class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    required this.child,
    this.count = 0,
    this.showDot = false,
  });

  final Widget child;
  final int count;
  final bool showDot;

  @override
  Widget build(BuildContext context) {
    if (count == 0 && !showDot) return child;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          right: 5,
          top: 5,
          child: Container(
            constraints: showDot
                ? const BoxConstraints(minWidth: 8, minHeight: 8)
                : const BoxConstraints(minWidth: 18, minHeight: 18),
            padding: showDot
                ? EdgeInsets.zero
                : const EdgeInsets.symmetric(horizontal: 4),
            decoration: const BoxDecoration(
              color: kError,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: showDot
                ? null
                : Text(
                    count > 99 ? '99+' : '$count',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
