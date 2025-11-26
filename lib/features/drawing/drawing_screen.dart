import 'package:flutter/material.dart';
import 'package:moftahak/view/widgets/custem_elevatedButton_widgets.dart';
import 'package:moftahak/view/widgets/name_drawer_widgets.dart';

import '../../core/constants/app_colors.dart';

class DrawingScreen extends StatelessWidget {
  const DrawingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,

      appBar: AppBar(
        backgroundColor: AppColors.backGroundColor,

        title: Text('اختر فنان اليوم'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: Column(
        children: [
          NameDrawerWidgets(TextName: 'عمر'),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustemElevatedbuttonWidgets(
                textButton: 'ارفاق صورة',
                width: 200,
                icon: Icon(Icons.upload, size: 22),
              ),
              CustemElevatedbuttonWidgets(
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
