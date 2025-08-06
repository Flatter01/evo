import 'package:flutter/material.dart';
import 'package:evo/src/features/home/data/business_service.dart';
import 'package:evo/src/features/home/data/category_service.dart';
import 'package:evo/src/features/home/data/model/business_model.dart';
import 'package:evo/src/features/home/data/model/category_model.dart';
import 'package:evo/src/features/home/presentation/widgets/test/business_list.dart';

class BusinessPage extends StatefulWidget {
  const BusinessPage({super.key});

  @override
  State<BusinessPage> createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage> {
  List<Business> filteredBusinesses = [];
  bool isLoading = true;

  final String targetCategoryName = 'Общественное питание'; // 👈 укажи нужную категорию

  @override
  void initState() {
    super.initState();
    _loadBusinessesForCategory();
  }

  Future<void> _loadBusinessesForCategory() async {
    try {
      final categories = await CategoryService().fetchCategory();
      final targetCategory = categories.firstWhere(
        (c) => c.name == targetCategoryName,
        orElse: () => throw Exception('Категория не найдена'),
      );

      final businesses = await BusinessService().fetchBusinesses();
      final filtered = businesses.where((b) => b.categoryId == targetCategory.id).toList();

      setState(() {
        filteredBusinesses = filtered;
        isLoading = false;
      });
    } catch (e) {
      print('Ошибка: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Категория: $targetCategoryName')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : BusinessList1(businesses: filteredBusinesses),
    );
  }
}
