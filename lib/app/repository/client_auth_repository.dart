import 'package:get/get.dart';
import 'package:talktomylawyer/app/core/models/api_response.dart';
import 'package:talktomylawyer/app/core/services/api_communication.dart';
import 'package:talktomylawyer/app/core/services/caching_service.dart';
import 'package:talktomylawyer/app/models/client_models/client_user_model.dart';
import 'package:talktomylawyer/app/models/lawyers_models/law_categories_model.dart';
import 'package:talktomylawyer/app/models/lawyers_models/lawyer_user_model.dart';
import '../core/config/api_constant.dart';

class ClientAuthRepository {
  final Rxn<ClientModel> clientData = Rxn<ClientModel>();

  ClientAuthRepository._internal() {
    final String? clientJson = _cachingService.getClientUser();
    if (clientJson != null && clientJson.isNotEmpty) {
      clientData.value = ClientModel.fromJson(clientJson);
    }
  }

  static final ClientAuthRepository instance = ClientAuthRepository._internal();

  factory ClientAuthRepository() {
    return instance;
  }

  final CachingService _cachingService = CachingService.instance;
  final ApiCommunication _apiCommunication = ApiCommunication.instance;

  Future<ClientModel?> loginClient({
    required String email,
    required String password,
  }) async {
    final ApiResponse response = await _apiCommunication.doPostRequest(
      apiEndPoint: 'client-login',
      requestData: {'email': email, 'password': password},
      isFormData: false,
      responseDataKey: ApiConstant.fullResponse,
      showSuccessMessage: true,
      addUserData: false,
      successMessage: 'Client logged in successfully',
    );

    if (response.isSuccessful && response.data != null) {
      final Map<String, dynamic> fullResponse =
          response.data as Map<String, dynamic>;
      final clientData = fullResponse['client'];
      final token = fullResponse['token'] as String?;

      if (clientData != null && token != null) {
        final client = ClientModel.fromMap(clientData);

        // Cache token & role & client user model
        await _cachingService.saveAuthToken(token);
        await _cachingService.saveData(
          'accessToken',
          token,
        ); // For general app service token check
        await _cachingService.saveUserRole('client');
        await _cachingService.saveClientUser(client.toJson());
        this.clientData.value = client;

        // Update token in ApiCommunication
        _apiCommunication.updateTokenAndHeader(token);

        return client;
      }
    }
    return null;
  }

  Future<bool> registerClient({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    final ApiResponse response = await _apiCommunication.doPostRequest(
      apiEndPoint: 'client-registration',
      requestData: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      },
      isFormData: false,
      responseDataKey: ApiConstant.fullResponse,
      showSuccessMessage: true,
      addUserData: false,
      successMessage: 'Client created successfully',
    );

    return response.isSuccessful;
  }

  String? getToken() {
    return _cachingService.getAuthToken();
  }

  ClientModel? getClientData() {
    final String? clientJson = _cachingService.getClientUser();
    if (clientJson != null && clientJson.isNotEmpty) {
      return ClientModel.fromJson(clientJson);
    }
    return null;
  }

  bool isClientLoggedIn() {
    final String? token = getToken();
    final String? role = _cachingService.getUserRole();
    return token != null && token.isNotEmpty && role == 'client';
  }

  void clearClientCredentials() async {
    await _cachingService.removeData('auth_token');
    await _cachingService.removeData('accessToken');
    await _cachingService.removeData('user_role');
    await _cachingService.removeData('client_user');
    clientData.value = null;
  }

  Future<ClientModel?> updateClientProfile({
    required String name,
    required String phone,
    required String address,
    required String city,
    required String country,
  }) async {
    final ApiResponse response = await _apiCommunication.doPutRequest(
      apiEndPoint: 'client/profile',
      requestData: {
        'name': name,
        'phone': phone,
        'address': address,
        'city': city,
        'country': country,
      },
      responseDataKey: 'data',
      showSuccessMessage: true,
      successMessage: 'Client profile updated successfully',
    );

    if (response.isSuccessful && response.data != null) {
      final client = ClientModel.fromMap(response.data as Map<String, dynamic>);
      await _cachingService.saveClientUser(client.toJson());
      clientData.value = client;
      return client;
    }
    return null;
  }
}
