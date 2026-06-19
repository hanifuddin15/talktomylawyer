import 'package:talktomylawyer/app/core/models/api_response.dart';
import 'package:talktomylawyer/app/core/services/api_communication.dart';
import 'package:talktomylawyer/app/models/lawyers_models/law_categories_model.dart';

class LawyerDashboardRepository {
  LawyerDashboardRepository._internal();

  static final LawyerDashboardRepository instance = LawyerDashboardRepository._internal();

  factory LawyerDashboardRepository() {
    return instance;
  }

  final ApiCommunication _apiCommunication = ApiCommunication.instance;

  Future<Map<String, dynamic>?> getLawyerDashboardOverview() async {
    final ApiResponse response = await _apiCommunication.doGetRequest(
      apiEndPoint: 'lawyer-dashboard',
      responseDataKey: 'data',
      enableLoading: false,
    );
    if (response.isSuccessful && response.data != null) {
      return response.data as Map<String, dynamic>;
    }
    return null;
  }

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
}
