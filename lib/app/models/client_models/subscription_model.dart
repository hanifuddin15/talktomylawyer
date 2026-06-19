import 'dart:convert';

class SubscriptionModel {
  final int? id;
  final String? name;
  final String? price;
  final String? currency;
  final String? durationType;
  final String? duration;
  final String? savePercentage;
  final String? badgeText;
  final String? status;
  final List<String>? features;
  final String? description;
  final String? createdAt;
  final String? updatedAt;

  SubscriptionModel({
    this.id,
    this.name,
    this.price,
    this.currency,
    this.durationType,
    this.duration,
    this.savePercentage,
    this.badgeText,
    this.status,
    this.features,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory SubscriptionModel.fromMap(Map<String, dynamic> map) {
    return SubscriptionModel(
      id: map['id'] as int?,
      name: map['name'] as String?,
      price: map['price'] as String?,
      currency: map['currency'] as String?,
      durationType: map['duration_type'] as String?,
      duration: map['duration']?.toString(),
      savePercentage: map['save_percentage']?.toString(),
      badgeText: map['badge_text']?.toString(),
      status: map['status'] as String?,
      features: map['features'] != null
          ? List<String>.from((map['features'] as List).map((e) => e.toString()))
          : null,
      description: map['description'] as String?,
      createdAt: map['created_at'] as String?,
      updatedAt: map['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'currency': currency,
      'duration_type': durationType,
      'duration': duration,
      'save_percentage': savePercentage,
      'badge_text': badgeText,
      'status': status,
      'features': features,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  String toJson() => json.encode(toMap());

  factory SubscriptionModel.fromJson(String source) =>
      SubscriptionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
