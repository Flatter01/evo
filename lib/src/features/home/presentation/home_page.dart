import 'package:evo/src/features/home/data/business_service.dart';
import 'package:evo/src/features/home/data/category_service.dart';
import 'package:evo/src/features/home/data/model/business_model.dart';
import 'package:evo/src/features/home/data/model/category_model.dart';
import 'package:evo/src/features/home/presentation/widgets/business/business_list.dart';
import 'package:evo/src/features/home/presentation/widgets/top_business/top_busines_list.dart';
import 'package:flutter/material.dart';
import 'package:evo/src/core/colors/app_colors.dart';
import 'package:evo/src/features/home/presentation/widgets/see_all/full_content.dart';
import 'package:evo/src/features/home/presentation/widgets/topics.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Business>> _futureBusinesses;
  late Future<List<CategoryModel>> _futureCategories;
  List<Business> allBusinesses = [];
  List<CategoryModel> allCategories = [];
  int? selectedCategoryId;
  bool isLoading = true;
  final String targetCategoryName = 'Торговля'; // 👈 укажи нужную категорию

  @override
  void initState() {
    super.initState();
    _futureBusinesses = BusinessService().fetchBusinesses();
    _futureCategories = CategoryService().fetchCategory();
    _loadData();
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
      final filtered =
          businesses.where((b) => b.categoryId == targetCategory.id).toList();

      setState(() {
        allBusinesses = filtered;
        isLoading = false;
      });
    } catch (e) {
      print('Ошибка: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _loadData() async {
    final businesses = await BusinessService().fetchBusinesses();
    final categories = await CategoryService().fetchCategory();

    setState(() {
      allBusinesses = businesses;
      allCategories = categories;
      selectedCategoryId = categories.isNotEmpty ? categories.first.id : null;
    });
  }

  List<Business> getFilteredBusinesses() {
    if (selectedCategoryId == null) return [];
    return allBusinesses
        .where((b) => b.categoryId == selectedCategoryId)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Categories",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppColors.stoneGrey,
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 100,
              child: Category(futureCategories: _futureCategories),
            ),
            const SizedBox(height: 20),
            const FullContent(
              info: "Top Business",
              categoryId: 0,
              categoryName: '',
            ),
            SizedBox(
              height: 200,
              child: TopBusinesList(
                businesses:
                    allBusinesses,
              ),
            ),
            const SizedBox(height: 20),
            const FullContent(
              info: "Business",
              categoryId: 1,
              categoryName: '',
            ),
            BusinessList(
              futureBusiness: _futureBusinesses,
            )
          ],
        ),
      ),
    );
  }
}
