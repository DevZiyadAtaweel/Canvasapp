import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
class NameDrawerWidgets extends StatelessWidget {
  const NameDrawerWidgets({super.key, required this.TextName});
final String TextName;
  @override
  Widget build(BuildContext context) {
    return   Row(

mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Text(
          TextName,
          style: TextStyle(
            color: Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontFamily: 'Arial',
          ),
        ),
        const SizedBox(width: 8),
        // السهم
        Icon(
          Icons.arrow_drop_down,
          color: AppColors.yellow, // استخدم ثابت الألوان
          size: 50,
        ),
      ],
    );
  }
}
