import 'package:get/get.dart';
import 'package:talktomylawyer/app/models/client_models/subscription_model.dart';
import 'package:talktomylawyer/app/repository/client_home_repository.dart';

class ClientPremiumController extends GetxController {
  final RxInt selectedPlan = 0.obs; // Tracks selected plan index
  final RxList<SubscriptionModel> subscriptions = <SubscriptionModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSubscriptions();
  }

  Future<void> fetchSubscriptions() async {
    isLoading.value = true;
    try {
      final list = await ClientHomeRepository.instance.getSubscriptions();
      subscriptions.assignAll(list);
      if (subscriptions.isNotEmpty) {
        if (subscriptions.length > 1) {
          selectedPlan.value = 1;
        } else {
          selectedPlan.value = 0;
        }
      }
    } catch (e) {
      // Handled
    } finally {
      isLoading.value = false;
    }
  }
}
