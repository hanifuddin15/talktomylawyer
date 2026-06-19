import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as dio;
import 'package:talktomylawyer/app/core/services/api_communication.dart';
import 'package:talktomylawyer/app/core/services/caching_service.dart';
import 'package:talktomylawyer/app/models/lawyers_models/lawyer_user_model.dart';

import 'package:talktomylawyer/app/models/lawyers_models/law_categories_model.dart';
import 'package:talktomylawyer/app/core/utils/network.dart';

import '../core/config/api_constant.dart';
import '../core/config/data_key.dart';
import '../core/error/failure.dart';
import '../core/extensions/nullable_object.dart';
import '../core/models/api_response.dart';
import '../core/models/user.dart';

class LawyerAuthRepository {
  //* ============================= CHANGE PASSWORD ============================

  LawyerAuthRepository._internal();

  static final LawyerAuthRepository instance = LawyerAuthRepository._internal();

  factory LawyerAuthRepository() {
    return instance;
  }

  final CachingService _cachingService = CachingService.instance;
  final ApiCommunication _apiCommunication = ApiCommunication.instance;

  /*
   * ┏==================================================================================================┓
   * ┃                                          Network Calls                                           ┃
   * ┗==================================================================================================┛
   */

  Future<UserModel?> loginUser({
    required String userId,
    required String password,
  }) async {
    final ApiResponse response = await _apiCommunication.doPostRequest(
      apiEndPoint: 'auth/login/',
      requestData: {'email': userId, 'password': password},
      isFormData: false,
      responseDataKey: ApiConstant.fullResponse,
      showSuccessMessage: true,
      addUserData: false,
      successMessage: 'You are successfully logged in',
    );
    if (response.isSuccessful) {
      Map<String, dynamic> fullResponse = response.data as Map<String, dynamic>;
      UserModel user = UserModel.fromMap(fullResponse['results']['user']);
      saveUserData(user);
      String token = fullResponse['results']['accessToken'];
      String refreshToken = fullResponse['results']['refreshToken'];
      cacheAccessToken(token);
      cacheRefreshToken(refreshToken);
      _apiCommunication.updateTokenAndHeader(token);
      return user;
    } else {
      return null;
    }
  }

  Future<LawyerModel?> loginLawyer({
    required String email,
    required String password,
  }) async {
    final ApiResponse response = await _apiCommunication.doPostRequest(
      apiEndPoint: 'lawyer-login',
      requestData: {'email': email, 'password': password},
      isFormData: false,
      responseDataKey: ApiConstant.fullResponse,
      showSuccessMessage: true,
      addUserData: false,
      successMessage: 'Lawyer logged in successfully',
    );
    if (response.isSuccessful && response.data != null) {
      final Map<String, dynamic> fullResponse =
          response.data as Map<String, dynamic>;
      final lawyerData = fullResponse['lawyer'];
      final token = fullResponse['token'] as String?;

      if (lawyerData != null && token != null) {
        final lawyer = LawyerModel.fromMap(lawyerData);

        // Cache token & role & lawyer user model
        await _cachingService.saveAuthToken(token);
        await _cachingService.saveData(
          DataKey.accessToken,
          token,
        ); // For general app token check
        await _cachingService.saveUserRole('lawyer');
        await _cachingService.saveLawyerUser(lawyer.toJson());

        // Update token in ApiCommunication
        _apiCommunication.updateTokenAndHeader(token);

        return lawyer;
      }
    }
    return null;
  }

  Future<Either<Failure, ApiResponse>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      Map<String, dynamic> inputData = {
        'oldPassword': currentPassword,
        'newPassword': newPassword,
      };

      ApiResponse response = await _apiCommunication.doPostRequest(
        apiEndPoint: 'Accounts/AcChangePassword',
        responseDataKey: 'data',
        requestData: inputData,
        isFormData: false,
        showSuccessMessage: true,
      );

