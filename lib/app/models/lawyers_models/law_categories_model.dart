class CategoryModel {
  int? id;
  String? name;
  String? code;
  String? logo;
  String? status;
  String? createdAt;
  String? updatedAt;
  PivotModel? pivot;
  String? lawyersCount;

  CategoryModel({
    this.id,
    this.name,
    this.code,
    this.logo,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.pivot,
    this.lawyersCount,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as int?,
      name: map['name']?.toString(),
      code: map['code']?.toString(),
      logo: map['logo']?.toString(),
      status: map['status']?.toString(),
      createdAt: map['created_at']?.toString(),
      updatedAt: map['updated_at']?.toString(),
      pivot: map['pivot'] != null
          ? PivotModel.fromMap(map['pivot'] as Map<String, dynamic>)
          : null,
      lawyersCount: map['lawyers_count'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'logo': logo,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'lawyers_count': lawyersCount,
      'pivot': pivot?.toMap(),
    };
  }
}

class PivotModel {
  String? lawyerId;
  String? categoryId;

  PivotModel({this.lawyerId, this.categoryId});

  factory PivotModel.fromMap(Map<String, dynamic> map) {
    return PivotModel(
      lawyerId: map['lawyer_id']?.toString(),
      categoryId: map['category_id']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {'lawyer_id': lawyerId, 'category_id': categoryId};
  }
}
