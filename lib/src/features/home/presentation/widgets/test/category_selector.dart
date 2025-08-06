import 'package:flutter/material.dart';
import 'package:evo/src/features/home/data/model/category_model.dart';

class CategorySelector extends StatelessWidget {
  final List<CategoryModel> categories;
  final int? selectedCategoryId;
  final Function(int) onCategorySelected;

  const CategorySelector({
    super.key,
    required this.categories,
    required this.selectedCategoryId,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategoryId == category.id;

          return GestureDetector(
            onTap: () => onCategorySelected(category.id),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  category.name,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
