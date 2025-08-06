import 'package:evo/src/core/app_colors.dart';
import 'package:evo/src/features/home/presentation/widgets/business/business_card.dart';
import 'package:evo/src/features/home/presentation/widgets/business/business_detail.dart';
import 'package:flutter/material.dart';

class LuckItemsPage extends StatelessWidget {
  const LuckItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Business"),
        backgroundColor: AppColors.backgroundColor,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
          padding: EdgeInsets.all(8),
          itemCount: 20,
          itemBuilder: (context, index) {
            return BusinessCard(
              image: "",
              description: "",
              index: index,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const BusinessDetailPage(image: '', name: '', phone: '', location: '', description: '',),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
