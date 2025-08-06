import 'package:dio/dio.dart';
import 'package:evo/src/features/home/data/model/business_model.dart';

class BusinessService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://127.0.0.1:8000/api/'));

  Future<List<Business>> fetchBusinesses() async {
    try {
      final response = await _dio.get('businesses/');
      final List data = response.data;
      return data.map((json) => Business.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching businesses: $e');
      return [];
    }
  }

Future<void> addBusiness({
  required String userFullName,
  required String userPhone,
  required String description,
  required String photoPath,
  required int categoryId, // 👈 добавить параметр
}) async {
  final formData = FormData.fromMap({
    'user_full_name': userFullName,
    'user_phone': userPhone,
    'description': description,
    'categoryId': categoryId.toString(), // 👈 обязательно
    'photo': await MultipartFile.fromFile(photoPath, filename: 'photo.jpg'),
  });

  await _dio.post('businesses/', data: formData);
}


  Future<bool> deleteBusiness(String id) async {
    try {
      final response = await _dio.delete('businesses/$id/');
      return response.statusCode == 204;
    } catch (e) {
      print('Error deleting business: $e');
      return false;
    }
  }
}
