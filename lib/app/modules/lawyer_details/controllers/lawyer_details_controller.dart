import 'package:get/get.dart';
import 'package:talktomylawyer/app/repository/client_auth_repository.dart';
import 'package:talktomylawyer/app/modules/client_dashboard/controllers/client_dashboard_controller.dart';
import 'package:talktomylawyer/app/modules/client_dashboard/controllers/client_home_controller.dart';
import 'package:talktomylawyer/app/modules/client_dashboard/controllers/client_search_controller.dart';
import 'package:talktomylawyer/app/modules/client_dashboard/controllers/client_saved_controller.dart';
import 'package:talktomylawyer/app/models/lawyers_models/lawyer_user_model.dart';
import 'package:talktomylawyer/app/repository/client_home_repository.dart';

class LawyerDetailsController extends GetxController {
  final RxBool isLoading = false.obs;
  final Rx<LawyerModel?> lawyer = Rx<LawyerModel?>(null);
  final RxInt activeTab = 0.obs; // 0 = About, 1 = Reviews, 2 = Availability
  final RxBool isSaved = false.obs;

  final RxBool hasSubscription = false.obs;

  bool checkSubscription() {
    final client = ClientAuthRepository.instance.getClientData();
    if (client == null) return false;
    final sub = client.subscription;
    if (sub == null) return false;
    final status = sub.status?.trim().toLowerCase();
    return status == 'active' || status == 'premium';
  }

  void updateSubscriptionStatus() {
    hasSubscription.value = checkSubscription();
  }

  void navigateToPremiumTab() {
    try {
      final dashboardController = Get.find<ClientDashboardController>();
      dashboardController.changeTab(3);
      Get.back();
    } catch (_) {
      Get.offAllNamed('/client_dashboard');
      Future.delayed(const Duration(milliseconds: 100), () {
        try {
          Get.find<ClientDashboardController>().changeTab(3);
        } catch (_) {}
      });
    }
  }

  bool _checkIsSavedLocally(int id, bool apiIsSaved) {
    if (Get.isRegistered<ClientSavedController>()) {
      try {
        final savedCtrl = Get.find<ClientSavedController>();
        for (var l in savedCtrl.savedLawyersList) {
          if (l.id == id) return true;
        }
      } catch (_) {}
    }
    if (Get.isRegistered<ClientHomeController>()) {
      try {
        final homeCtrl = Get.find<ClientHomeController>();
        for (var l in homeCtrl.featuredLawyersList) {
          if (l.id == id) return l.isSaved ?? false;
        }
      } catch (_) {}
    }
    if (Get.isRegistered<ClientSearchController>()) {
      try {
        final searchCtrl = Get.find<ClientSearchController>();
        for (var l in searchCtrl.lawyersList) {
          if (l.id == id) return l.isSaved ?? false;
        }
      } catch (_) {}
    }
    return apiIsSaved;
  }

  @override
  void onInit() {
    super.onInit();
    updateSubscriptionStatus();
    final dynamic arg = Get.arguments;
    if (arg is int) {
      isSaved.value = _checkIsSavedLocally(arg, false);
      fetchLawyerDetails(arg);
    } else if (arg is String) {
      final id = int.tryParse(arg);
      if (id != null) {
        isSaved.value = _checkIsSavedLocally(id, false);
        fetchLawyerDetails(id);
      }
    } else if (arg is Map) {
      final id = arg['id'] as int?;
      final saved = arg['isSaved'] as bool?;
      if (saved != null) {
        isSaved.value = saved;
      }
      if (id != null) {
        isSaved.value = _checkIsSavedLocally(id, isSaved.value);
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
        isSaved.value = _checkIsSavedLocally(id, details.isSaved ?? false);
      }
    } catch (e) {
      // Handled
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleSave() async {
    final int? id = lawyer.value?.id;
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
