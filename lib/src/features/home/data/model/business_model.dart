class Business {
  final int id;
  final String name;
  final String category;
  final String description;
  final String userFullName;
  final String userPhone;
  final String userEmail;
  final String? image;
  final int categoryId; // ✅ используем это для фильтрации

  Business({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.userEmail,
    required this.userFullName,
    required this.userPhone,
    this.image,
    required this.categoryId,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      name: json['name']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      userPhone: json['user_phone']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      image: json['image']?.toString(),
      userEmail: json["user_email"]?.toString() ?? '',
      userFullName: json["user_full_name"]?.toString() ?? '',
      categoryId: json['category'], // ✅ ПРАВИЛЬНО ПОДКЛЮЧАЕМ
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "id" : id,
      "name" : name,
      "category" : category,
      "userPhone" : userPhone,
      "description" : description,
      "image" : image,
      "userFullName" : userFullName,
      "categoryId" : categoryId,
    };
  }
}
