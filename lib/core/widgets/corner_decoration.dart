import 'package:flutter/material.dart';
import 'package:moftahak/core/constants/app_colors.dart';

class CornerDecoration extends StatelessWidget {
  const CornerDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -50,
      right: -50,
      child: SizedBox(
        width: 120,
        height: 120,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.yellow,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
          ),
        ),
      ),
    );
  }
}
