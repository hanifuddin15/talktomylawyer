import 'dart:convert';
import 'package:talktomylawyer/app/models/lawyers_models/lawyer_user_model.dart';
import 'package:talktomylawyer/app/models/client_models/client_user_model.dart';

class AppointmentModel {
  int? id;
  String? clientId;
  String? lawyerId;
  String? scheduleDate; // Maps to schudule_date
  String? scheduleTime; // Maps to schudule_time
  String? status; // pending, accepted, completed, cancelled, etc.
  String? consultationMode; // Maps to consulation_mode
  String? consultationFee; // Maps to consulation_fee
  String? issue;
  String? createdAt;
  String? updatedAt;
  LawyerModel? lawyer;
  ClientModel? client;

  AppointmentModel({
    this.id,
    this.clientId,
    this.lawyerId,
    this.scheduleDate,
    this.scheduleTime,
    this.status,
    this.consultationMode,
    this.consultationFee,
    this.issue,
    this.createdAt,
    this.updatedAt,
    this.lawyer,
    this.client,
  });

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      id: map['id'] as int?,
      clientId: map['client_id']?.toString(),
      lawyerId: map['lawyer_id']?.toString(),
      scheduleDate: map['schudule_date'] as String?,
      scheduleTime: map['schudule_time'] as String?,
      status: map['status'] as String?,
      consultationMode: map['consulation_mode'] as String?,
      consultationFee: map['consulation_fee']?.toString(),
      issue: map['issue'] as String?,
      createdAt: map['created_at'] as String?,
      updatedAt: map['updated_at'] as String?,
      lawyer: map['lawyer'] != null
          ? LawyerModel.fromMap(map['lawyer'] as Map<String, dynamic>)
          : null,
      client: map['client'] != null
          ? ClientModel.fromMap(map['client'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'client_id': clientId,
      'lawyer_id': lawyerId,
      'schudule_date': scheduleDate,
      'schudule_time': scheduleTime,
      'status': status,
      'consulation_mode': consultationMode,
      'consulation_fee': consultationFee,
      'issue': issue,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'lawyer': lawyer?.toMap(),
      'client': client?.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  factory AppointmentModel.fromJson(String source) =>
      AppointmentModel.fromMap(json.decode(source));
}
