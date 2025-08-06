import 'package:flutter/material.dart';

class BusinessCard extends StatelessWidget {
  final int index;
  final String image;
  final VoidCallback onTap;
  final String description;

  const BusinessCard({super.key, required this.index,required this.onTap,required this.image,required this.description});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        width: 150,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Image.network(image,fit: BoxFit.cover),
            ),
            // Название
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                description,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
