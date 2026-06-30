import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';
import 'package:talktomylawyer/app/core/config/api_constant.dart';
import 'package:talktomylawyer/app/core/widgets/app_lawyer_card.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:talktomylawyer/app/routes/app_pages.dart';
import 'package:talktomylawyer/app/modules/client_dashboard/controllers/client_saved_controller.dart';

class ClientSavedTab extends GetView<ClientSavedController> {
  const ClientSavedTab({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? kDarkBg : kLightBg;
    final primaryText = isDark ? kDarkTextPrimary : kLightTextPrimary;
    final secondaryText = isDark ? kDarkTextSecondary : kLightTextSecondary;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'saved_lawyers'.tr,
                style: GoogleFonts.outfit(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: primaryText,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Skeletonizer(
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return const AppLawyerCard(
                            name: 'Loading Lawyer...',
                            title: 'Loading Title...',
                            tags: ['Tag 1', 'Tag 2'],
                            rating: 4.8,
                            reviewCount: 120,
                            experience: 5,
                            location: 'Loading...',
                            availability: 'Loading...',
                            rate: 2000,
                          );
                        },
                      ),
                    );
                  }

                  final list = controller.savedLawyersList;

                  if (list.isEmpty) {
                    return RefreshIndicator(
                      onRefresh: () => controller.fetchSavedLawyers(),
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                          Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: kPrimaryBlue.withValues(alpha: 0.12),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.bookmark_outline,
                                    color: kPrimaryBlue,
                                    size: 36,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No Saved Lawyers',
                                  style: GoogleFonts.outfit(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: primaryText,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Bookmark lawyers to access them quickly',
                                  style: GoogleFonts.outfit(
                                    fontSize: 14,
                                    color: secondaryText,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () => controller.fetchSavedLawyers(),
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final lawyer = list[index];
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
                          rate: int.tryParse(lawyer.consultationFee ?? '2000') ?? 2000,
                          avatarUrl: avatar,
                          initials: initials,
                          isSaved: true,
                          onSave: () => controller.removeSavedLawyer(lawyer.id),
                          onTap: () => Get.toNamed(
                            Routes.lawyerDetails,
                            arguments: lawyer.id,
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
