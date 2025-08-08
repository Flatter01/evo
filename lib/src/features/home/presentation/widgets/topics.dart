import 'package:evo/src/features/home/data/model/category_model.dart';
import 'package:evo/src/features/home/presentation/widgets/see_all/business_see_all.dart';
import 'package:flutter/material.dart';
import 'package:evo/src/core/colors/app_colors.dart';

// Функция для переноса строк каждые [limit] символов
String breakText(String text, int limit) {
  final buffer = StringBuffer();
  for (int i = 0; i < text.length; i += limit) {
    buffer.writeln(
      text.substring(i, i + limit > text.length ? text.length : i + limit),
    );
  }
  return buffer.toString();
}

class Category extends StatelessWidget {
  final Future<List<CategoryModel>> futureCategories;
  final int? selectedCategoryId;

  const Category({
    super.key,
    required this.futureCategories,
    this.selectedCategoryId,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoryModel>>(
      future: futureCategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Ошибка: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Нет бизнесов'));
        }

        final category = snapshot.data!;
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: category.length,
          itemBuilder: (context, index) {
            final categoryItem = category[index];
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Topics(
                infoTopics: categoryItem.name,
                categoryId: categoryItem.id,
              ),
            );
          },
        );
      },
    );
  }
}

class Topics extends StatelessWidget {
  final String infoTopics;
  final int categoryId;

  const Topics({
    super.key,
    required this.infoTopics,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // колонка сама подстраивает высоту
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BusinessSeeAll(
                categoryId: categoryId,
                categoryName: infoTopics,
              ),
            ),
          ),
          child: Container(
            width: 71,
            height: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: AppColors.white,
            ),
            child: const Padding(
              padding: EdgeInsets.all(5.0),
              child: Icon(
                Icons.business,
                size: 30,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Flexible(
          child: Text(
            breakText(infoTopics, 12),
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.grey,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    );
  }
}
