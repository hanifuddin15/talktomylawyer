import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/modules/client_home/widgets/category_card.dart';
import 'package:talktomylawyer/app/modules/client_home/widgets/home_header.dart';
import '../controllers/client_home_controller.dart';

class ClientHomeView extends GetView<ClientHomeController> {
  const ClientHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          const HomeHeader(),
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  Text(
                    'Legal Categories',
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Browse lawyer categories by their area of expertise',
                    style: GoogleFonts.inter(fontSize: 14, color: Colors.black),
                  ),
                  const SizedBox(height: 24),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1.1,
                        ),
                    itemCount: controller.categories.length,
                    itemBuilder: (context, index) {
                      final category = controller.categories[index];
                      IconData iconData;
                      switch (category['name']) {
                        case 'Civil Law':
                          iconData = Icons.description_outlined;
                          break;
                        case 'Corporate Law':
                          iconData = Icons.business_outlined;
                          break;
                        case 'Criminal Law':
                          iconData = Icons.gavel_outlined;
                          break;
                        case 'Environmental Law':
                          iconData = Icons.eco_outlined;
                          break;
                        case 'Family Law':
                          iconData = Icons.favorite_border;
                          break;
                        case 'Immigration Law':
                          iconData = Icons.flight_takeoff_outlined;
                          break;
                        case 'Intellectual Property':
                          iconData = Icons.lightbulb_outline;
                          break;
                        case 'Labor Law':
                          iconData = Icons.group_outlined;
                          break;
                        case 'Property Law':
                          iconData = Icons.home_outlined;
                        case 'Tax Law':
                          iconData = Icons.money_outlined;
                          break;
                        default:
                          iconData = Icons.category_outlined;
                      }

                      return CategoryCard(
                        name: category['name'] as String,
                        icon: iconData,
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      // vertical: 24,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 24,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 210, 226, 245),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Need Help Finding a Lawyer?',
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Browse lawyer categories by their area of expertise',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'Use the search tab to filter lawyers by name, locations or specialities.Subscribe to unlock more features.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
