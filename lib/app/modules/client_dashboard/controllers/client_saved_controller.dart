import 'package:get/get.dart';
import 'package:talktomylawyer/app/models/lawyers_models/lawyer_user_model.dart';
import 'package:talktomylawyer/app/repository/client_home_repository.dart';

class ClientSavedController extends GetxController {
  final RxList<LawyerModel> savedLawyersList = <LawyerModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSavedLawyers();
  }

  Future<void> fetchSavedLawyers() async {
    isLoading.value = true;
    try {
      final list = await ClientHomeRepository.instance.getSavedLawyers();
      savedLawyersList.assignAll(list);
    } catch (e) {
      // Handled
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeSavedLawyer(int? lawyerId) async {
    if (lawyerId == null) return;
    try {
      final isSavedResult = await ClientHomeRepository.instance.toggleSaveLawyer(lawyerId);
      if (isSavedResult == false) {
        // Remove from local list
        savedLawyersList.removeWhere((l) => l.id == lawyerId);
      }
    } catch (e) {
      // Handled
    }
  }
}
