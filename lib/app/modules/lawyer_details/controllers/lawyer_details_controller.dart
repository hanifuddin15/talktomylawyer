import 'package:get/get.dart';
import 'package:talktomylawyer/app/models/lawyers_models/lawyer_user_model.dart';
import 'package:talktomylawyer/app/repository/client_home_repository.dart';

class LawyerDetailsController extends GetxController {
  final RxBool isLoading = false.obs;
  final Rx<LawyerModel?> lawyer = Rx<LawyerModel?>(null);
  final RxInt activeTab = 0.obs; // 0 = About, 1 = Reviews, 2 = Availability
  final RxBool isSaved = false.obs;

  @override
  void onInit() {
    super.onInit();
    final dynamic arg = Get.arguments;
    if (arg is int) {
      fetchLawyerDetails(arg);
    } else if (arg is String) {
      final id = int.tryParse(arg);
      if (id != null) {
        fetchLawyerDetails(id);
      }
    }
  }

  Future<void> fetchLawyerDetails(int id) async {
    isLoading.value = true;
    try {
      final details = await ClientHomeRepository.instance.getLawyerDetails(id);
      if (details != null) {
        lawyer.value = details;
      }
    } catch (e) {
      // Handled
    } finally {
      isLoading.value = false;
    }
  }

  void toggleSave() {
    isSaved.value = !isSaved.value;
  }
}
