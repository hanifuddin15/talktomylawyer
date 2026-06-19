import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';
import 'package:talktomylawyer/app/core/widgets/app_lawyer_card.dart';
import 'package:talktomylawyer/app/core/widgets/app_tag_chip.dart';
import 'package:talktomylawyer/app/core/widgets/input_fields/app_search_field.dart';
import 'package:talktomylawyer/app/core/config/api_constant.dart';
import 'package:talktomylawyer/app/modules/client_dashboard/controllers/client_dashboard_controller.dart';

class ClientSearchTab extends StatefulWidget {
  const ClientSearchTab({super.key});

  @override
  State<ClientSearchTab> createState() => _ClientSearchTabState();
}

class _ClientSearchTabState extends State<ClientSearchTab> {
  late final ClientDashboardController controller;
  late final TextEditingController _searchTextController;
  bool _showFilter = false;

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

  @override
  void initState() {
    super.initState();
    controller = Get.find<ClientDashboardController>();
    _searchTextController = TextEditingController(text: controller.searchQuery.value);

    // Sync UI states with current controller values if they exist
    if (controller.selectedCategoryId.value != null) {
      final idx = controller.categoriesList.indexWhere(
        (c) => c.id == controller.selectedCategoryId.value,
      );
      if (idx != -1) {
        _selectedPracticeArea = idx;
      }
    }
    if (controller.filterAddress.value != null) {
      final idx = _locations.indexOf(controller.filterAddress.value!);
      if (idx != -1) {
        _selectedLocation = idx;
      }
    }
    if (controller.filterLanguage.value != null) {
      final idx = _languages.indexOf(controller.filterLanguage.value!);
      if (idx != -1) {
        _selectedLanguage = idx;
      }
    }
    if (controller.filterExperience.value != null) {
      final expVal = controller.filterExperience.value;
      if (expVal == 5) {
        _selectedExperience = 0;
      } else if (expVal == 10) {
        _selectedExperience = 1;
      } else if (expVal == 15) {
        _selectedExperience = 2;
      } else if (expVal == 20) {
        _selectedExperience = 3;
      }
    }
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  int? _mapExperienceToYears(int index) {
    switch (index) {
      case 0:
        return 5;
      case 1:
        return 10;
      case 2:
        return 15;
      case 3:
        return 20;
      default:
        return null;
    }
  }

  void _resetLocalFilters() {
    setState(() {
      _selectedLocation = null;
      _selectedPracticeArea = null;
      _selectedExperience = null;
      _selectedLanguage = null;
      _selectedConsultation = null;
      _verifiedOnly = false;
    });
  }

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
                              controller: _searchTextController,
                              onChanged: (val) {
                                controller.searchQuery.value = val;
                              },
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
              child: Obx(() {
                final cats = controller.categoriesList;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  itemCount: cats.length + 1,
                  itemBuilder: (_, i) {
                    final isAll = i == 0;
                    final label = isAll ? 'all'.tr : (cats[i - 1].name ?? '');
                    final isSelected = isAll
                        ? controller.selectedCategoryId.value == null
                        : controller.selectedCategoryId.value == cats[i - 1].id;

                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: AppTagChip(
                        label: label,
                        isSelected: isSelected,
                        onTap: () {
                          if (isAll) {
                            controller.updateCategoryFilter(null);
                            setState(() {
                              _selectedPracticeArea = null;
                            });
                          } else {
                            final catId = cats[i - 1].id;
                            controller.updateCategoryFilter(catId);
                            setState(() {
                              _selectedPracticeArea = i - 1;
                            });
                          }
                        },
                      ),
                    );
                  },
                );
              }),
            ),
            // Results count
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() {
                    final baseList = controller.lawyersList;
                    final query = controller.searchQuery.value.trim().toLowerCase();
                    final filteredCount = baseList.where((lawyer) {
                      if (query.isEmpty) return true;
                      final name = (lawyer.name ?? '').toLowerCase();
                      final address = (lawyer.address ?? '').toLowerCase();
                      final exp = (lawyer.numberOfExperience ?? '').toLowerCase();
                      
                      final categoryMatch = lawyer.categories?.any(
                        (cat) => (cat.name ?? '').toLowerCase().contains(query)
                      ) ?? false;
                      
                      return name.contains(query) ||
                          address.contains(query) ||
                          exp.contains(query) ||
                          categoryMatch;
                    }).length;

                    return RichText(
                      text: TextSpan(
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: secondaryText,
                        ),
                        children: [
                          TextSpan(
                            text: '$filteredCount ',
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w700,
                              color: primaryText,
                            ),
                          ),
                          TextSpan(text: 'lawyers_found'.tr),
                        ],
                      ),
                    );
                  }),
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
              child: Obx(() {
                if (controller.isLawyersLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final baseList = controller.lawyersList;
                final query = controller.searchQuery.value.trim().toLowerCase();
                final filteredList = baseList.where((lawyer) {
                  if (query.isEmpty) return true;
                  final name = (lawyer.name ?? '').toLowerCase();
                  final address = (lawyer.address ?? '').toLowerCase();
                  final exp = (lawyer.numberOfExperience ?? '').toLowerCase();
                  
                  final categoryMatch = lawyer.categories?.any(
                    (cat) => (cat.name ?? '').toLowerCase().contains(query)
                  ) ?? false;
                  
                  return name.contains(query) ||
                      address.contains(query) ||
                      exp.contains(query) ||
                      categoryMatch;
                }).toList();

                if (filteredList.isEmpty) {
                  return Center(
                    child: Text(
                      'No lawyers found',
                      style: GoogleFonts.outfit(color: secondaryText),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final lawyer = filteredList[index];
                    final hasAvatar = lawyer.profilePic != null &&
                        lawyer.profilePic != 'default.png';
                    final avatar = hasAvatar
                        ? '${ApiConstant.serverIpPort}/storage/${lawyer.profilePic}'
                        : null;

                    final initials = lawyer.name != null && lawyer.name!.isNotEmpty
                        ? lawyer.name!
                            .trim()
                            .split(' ')
                            .map((e) => e.isNotEmpty ? e.substring(0, 1) : '')
                            .join()
                            .toUpperCase()
                        : 'L';

                    final title = lawyer.categories != null && lawyer.categories!.isNotEmpty
                        ? '${lawyer.categories!.first.name} • ${lawyer.numberOfExperience ?? '1'} yr exp'
                        : 'Lawyer • ${lawyer.numberOfExperience ?? '1'} yr exp';

                    final tags = lawyer.categories?.map((e) => e.name ?? '').toList() ?? [];

                    return AppLawyerCard(
                      name: lawyer.name ?? 'Jane Lawyer',
                      title: title,
                      tags: tags,
                      rating: 4.8,
                      reviewCount: 120,
                      experience: int.tryParse(lawyer.numberOfExperience ?? '1') ?? 1,
                      location: lawyer.address ?? 'Dhaka',
                      availability: 'available_today'.tr,
                      rate: 2000,
                      avatarUrl: avatar,
                      initials: initials,
                    );
                  },
                );
              }),
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
                      onTap: () {
                        setState(() => _showFilter = false);
                        Navigator.pop(context);
                      },
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
                        _resetLocalFilters();
                        controller.resetFilters();
                        setState(() => _showFilter = false);
                        Navigator.pop(context);
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

                      // 2. Practice Area (Dynamic)
                      _buildSectionTitle('practice_area'.tr, primaryText),
                      _buildChips(
                        controller.categoriesList.map((c) => c.name ?? '').toList(),
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
                        _showFilter = false;
                      });

                      final address = tempLocation != null ? _locations[tempLocation!] : null;
                      final categoryId = tempPracticeArea != null ? controller.categoriesList[tempPracticeArea!].id : null;
                      final exp = tempExperience != null ? _mapExperienceToYears(tempExperience!) : null;
                      final lang = tempLanguage != null ? _languages[tempLanguage!] : null;

                      controller.selectedCategoryId.value = categoryId;
                      controller.applyFilters(
                        address: address,
                        experience: exp,
                        language: lang,
                      );

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
