import 'package:evo/src/core/app_colors.dart';
import 'package:evo/src/features/home/presentation/widgets/see_all/business_see_all.dart';
import 'package:flutter/material.dart';

class FullContent extends StatelessWidget {
  final String info;
  final int categoryId;
  final String categoryName;
  const FullContent({
    super.key,
    required this.info,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          info,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.stoneGrey,
          ),
        ),
        Spacer(),
        TextButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BusinessSeeAll(
                categoryId: categoryId,
                categoryName: categoryName,
              ),
            ),
          ),
          child: Text(
            "See All",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.blueMain,
            ),
          ),
        )
      ],
    );
  }
}
