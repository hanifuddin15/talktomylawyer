import 'package:talktomylawyer/app/core/models/api_response.dart';
import 'package:talktomylawyer/app/core/services/api_communication.dart';
import 'package:talktomylawyer/app/models/lawyers_models/law_categories_model.dart';
import 'package:talktomylawyer/app/models/lawyers_models/lawyer_user_model.dart';
import 'package:talktomylawyer/app/models/client_models/subscription_model.dart';

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
          .map((item) => SubscriptionModel.fromMap(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }
}
