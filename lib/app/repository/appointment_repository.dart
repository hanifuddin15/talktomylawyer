import 'package:talktomylawyer/app/core/models/api_response.dart';
import 'package:talktomylawyer/app/core/services/api_communication.dart';
import 'package:talktomylawyer/app/models/client_models/appointment_model.dart';

class AppointmentRepository {
  AppointmentRepository._internal();

  static final AppointmentRepository instance = AppointmentRepository._internal();

  factory AppointmentRepository() {
    return instance;
  }

  final ApiCommunication _apiCommunication = ApiCommunication.instance;

  Future<List<AppointmentModel>> getAppointments() async {
    final ApiResponse response = await _apiCommunication.doGetRequest(
      apiEndPoint: 'appointments',
      responseDataKey: 'appointments',
      enableLoading: false,
    );

    if (response.isSuccessful && response.data != null) {
      final List<dynamic> list = response.data as List<dynamic>;
      return list
          .map((item) => AppointmentModel.fromMap(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  Future<AppointmentModel?> getAppointmentDetails(int appointmentId) async {
    final ApiResponse response = await _apiCommunication.doGetRequest(
      apiEndPoint: 'appointments/$appointmentId',
      responseDataKey: 'data',
      enableLoading: false,
    );

    if (response.isSuccessful && response.data != null) {
      return AppointmentModel.fromMap(response.data as Map<String, dynamic>);
    }
    return null;
  }

  Future<List<AppointmentModel>> getLawyerAppointments({String? status}) async {
    final Map<String, dynamic> queryParams = {};
    if (status != null) {
      queryParams['status'] = status;
    }

    final ApiResponse response = await _apiCommunication.doGetRequest(
      apiEndPoint: 'lawyer/appointments',
      queryParams: queryParams,
      responseDataKey: 'appointments',
      enableLoading: false,
    );

    if (response.isSuccessful && response.data != null) {
      final List<dynamic> list = response.data as List<dynamic>;
      return list
          .map((item) => AppointmentModel.fromMap(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  Future<AppointmentModel?> updateAppointmentStatus(int appointmentId, String status) async {
    final ApiResponse response = await _apiCommunication.doPatchRequest(
      apiEndPoint: 'lawyer/appointments/$appointmentId?status=$status',
      requestData: {'status': status},
      responseDataKey: 'data',
      showSuccessMessage: true,
      successMessage: 'Appointment status updated successfully',
    );

    if (response.isSuccessful && response.data != null) {
      return AppointmentModel.fromMap(response.data as Map<String, dynamic>);
    }
    return null;
  }
}
