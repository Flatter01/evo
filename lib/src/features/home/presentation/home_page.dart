import 'package:evo/src/features/home/data/business_service.dart';
import 'package:evo/src/features/home/data/category_service.dart';
import 'package:evo/src/features/home/data/model/business_model.dart';
import 'package:evo/src/features/home/data/model/category_model.dart';
import 'package:evo/src/features/home/presentation/widgets/add_business_form.dart';
import 'package:evo/src/features/home/presentation/widgets/business/business_list.dart';
import 'package:evo/src/features/home/presentation/widgets/top_business/top_busines_list.dart';
import 'package:flutter/material.dart';
import 'package:evo/src/core/app_colors.dart';
import 'package:evo/src/features/home/presentation/widgets/full_content.dart';
import 'package:evo/src/features/home/presentation/widgets/luck_items/luck_items_page.dart';
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
  final String targetCategoryName = 'Общественное питание'; // 👈 укажи нужную категорию

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
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Image.asset("assets/logo/logo2.png", height: 70),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const LuckItemsPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Categories",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
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
                    allBusinesses, // уже отфильтрованные в _loadBusinessesForCategory()
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (context) => Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 16,
              ),
              child: AddBusinessForm(
                onSave: () {
                  print('Бизнес сохранён');
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
