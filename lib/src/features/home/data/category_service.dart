import 'package:dio/dio.dart';
import 'package:evo/src/features/home/data/model/category_model.dart';

class CategoryService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://127.0.0.1:8000/api/'));

  Future<List<CategoryModel>> fetchCategory() async {
    try {
      final response = await _dio.get('categories/');
      final List data = response.data;
      return data.map((json) => CategoryModel.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching businesses: $e');
      return [];
    }
  }
}
