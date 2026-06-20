import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talktomylawyer/app/core/utils/snackbar.dart';
import 'package:talktomylawyer/app/models/lawyers_models/lawyer_user_model.dart';
import 'package:talktomylawyer/app/repository/lawyer-auth-repository.dart';

class LawyerProfileController extends GetxController {
  final Rxn<LawyerModel> lawyerData = Rxn<LawyerModel>();
  final RxBool isEditing = false.obs;
  final RxBool isLoading = false.obs;

  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController addressController;
  late final TextEditingController experienceController;
  late final TextEditingController educationController;
  late final TextEditingController rateController;
  late final TextEditingController bioController;

  final List<String> allAreas = const [
    'criminal_law',
    'family_law',
    'corporate_law',
    'civil_law',
    'property_law',
    'labour_law',
    'immigration',
    'tax_law',
  ];

  final Map<String, int> areaToId = {
    'criminal_law': 1,
    'family_law': 2,
    'corporate_law': 3,
    'civil_law': 4,
    'property_law': 5,
    'labour_law': 6,
    'immigration': 7,
    'tax_law': 8,
  };

  final RxList<String> selectedAreas = <String>[].obs;

  String get initials {
    final name = lawyerData.value?.name ?? 'User';
    if (name.isEmpty) return 'U';
    return name.trim().split(' ').map((e) => e.isNotEmpty ? e.substring(0, 1) : '').join().toUpperCase();
  }

  @override
  void onInit() {
    super.onInit();
    loadLawyerData();
  }

  void loadLawyerData() {
    final lawyer = LawyerAuthRepository.instance.getLawyerData();
    lawyerData.value = lawyer;

    nameController = TextEditingController(text: lawyer?.name ?? '');
    phoneController = TextEditingController(text: lawyer?.phone ?? '');
    addressController = TextEditingController(text: lawyer?.address ?? '');
    experienceController = TextEditingController(text: lawyer?.numberOfExperience ?? '');
    educationController = TextEditingController(text: lawyer?.lastEducation ?? '');
    rateController = TextEditingController(text: lawyer?.consultationFee ?? '');
    bioController = TextEditingController(text: lawyer?.biography ?? '');

    // Load specializations from categories
    selectedAreas.clear();
    final categories = lawyer?.categories ?? [];
    for (var cat in categories) {
      final area = areaToId.entries
          .firstWhere((entry) => entry.value == cat.id || entry.key == cat.name?.toLowerCase().replaceAll(' ', '_'),
              orElse: () => const MapEntry('', 0))
          .key;
      if (area.isNotEmpty) {
        selectedAreas.add(area);
      }
    }
  }

  void toggleArea(String area) {
    if (!isEditing.value) return; // Non-editable in view mode
    if (selectedAreas.contains(area)) {
      selectedAreas.remove(area);
    } else {
      selectedAreas.add(area);
    }
  }

  void toggleEdit() {
    isEditing.value = !isEditing.value;
    if (!isEditing.value) {
      loadLawyerData(); // Reset on cancel
    }
  }

  Future<void> saveChanges() async {
    isLoading.value = true;
    try {
      final List<int> specIds = selectedAreas
          .map((area) => areaToId[area])
          .where((id) => id != null)
          .cast<int>()
          .toList();

      final updated = await LawyerAuthRepository.instance.updateLawyerProfile(
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        address: addressController.text.trim(),
        experience: experienceController.text.trim(),
        lastEducation: educationController.text.trim(),
        specializations: specIds,
      );

      if (updated != null) {
        lawyerData.value = updated;
        isEditing.value = false;
        showSuccessSnackkbar(message: 'Lawyer profile updated successfully');
      }
    } catch (e) {
      showErrorSnackkbar(message: 'Failed to update profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    experienceController.dispose();
    educationController.dispose();
    rateController.dispose();
    bioController.dispose();
    super.onClose();
  }
}
