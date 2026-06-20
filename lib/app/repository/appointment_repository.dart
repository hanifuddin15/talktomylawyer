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
}
