import 'package:flutter/material.dart';
import 'package:evo/src/features/home/data/model/business_model.dart';

class BusinessList1 extends StatelessWidget {
  final List<Business> businesses;

  const BusinessList1({super.key, required this.businesses});

  @override
  Widget build(BuildContext context) {
    if (businesses.isEmpty) {
      return const Center(child: Text("Нет бизнесов в этой категории"));
    }

    return ListView.builder(
      itemCount: businesses.length,
      itemBuilder: (context, index) {
        final business = businesses[index];
        return ListTile(
          leading: business.image != null && business.image!.isNotEmpty
              ? Image.network(
                  business.image!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                )
              : const Icon(Icons.image),
          title: Text(business.name),
          subtitle: Text(business.userPhone),
        );
      },
    );
  }
}
