import 'package:get/get.dart';
import 'package:talktomylawyer/app/models/client_models/client_user_model.dart';
import 'package:talktomylawyer/app/models/lawyers_models/law_categories_model.dart';
import 'package:talktomylawyer/app/models/lawyers_models/lawyer_user_model.dart';
import 'package:talktomylawyer/app/repository/client_auth_repository.dart';
import 'package:talktomylawyer/app/repository/client_home_repository.dart';

class ClientDashboardController extends GetxController {
  final RxInt currentTab = 0.obs;

  ClientModel clientModel =
      ClientAuthRepository.instance.getClientData() ?? ClientModel();

  // Categories
  final RxList<CategoryModel> categoriesList = <CategoryModel>[].obs;
  final RxBool isCategoriesLoading = false.obs;

  // Lawyers
  final RxList<LawyerModel> lawyersList = <LawyerModel>[].obs;
  final RxBool isLawyersLoading = false.obs;

  // Featured Lawyers for Home Tab
  final RxList<LawyerModel> featuredLawyersList = <LawyerModel>[].obs;
  final RxBool isFeaturedLawyersLoading = false.obs;

  // Selected Category ID for search tab (null for "All")
  final Rx<int?> selectedCategoryId = Rx<int?>(null);

  // Search query text
  final RxString searchQuery = ''.obs;

  // Filter state
  final Rx<String?> filterAddress = Rx<String?>(null);
  final Rx<int?> filterExperience = Rx<int?>(null);
  final Rx<String?> filterLanguage = Rx<String?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchLawyers();
    fetchFeaturedLawyers();
  }

  void changeTab(int index) => currentTab.value = index;

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

  Future<void> fetchLawyers() async {
    isLawyersLoading.value = true;
    try {
      final list = await ClientHomeRepository.instance.getLawyers(
        categoryId: selectedCategoryId.value,
        address: filterAddress.value,
        experience: filterExperience.value,
        language: filterLanguage.value,
      );
      lawyersList.assignAll(list);
    } catch (e) {
      // Handled
    } finally {
      isLawyersLoading.value = false;
    }
  }

  Future<void> fetchFeaturedLawyers() async {
    isFeaturedLawyersLoading.value = true;
    try {
      final list = await ClientHomeRepository.instance.getLawyers();
      featuredLawyersList.assignAll(list);
    } catch (e) {
      // Handled
    } finally {
      isFeaturedLawyersLoading.value = false;
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
    fetchLawyers();
  }

  Future<void> toggleSaveLawyer(LawyerModel lawyer) async {
    final int? id = lawyer.id;
    if (id == null) return;
    try {
      final isSavedResult = await ClientHomeRepository.instance.toggleSaveLawyer(id);
      if (isSavedResult != null) {
        ClientHomeRepository.syncLawyerSavedStatus(id, isSavedResult);
      }
    } catch (e) {
      // Handled
    }
  }
}
