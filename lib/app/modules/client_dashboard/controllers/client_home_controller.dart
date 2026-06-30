import 'package:get/get.dart';
import 'package:talktomylawyer/app/models/client_models/client_user_model.dart';
import 'package:talktomylawyer/app/models/lawyers_models/law_categories_model.dart';
import 'package:talktomylawyer/app/models/lawyers_models/lawyer_user_model.dart';
import 'package:talktomylawyer/app/repository/client_auth_repository.dart';
import 'package:talktomylawyer/app/repository/client_home_repository.dart';

class ClientHomeController extends GetxController {
  Rxn<ClientModel> get clientModel => ClientAuthRepository.instance.clientData;

  // Categories
  final RxList<CategoryModel> categoriesList = <CategoryModel>[].obs;
  final RxBool isCategoriesLoading = false.obs;

  // Featured Lawyers
  final RxList<LawyerModel> featuredLawyersList = <LawyerModel>[].obs;
  final RxBool isFeaturedLawyersLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchFeaturedLawyers();
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

  Future<void> toggleSaveLawyer(LawyerModel lawyer) async {
    final int? id = lawyer.id;
    if (id == null) return;
    try {
      final isSavedResult = await ClientHomeRepository.instance.toggleSaveLawyer(id);
      if (isSavedResult != null) {
        lawyer.isSaved = isSavedResult;
        featuredLawyersList.refresh();
      }
    } catch (e) {
      // Handled
    }
  }
}
