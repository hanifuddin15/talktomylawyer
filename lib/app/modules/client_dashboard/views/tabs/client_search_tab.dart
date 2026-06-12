import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';
import 'package:talktomylawyer/app/core/widgets/app_lawyer_card.dart';
import 'package:talktomylawyer/app/core/widgets/app_tag_chip.dart';
import 'package:talktomylawyer/app/core/widgets/input_fields/app_search_field.dart';

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
  int? _selectedLocation;
  int? _selectedPracticeArea;
  int? _selectedExperience;
  int? _selectedLanguage;
  int? _selectedConsultation;
  bool _verifiedOnly = false;

  final List<String> _locations = const [
    'Dhaka',
    'Chittagong',
    'Sylhet',
    'Rajshahi',
    'Khulna',
  ];

  final List<String> _practiceAreas = const [
    'Criminal Law',
    'Family Law',
    'Corporate Law',
    'Civil Law',
    'Property Law',
    'Labour Law',
    'Immigration',
    'Tax Law',
  ];

  final List<String> _experiences = const [
    '0-5 yrs',
    '5-10 yrs',
    '10-15 yrs',
    '15+ yrs',
  ];

  final List<String> _languages = const [
    'Bangla',
    'English',
    'Arabic',
    'French',
    'Hindi',
  ];

  final List<String> _consultationTypes = const [
    'Video Call',
    'Phone',
    'In-person',
  ];

  Widget _buildSectionTitle(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: GoogleFonts.outfit(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }

  Widget _buildChips(
    List<String> items,
    int? selectedIndex,
    ValueChanged<int> onTap,
  ) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items.asMap().entries.map((e) {
        return AppTagChip(
          label: e.value,
          isSelected: selectedIndex == e.key,
          onTap: () => onTap(e.key),
        );
      }).toList(),
    );
  }

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
                    child: Row(
                      children: [
                        const SizedBox(width: 14),
                        Expanded(
                          child: SizedBox(
                            height: 52,
                            child: AppSearchField(
                              primaryText: primaryText,
                              secondaryText: secondaryText,
                              cardColor: cardColor,
                            ),
                          ),
                        ),
                      ],
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

    // Temporary local state for bottom sheet selections
    int? tempLocation = _selectedLocation;
    int? tempPracticeArea = _selectedPracticeArea;
    int? tempExperience = _selectedExperience;
    int? tempLanguage = _selectedLanguage;
    int? tempConsultation = _selectedConsultation;
    bool tempVerifiedOnly = _verifiedOnly;

    showModalBottomSheet(
      context: context,
      backgroundColor: sheetBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      isScrollControlled: true,
      builder: (_) => StatefulBuilder(
        builder: (context, setSheetState) => Container(
          height: MediaQuery.of(context).size.height * 0.92,
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.close,
                        color: primaryText,
                        size: 24,
                      ),
                    ),
                    Text(
                      'filters'.tr,
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: primaryText,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setSheetState(() {
                          tempLocation = null;
                          tempPracticeArea = null;
                          tempExperience = null;
                          tempLanguage = null;
                          tempConsultation = null;
                          tempVerifiedOnly = false;
                        });
                      },
                      child: Text(
                        'reset'.tr,
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: kPrimaryBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: isDark ? kDarkDivider : kLightDivider,
                height: 1,
              ),
              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. Location
                      _buildSectionTitle('location'.tr, primaryText),
                      _buildChips(
                        _locations,
                        tempLocation,
                        (index) => setSheetState(() {
                          tempLocation = (tempLocation == index) ? null : index;
                        }),
                      ),
                      const SizedBox(height: 24),

                      // 2. Practice Area
                      _buildSectionTitle('practice_area'.tr, primaryText),
                      _buildChips(
                        _practiceAreas,
                        tempPracticeArea,
                        (index) => setSheetState(() {
                          tempPracticeArea = (tempPracticeArea == index) ? null : index;
                        }),
                      ),
                      const SizedBox(height: 24),

                      // 3. Experience
                      _buildSectionTitle('experience'.tr, primaryText),
                      _buildChips(
                        _experiences,
                        tempExperience,
                        (index) => setSheetState(() {
                          tempExperience = (tempExperience == index) ? null : index;
                        }),
                      ),
                      const SizedBox(height: 24),

                      // 4. Language
                      _buildSectionTitle('language'.tr, primaryText),
                      _buildChips(
                        _languages,
                        tempLanguage,
                        (index) => setSheetState(() {
                          tempLanguage = (tempLanguage == index) ? null : index;
                        }),
                      ),
                      const SizedBox(height: 24),

                      // 5. Consultation Type
                      _buildSectionTitle('consultation_type'.tr, primaryText),
                      _buildChips(
                        _consultationTypes,
                        tempConsultation,
                        (index) => setSheetState(() {
                          tempConsultation = (tempConsultation == index) ? null : index;
                        }),
                      ),
                      const SizedBox(height: 24),

                      // 6. Other (Verified Toggle)
                      _buildSectionTitle('other'.tr, primaryText),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: isDark ? kDarkInputFill : kLightInputFill,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isDark ? kDarkDivider : kLightDivider,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.verified_user_outlined,
                              color: kPrimaryBlue,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'verified_lawyers_only'.tr,
                                style: GoogleFonts.outfit(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryText,
                                ),
                              ),
                            ),
                            Switch.adaptive(
                              value: tempVerifiedOnly,
                              activeColor: kPrimaryBlue,
                              onChanged: (val) {
                                setSheetState(() {
                                  tempVerifiedOnly = val;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
              Divider(
                color: isDark ? kDarkDivider : kLightDivider,
                height: 1,
              ),
              // Sticky bottom action button
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedLocation = tempLocation;
                        _selectedPracticeArea = tempPracticeArea;
                        _selectedExperience = tempExperience;
                        _selectedLanguage = tempLanguage;
                        _selectedConsultation = tempConsultation;
                        _verifiedOnly = tempVerifiedOnly;
                      });
                      Navigator.pop(context);
                    },
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
