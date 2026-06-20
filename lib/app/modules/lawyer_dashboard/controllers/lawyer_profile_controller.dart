import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talktomylawyer/app/core/utils/snackbar.dart';
import 'package:talktomylawyer/app/models/lawyers_models/lawyer_user_model.dart';
import 'package:talktomylawyer/app/models/lawyers_models/law_categories_model.dart';
import 'package:talktomylawyer/app/repository/lawyer-auth-repository.dart';
import 'package:talktomylawyer/app/repository/lawyer_dashboard_repository.dart';

class LawyerProfileController extends GetxController {
  Rxn<LawyerModel> get lawyerData => LawyerAuthRepository.instance.lawyerData;
  final RxBool isEditing = false.obs;
  final RxBool isLoading = false.obs;

  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController addressController;
  late final TextEditingController experienceController;
  late final TextEditingController educationController;
  late final TextEditingController rateController;
  late final TextEditingController bioController;

  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxList<int> selectedCategoryIds = <int>[].obs;
  final RxBool isCategoriesLoading = false.obs;

  String get initials {
    final name = lawyerData.value?.name ?? 'User';
    if (name.isEmpty) return 'U';
    return name.trim().split(' ').map((e) => e.isNotEmpty ? e.substring(0, 1) : '').join().toUpperCase();
  }

  @override
  void onInit() {
    super.onInit();
    loadCategories();
    loadLawyerData();
  }

  Future<void> loadCategories() async {
    isCategoriesLoading.value = true;
    try {
      final list = await LawyerDashboardRepository.instance.getCategories();
      categories.assignAll(list);
    } catch (e) {
      showErrorSnackkbar(message: 'Failed to load categories: $e');
    } finally {
      isCategoriesLoading.value = false;
    }
  }

  void loadLawyerData() {
    final lawyer = lawyerData.value;

    nameController = TextEditingController(text: lawyer?.name ?? '');
    phoneController = TextEditingController(text: lawyer?.phone ?? '');
    addressController = TextEditingController(text: lawyer?.address ?? '');
    experienceController = TextEditingController(text: lawyer?.numberOfExperience ?? '');
    educationController = TextEditingController(text: lawyer?.lastEducation ?? '');
    rateController = TextEditingController(text: lawyer?.consultationFee ?? '');
    bioController = TextEditingController(text: lawyer?.biography ?? '');

    // Load specializations from categories
    selectedCategoryIds.clear();
    final lawyerCategories = lawyer?.categories ?? [];
    for (var cat in lawyerCategories) {
      if (cat.id != null) {
        selectedCategoryIds.add(cat.id!);
      }
    }
  }

  void toggleCategory(int? id) {
    if (id == null || !isEditing.value) return; // Non-editable in view mode
    if (selectedCategoryIds.contains(id)) {
      selectedCategoryIds.remove(id);
    } else {
      selectedCategoryIds.add(id);
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
      final updated = await LawyerAuthRepository.instance.updateLawyerProfile(
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        address: addressController.text.trim(),
        experience: experienceController.text.trim(),
        lastEducation: educationController.text.trim(),
        specializations: selectedCategoryIds.toList(),
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
