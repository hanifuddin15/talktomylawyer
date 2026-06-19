import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talktomylawyer/app/models/lawyers_models/law_categories_model.dart';
import 'package:talktomylawyer/app/models/lawyers_models/lawyer_user_model.dart';
import 'package:talktomylawyer/app/repository/client_home_repository.dart';

class ClientSearchController extends GetxController {
  // Search text controller
  final TextEditingController searchTextController = TextEditingController();

  // Categories
  final RxList<CategoryModel> categoriesList = <CategoryModel>[].obs;
  final RxBool isCategoriesLoading = false.obs;

  // Lawyers
  final RxList<LawyerModel> lawyersList = <LawyerModel>[].obs;
  final RxBool isLawyersLoading = false.obs;

  // Selected Category ID for search tab (null for "All")
  final Rx<int?> selectedCategoryId = Rx<int?>(null);

  // Search query text
  final RxString searchQuery = ''.obs;

  // Filter state
  final Rx<String?> filterAddress = Rx<String?>(null);
  final Rx<int?> filterExperience = Rx<int?>(null);
  final Rx<String?> filterLanguage = Rx<String?>(null);

  // UI Filter selection indices
  final Rx<int?> selectedLocationIndex = Rx<int?>(null);
  final Rx<int?> selectedPracticeAreaIndex = Rx<int?>(null);
  final Rx<int?> selectedExperienceIndex = Rx<int?>(null);
  final Rx<int?> selectedLanguageIndex = Rx<int?>(null);
  final Rx<int?> selectedConsultationIndex = Rx<int?>(null);
  final RxBool verifiedOnly = false.obs;

  @override
  void onInit() {
    super.onInit();
    searchTextController.text = searchQuery.value;
    searchTextController.addListener(() {
      searchQuery.value = searchTextController.text;
    });
    // Debounce search query text changes to limit API request frequency
    debounce(searchQuery, (String query) {
      fetchLawyers(search: query);
    }, time: const Duration(milliseconds: 500));

    fetchCategories();
    fetchLawyers();
  }

  @override
  void onClose() {
    searchTextController.dispose();
    super.onClose();
  }

  Future<void> fetchCategories() async {
    isCategoriesLoading.value = true;
    try {
      final list = await ClientHomeRepository.instance.getCategories();
      categoriesList.assignAll(list);
    } catch (e) {
      // Handled
    } finally {
      isCategoriesLoading.value = false;
    }
  }

  Future<void> fetchLawyers({String? search}) async {
    isLawyersLoading.value = true;
    final query = search ?? searchQuery.value;
    try {
      final list = await ClientHomeRepository.instance.getLawyers(
        categoryId: selectedCategoryId.value,
        address: filterAddress.value,
        experience: filterExperience.value,
        language: filterLanguage.value,
        search: query.trim().isEmpty ? null : query.trim(),
      );
      lawyersList.assignAll(list);
    } catch (e) {
      // Handled
    } finally {
      isLawyersLoading.value = false;
    }
  }

  void updateCategoryFilter(int? catId) {
    selectedCategoryId.value = catId;
    fetchLawyers();
  }

  void applyFilters({String? address, int? experience, String? language}) {
    filterAddress.value = address;
    filterExperience.value = experience;
    filterLanguage.value = language;
    fetchLawyers();
  }

  void resetFilters() {
    filterAddress.value = null;
    filterExperience.value = null;
    filterLanguage.value = null;
    selectedCategoryId.value = null;

    // Clear UI indices
    selectedLocationIndex.value = null;
    selectedPracticeAreaIndex.value = null;
    selectedExperienceIndex.value = null;
    selectedLanguageIndex.value = null;
    selectedConsultationIndex.value = null;
    verifiedOnly.value = false;

    fetchLawyers();
  }
}
