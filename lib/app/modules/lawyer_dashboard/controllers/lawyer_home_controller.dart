import 'package:get/get.dart';
import 'package:talktomylawyer/app/models/lawyers_models/lawyer_user_model.dart';
import 'package:talktomylawyer/app/repository/lawyer-auth-repository.dart';
import 'package:talktomylawyer/app/repository/lawyer_dashboard_repository.dart';

class LawyerHomeController extends GetxController {
  Rxn<LawyerModel> get lawyerModel => LawyerAuthRepository.instance.lawyerData;

  final RxBool isOverviewLoading = false.obs;
  final RxMap<String, dynamic> overviewData = <String, dynamic>{
    'profile_view': 0,
    'lead_of_this_month': 0,
    'consultation': 0,
    'rating': 0,
  }.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOverview();
  }

  Future<void> fetchOverview() async {
    isOverviewLoading.value = true;
    try {
      final data = await LawyerDashboardRepository.instance.getLawyerDashboardOverview();
      if (data != null) {
        overviewData.assignAll(data);
      }
    } catch (e) {
      // Handled
    } finally {
      isOverviewLoading.value = false;
    }
  }
}
