import 'package:evo/src/features/home/data/model/business_model.dart';
import 'package:evo/src/features/home/presentation/widgets/business/business_card.dart';
import 'package:evo/src/features/home/presentation/widgets/business/business_detail.dart';
import 'package:flutter/material.dart';

class BusinessList extends StatelessWidget {
  final Future<List<Business>> futureBusiness;

  const BusinessList({super.key, required this.futureBusiness});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Business>>(
      future: futureBusiness,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Ошибка: \${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Нет бизнесов'));
        }
        final businesses = snapshot.data!;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
          itemCount: businesses.length,
          itemBuilder: (context, index) {
            final business = businesses[index];
            return BusinessCard(
              index: index,
              description: business.description,
              image: business.image ?? "",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BusinessDetailPage(
                      image: business.image ?? "",
                      name: business.name,
                      description: business.description,
                      phone: business.userPhone,
                      location: business.userFullName,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
