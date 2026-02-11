import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/client_search_controller.dart';

class ClientSearchView extends GetView<ClientSearchController> {
  const ClientSearchView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Find a Lawyer',
          style: GoogleFonts.outfit(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search by name or location',
                hintStyle: GoogleFonts.inter(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.filter_list,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {},
                ),
                filled: true,
                fillColor: const Color(0xFFF5F7FA),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            const SizedBox(height: 48),

            // Empty State
            Container(
              padding: const EdgeInsets.all(32),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Placeholder illustration
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F7FA),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.search_off_rounded,
                      size: 64,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'No lawyers found',
                    style: GoogleFonts.outfit(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Try adjusting your search criteria',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
