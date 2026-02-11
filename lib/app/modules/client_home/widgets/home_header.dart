import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Color(0xFF1A237E),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 48),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, Anik',
                    style: GoogleFonts.outfit(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Find the right lawyer for your needs',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: .8),
                    ),
                  ),
                ],
              ),
              CircleAvatar(
                radius: 32,
                backgroundColor: Colors.white.withValues(alpha: .2),
                child: const Icon(Icons.person, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // // Search Bar Placeholder
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          //   decoration: BoxDecoration(
          //     color: Colors.white.withValues(alpha: .15),
          //     borderRadius: BorderRadius.circular(16),
          //   ),
          //   child: Row(
          //     children: [
          //       const Icon(Icons.search, color: Colors.white70),
          //       const SizedBox(width: 12),
          //       Text(
          //         'Search for lawyers, practice areas...',
          //         style: GoogleFonts.inter(color: Colors.white70, fontSize: 14),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
