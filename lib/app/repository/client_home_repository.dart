import 'package:get/get.dart';
import 'package:talktomylawyer/app/core/config/api_constant.dart';
import 'package:talktomylawyer/app/core/models/api_response.dart';
import 'package:talktomylawyer/app/core/services/api_communication.dart';
import 'package:talktomylawyer/app/models/lawyers_models/law_categories_model.dart';
import 'package:talktomylawyer/app/models/lawyers_models/lawyer_user_model.dart';
import 'package:talktomylawyer/app/models/client_models/subscription_model.dart';
import 'package:talktomylawyer/app/modules/client_dashboard/controllers/client_home_controller.dart';
import 'package:talktomylawyer/app/modules/client_dashboard/controllers/client_search_controller.dart';
import 'package:talktomylawyer/app/modules/client_dashboard/controllers/client_saved_controller.dart';
import 'package:talktomylawyer/app/modules/client_dashboard/controllers/client_dashboard_controller.dart';
import 'package:talktomylawyer/app/modules/lawyer_details/controllers/lawyer_details_controller.dart';

class ClientHomeRepository {
  ClientHomeRepository._internal();

  static final ClientHomeRepository instance = ClientHomeRepository._internal();

  factory ClientHomeRepository() {
    return instance;
  }

  final ApiCommunication _apiCommunication = ApiCommunication.instance;

  Future<List<CategoryModel>> getCategories() async {
    final ApiResponse response = await _apiCommunication.doGetRequest(
      apiEndPoint: 'categories',
      responseDataKey: 'data',
      enableLoading: false,
    );
    if (response.isSuccessful && response.data != null) {
      final List<dynamic> list = response.data as List<dynamic>;
      return list
          .map((item) => CategoryModel.fromMap(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  Future<List<LawyerModel>> getLawyers({
    int? categoryId,
    String? address,
    int? experience,
    String? language,
    String? search,
  }) async {
    final Map<String, dynamic> queryParams = {};
    if (categoryId != null) queryParams['category_id'] = categoryId;
    if (address != null && address.isNotEmpty) queryParams['address'] = address;
    if (experience != null) queryParams['experience'] = experience;
    if (language != null && language.isNotEmpty) {
      queryParams['language'] = language;
    }
    if (search != null && search.isNotEmpty) queryParams['search'] = search;

    final ApiResponse response = await _apiCommunication.doGetRequest(
      apiEndPoint: 'lawyers',
      queryParams: queryParams,
      responseDataKey: 'data',
      enableLoading: false,
    );

    if (response.isSuccessful && response.data != null) {
      final List<dynamic> list = response.data as List<dynamic>;
      return list
          .map((item) => LawyerModel.fromMap(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  Future<LawyerModel?> getLawyerDetails(int id) async {
    final ApiResponse response = await _apiCommunication.doGetRequest(
      apiEndPoint: 'lawyers/$id',
      responseDataKey: 'data',
      enableLoading: false,
    );

    if (response.isSuccessful && response.data != null) {
      return LawyerModel.fromMap(response.data as Map<String, dynamic>);
    }
    return null;
  }

  Future<List<SubscriptionModel>> getSubscriptions() async {
    final ApiResponse response = await _apiCommunication.doGetRequest(
      apiEndPoint: 'subscriptions',
      responseDataKey: 'data',
      enableLoading: false,
    );

    if (response.isSuccessful && response.data != null) {
      final List<dynamic> list = response.data as List<dynamic>;
      return list
          .map(
            (item) => SubscriptionModel.fromMap(item as Map<String, dynamic>),
          )
          .toList();
    }
    return [];
  }

  Future<List<LawyerModel>> getSavedLawyers() async {
    final ApiResponse response = await _apiCommunication.doGetRequest(
      apiEndPoint: 'saved-lawyers',
      responseDataKey: 'data',
      enableLoading: false,
    );

    if (response.isSuccessful && response.data != null) {
      List<dynamic> list = [];
      if (response.data is List) {
        list = response.data as List<dynamic>;
      } else if (response.data is Map &&
          (response.data as Map)['data'] is List) {
        list = (response.data as Map)['data'] as List<dynamic>;
      }
      return list
          .map((item) => LawyerModel.fromMap(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  Future<bool?> toggleSaveLawyer(int lawyerId) async {
    final ApiResponse response = await _apiCommunication.doPostRequest(
      apiEndPoint: 'lawyers/$lawyerId/save',
      enableLoading: true,
      responseDataKey: ApiConstant.fullResponse,
      showSuccessMessage: true,
    );

    if (response.isSuccessful && response.data != null) {
      final Map<String, dynamic> data = response.data as Map<String, dynamic>;
      return data['is_saved'] as bool?;
    }
    return null;
  }

  static void syncLawyerSavedStatus(int lawyerId, bool isSaved) {
    // 1. Update ClientHomeController
    if (Get.isRegistered<ClientHomeController>()) {
      try {
        final homeCtrl = Get.find<ClientHomeController>();
        for (var l in homeCtrl.featuredLawyersList) {
          if (l.id == lawyerId) {
            l.isSaved = isSaved;
          }
        }
        homeCtrl.featuredLawyersList.refresh();
      } catch (_) {}
    }

    // 2. Update ClientSearchController
    if (Get.isRegistered<ClientSearchController>()) {
      try {
        final searchCtrl = Get.find<ClientSearchController>();
        for (var l in searchCtrl.lawyersList) {
          if (l.id == lawyerId) {
            l.isSaved = isSaved;
          }
        }
        searchCtrl.lawyersList.refresh();
      } catch (_) {}
    }

    // 3. Update ClientSavedController
    if (Get.isRegistered<ClientSavedController>()) {
      try {
        final savedCtrl = Get.find<ClientSavedController>();
        if (isSaved) {
          savedCtrl.fetchSavedLawyers();
        } else {
          savedCtrl.savedLawyersList.removeWhere((l) => l.id == lawyerId);
        }
      } catch (_) {}
    }

    // 4. Update LawyerDetailsController
    if (Get.isRegistered<LawyerDetailsController>()) {
      try {
        final detailsCtrl = Get.find<LawyerDetailsController>();
        if (detailsCtrl.lawyer.value?.id == lawyerId) {
          detailsCtrl.lawyer.value?.isSaved = isSaved;
          detailsCtrl.isSaved.value = isSaved;
          detailsCtrl.lawyer.refresh();
        }
      } catch (_) {}
    }

    // 5. Update ClientDashboardController
    if (Get.isRegistered<ClientDashboardController>()) {
      try {
        final dashCtrl = Get.find<ClientDashboardController>();
        for (var l in dashCtrl.featuredLawyersList) {
          if (l.id == lawyerId) {
            l.isSaved = isSaved;
          }
        }
        for (var l in dashCtrl.lawyersList) {
          if (l.id == lawyerId) {
            l.isSaved = isSaved;
          }
        }
        dashCtrl.featuredLawyersList.refresh();
        dashCtrl.lawyersList.refresh();
      } catch (_) {}
    }
  }
}
