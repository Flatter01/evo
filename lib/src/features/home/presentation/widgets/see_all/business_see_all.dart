import 'package:evo/src/core/colors/app_colors.dart';
import 'package:evo/src/features/home/data/business_service.dart';
import 'package:evo/src/features/home/data/model/business_model.dart';
import 'package:evo/src/features/home/presentation/widgets/business/business_card.dart';
import 'package:evo/src/features/home/presentation/widgets/business/business_detail.dart';
import 'package:flutter/material.dart';

class BusinessSeeAll extends StatelessWidget {
  final int categoryId;
  final String categoryName;

  const BusinessSeeAll({super.key, required this.categoryId,required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        backgroundColor: AppColors.backgroundColor,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: FutureBuilder<List<Business>>(
        future: BusinessService().fetchBusinesses(), // получаем все бизнесы
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Ошибка: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Нет данных"));
          }

          // фильтруем по categoryId
          final filtered = snapshot.data!
              .where((b) => b.categoryId == categoryId)
              .toList();

          if (filtered.isEmpty) {
            return const Center(child: Text("Нет бизнесов в этой категории"));
          }

          return GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemCount: filtered.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              final business = filtered[index];
              return BusinessCard(
                image: business.image ?? '',
                description: business.description,
                index: index,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BusinessDetailPage(
                      image: business.image ?? '',
                      name: business.name,
                      phone: business.userPhone,
                      location: business.userFullName,
                      description: business.description,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
