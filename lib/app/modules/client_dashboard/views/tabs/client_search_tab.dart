import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';
import 'package:talktomylawyer/app/core/widgets/app_lawyer_card.dart';
import 'package:talktomylawyer/app/core/widgets/app_tag_chip.dart';

class ClientSearchTab extends StatefulWidget {
  const ClientSearchTab({super.key});

  @override
  State<ClientSearchTab> createState() => _ClientSearchTabState();
}

class _ClientSearchTabState extends State<ClientSearchTab> {
  int _selectedCategory = 0;
  bool _showFilter = false;

  final _categories = const [
    'all',
    'criminal_law',
    'family_law',
    'corporate_law',
    'property_law',
    'tax_law',
  ];

  // Filter state
  int _selectedExperience = 0;
  int _selectedConsultation = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? kDarkBg : kLightBg;
    final cardColor = isDark ? kDarkCard : kLightCard;
    final primaryText = isDark ? kDarkTextPrimary : kLightTextPrimary;
    final secondaryText = isDark ? kDarkTextSecondary : kLightTextSecondary;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Text(
                'find_a_lawyer'.tr,
                style: GoogleFonts.outfit(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: primaryText,
                ),
              ),
            ),
            // Search Bar + Filter
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 52,
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 14),
                          Icon(Icons.search, color: secondaryText, size: 20),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                color: primaryText,
                              ),
                              decoration: InputDecoration(
                                hintText: 'search_hint'.tr,
                                hintStyle: GoogleFonts.outfit(
                                  fontSize: 14,
                                  color: secondaryText,
                                ),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      setState(() => _showFilter = !_showFilter);
                      if (_showFilter) {
                        _showFilterSheet(
                          context,
                          isDark,
                          primaryText,
                          secondaryText,
                        );
                      }
                    },
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: kPrimaryBlue,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.tune_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Category chips
            SizedBox(
              height: 46,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                itemCount: _categories.length,
                itemBuilder: (_, i) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: AppTagChip(
                    label: _categories[i].tr,
                    isSelected: _selectedCategory == i,
                    onTap: () => setState(() => _selectedCategory = i),
                  ),
                ),
              ),
            ),
            // Results count
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        color: secondaryText,
                      ),
                      children: [
                        TextSpan(
                          text: '128 ',
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w700,
                            color: primaryText,
                          ),
                        ),
                        TextSpan(text: 'lawyers_found'.tr),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'sort'.tr,
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          color: secondaryText,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: secondaryText,
                        size: 18,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Lawyer List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                children: [
                  AppLawyerCard(
                    name: 'Adv. Rahman Khan',
                    title: 'corporate_law'.tr,
                    tags: ['corporate_law'.tr, 'tax_law'.tr],
                    rating: 4.9,
                    reviewCount: 128,
                    experience: 12,
                    location: 'Dhaka',
                    availability: 'available_today'.tr,
                    rate: 2500,
                    initials: 'RK',
                  ),
                  AppLawyerCard(
                    name: 'Adv. Fatema Begum',
                    title: 'family_law'.tr,
                    tags: ['family_law'.tr, 'civil_law'.tr],
                    rating: 4.7,
                    reviewCount: 96,
                    experience: 8,
                    location: 'Chittagong',
                    availability: 'available_tomorrow'.tr,
                    rate: 2000,
                    initials: 'FB',
                  ),
                  AppLawyerCard(
                    name: 'Adv. Kamal Hossain',
                    title: 'criminal_law'.tr,
                    tags: ['criminal_law'.tr],
                    rating: 4.8,
                    reviewCount: 203,
                    experience: 15,
                    location: 'Dhaka',
                    availability: 'available_today'.tr,
                    rate: 3000,
                    initials: 'KH',
                  ),
                  AppLawyerCard(
                    name: 'Adv. Nadia Islam',
                    title: 'property_law'.tr,
                    tags: ['property_law'.tr, 'civil_law'.tr],
                    rating: 4.6,
                    reviewCount: 74,
                    experience: 7,
                    location: 'Sylhet',
                    availability: 'available_today'.tr,
                    rate: 1800,
                    initials: 'NI',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterSheet(
    BuildContext context,
    bool isDark,
    Color primaryText,
    Color secondaryText,
  ) {
    final sheetBg = isDark ? kDarkSurface : kLightSurface;

    showModalBottomSheet(
      context: context,
      backgroundColor: sheetBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      isScrollControlled: true,
      builder: (_) => StatefulBuilder(
        builder: (context, setSheetState) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'filters'.tr,
                    style: GoogleFonts.outfit(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: primaryText,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setSheetState(() {
                        _selectedExperience = 0;
                        _selectedConsultation = 0;
                      });
                    },
                    child: Text(
                      'reset'.tr,
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        color: kError,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'experience'.tr,
                style: GoogleFonts.outfit(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: primaryText,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                children: ['1-3 yrs', '3-5 yrs', '5-10 yrs', '10+ yrs']
                    .asMap()
                    .entries
                    .map(
                      (e) => AppTagChip(
                        label: e.value,
                        isSelected: _selectedExperience == e.key,
                        onTap: () =>
                            setSheetState(() => _selectedExperience = e.key),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 16),
              Text(
                'consultation_type'.tr,
                style: GoogleFonts.outfit(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: primaryText,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                children: ['Video', 'Phone', 'In-Person']
                    .asMap()
                    .entries
                    .map(
                      (e) => AppTagChip(
                        label: e.value,
                        isSelected: _selectedConsultation == e.key,
                        onTap: () =>
                            setSheetState(() => _selectedConsultation = e.key),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'apply_filters'.tr,
                    style: GoogleFonts.outfit(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
