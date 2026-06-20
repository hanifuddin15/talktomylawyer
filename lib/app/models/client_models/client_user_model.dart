import 'dart:convert';

import 'package:talktomylawyer/app/models/client_models/subscription_model.dart';

class ClientModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? city;
  String? state;
  String? zip;
  String? country;
  String? createdAt;
  String? updatedAt;
  String? subscriptionId;
  DateTime? subscriptionExpiresAt;
  SubscriptionModel? subscription; //TODO: make subscription model later

  bool get hasActiveSubscription {
    if (subscriptionExpiresAt == null) return false;
    return subscriptionExpiresAt!.isAfter(DateTime.now());
  }

  ClientModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.city,
    this.state,
    this.zip,
    this.country,
    this.createdAt,
    this.updatedAt,
    this.subscription,
    this.subscriptionId,
    this.subscriptionExpiresAt,
  });

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      id: map['id'] as int?,
      name: map['name'] as String?,
      email: map['email'] as String?,
      phone: map['phone'] as String?,
      address: map['address'] as String?,
      city: map['city'] as String?,
      state: map['state'] as String?,
      zip: map['zip'] as String?,
      country: map['country'] as String?,
      createdAt: map['created_at'] as String?,
      updatedAt: map['updated_at'] as String?,
      subscriptionId: map['subscription_id'] as String?,
      subscriptionExpiresAt: map['subscription_expires_at'] != null
          ? DateTime.parse(map['subscription_expires_at'] as String)
          : null,
      subscription: map['subscription'] is Map
          ? SubscriptionModel.fromMap(
              map['subscription'] as Map<String, dynamic>,
            )
          : (map['subscription'] is String
                ? SubscriptionModel(status: map['subscription'] as String)
                : null),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'city': city,
      'state': state,
      'zip': zip,
      'country': country,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'subscription': subscription?.toMap(),
      'subscription_id': subscriptionId,
      'subscription_expires_at': subscriptionExpiresAt?.toIso8601String(),
    };
  }

  String toJson() => json.encode(toMap());

  factory ClientModel.fromJson(String source) =>
      ClientModel.fromMap(json.decode(source));
}
