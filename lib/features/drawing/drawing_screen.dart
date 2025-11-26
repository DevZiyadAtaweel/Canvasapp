import 'package:flutter/material.dart';
import 'package:moftahak/core/widgets/custem_elevatedButton_widgets.dart';
import 'package:moftahak/core/widgets/name_drawer_widgets.dart';

import '../../core/constants/app_colors.dart';

class DrawingScreen extends StatelessWidget {
  const DrawingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,

      appBar: AppBar(
        backgroundColor: AppColors.backGroundColor,

        title: Text(
          'اختر فنان اليوم',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          NameDrawerWidgets(TextName: 'عمر'),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustemElevatedbuttonWidgets(
                onPressed: () {},
                textButton: 'ارفاق صورة',
                width: 200,
                icon: Icon(Icons.upload, size: 22),
              ),
              CustemElevatedbuttonWidgets(
                onPressed: () {},
                textButton: 'التقاط صورة',
                width: 200,
                icon: Icon(Icons.camera_alt_outlined, size: 22),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
