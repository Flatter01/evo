import 'package:flutter/material.dart';
import 'package:evo/src/features/home/data/model/business_model.dart';
import 'package:evo/src/features/home/presentation/widgets/top_business/top_business.dart';
import 'package:evo/src/features/home/presentation/widgets/top_business/top_business_detail.dart';

class TopBusinesList extends StatelessWidget {
  final List<Business> businesses;

  const TopBusinesList({
    super.key,
    required this.businesses,
  });

  @override
  Widget build(BuildContext context) {
    if (businesses.isEmpty) {
      return const Center(child: Text("Нет бизнесов в этой категории"));
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: businesses.length,
      itemBuilder: (context, index) {
        final business = businesses[index];

        return TopBusiness(
          image: business.image ?? '',
          description: business.description,
          index: index,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => TopBusinessDetail(
                  // business: business
                  ),
              ),
            );
          },
        );
      },
    );
  }
}