      if (response.isSuccessful) {
        return Right(response);
      } else {
        return Left(Failure(message: 'Fail to change password'));
      }
    } catch (e) {
      return Left(Failure(message: 'Fail to change password'));
    }
  }

  /*
   * ┏==================================================================================================┓
   * ┃                                       Save Data                                                  ┃
   * ┗==================================================================================================┛
   */

  Future<void> cacheServerCredential({
    required String ipPort,
    required String imagePath,
  }) async {
    await _cachingService.saveData(DataKey.ipPort, ipPort);
    await _cachingService.saveData(DataKey.imagePath, imagePath);
  }

  Future<void> cacheAccessToken(String token) async {
    await _cachingService.saveData(DataKey.accessToken, token);
    await _cachingService.saveData('auth_token', token);
  }

  Future<void> cacheRefreshToken(String token) async {
    await _cachingService.saveData(DataKey.refreshToken, token);
  }

  Future<void> saveUserData(UserModel model) async {
    await _cachingService.saveData(DataKey.user, model.toJson());
    await _cachingService.saveData('user_role', model.role ?? 'lawyer');
  }

  /*
   * ┏==================================================================================================┓
   * ┃                                         Get Data                                                 ┃
   * ┗==================================================================================================┛
   */

  // String? getIpPortData() {
  //   String? ipPort = _cachingService.getData(DataKey.ipPort);
  //   return ipPort;
  // }

  // String? getImagePathData() {
  //   String? imagePath = _cachingService.getData(DataKey.imagePath);
  //   return imagePath;
  // }

  String? getToken() {
    String? token = _cachingService.getData(DataKey.accessToken);
    if (token == null || token.isEmpty) {
      token = _cachingService.getData('auth_token');
    }
    return token;
  }

  UserModel? getUserData() {
    final String userJson = _cachingService.getData(DataKey.user);
    if (userJson.isNotNullOrEmpty) {
      UserModel model = UserModel.fromJson(userJson);
      return model;
    } else {
      return null;
    }
  }

  LawyerModel? getLawyerData() {
    final String? lawyerJson = _cachingService.getLawyerUser();
    if (lawyerJson != null && lawyerJson.isNotEmpty) {
      return LawyerModel.fromJson(lawyerJson);
    }
    return null;
  }

  /*
   * ┏==================================================================================================┓
   * ┃                                      Delete Data                                                 ┃
   * ┗==================================================================================================┛
   */

  void clearAuthCredential() async {
    await _cachingService.removeData(DataKey.accessToken);
    await _cachingService.removeData('auth_token');
    await _cachingService.removeData(DataKey.user);
    await _cachingService.removeData('user_role');
    await _cachingService.removeData('client_user');
    await _cachingService.removeData('lawyer_user');
  }
  /*
   * ┏==================================================================================================┓
   * ┃                                      Check Data.                                                 ┃
   * ┗==================================================================================================┛
   */

  bool isUserLoggedIn() {
    if (hasToken) {
      return true;
    } else {
      return false;
    }
  }

  bool get hasToken {
    return _cachingService.hasData(DataKey.accessToken);
  }

  bool get hasIpPort {
    return _cachingService.hasData(DataKey.ipPort);
  }

  bool get hasImagePath {
    return _cachingService.hasData(DataKey.imagePath);
  }

  Future<bool> registerLawyer({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String experience,
    required String education,
    required String barNumber,
    required List<int> specializations,
    required File profilePic,
    required File licence,
    required File nid,
  }) async {
    final Map<String, dynamic> requestData = {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'number_of_experience': experience,
      'last_education': education,
      'bar_coucil_number': barNumber,
    };

    for (int i = 0; i < specializations.length; i++) {
      requestData['specializations[$i]'] = specializations[i].toString();
    }

    requestData['profile_pic'] = await dio.MultipartFile.fromFile(
      profilePic.path,
      filename: profilePic.path.split('/').last,
    );

    requestData['licence'] = await dio.MultipartFile.fromFile(
      licence.path,
      filename: licence.path.split('/').last,
    );

    requestData['nid'] = await dio.MultipartFile.fromFile(
      nid.path,
      filename: nid.path.split('/').last,
    );

    final ApiResponse response = await _apiCommunication.doPostRequest(
      apiEndPoint: 'lawyer-registration',
      requestData: requestData,
      isFormData: true,
      responseDataKey: ApiConstant.fullResponse,
      showSuccessMessage: true,
      addUserData: false,
      successMessage: 'Lawyer registered successfully',
      // multipleFileKey:
      // files:
    );

    return response.isSuccessful;
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
