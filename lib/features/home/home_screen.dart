import 'package:flutter/material.dart';
import 'package:moftahak/core/constants/navigation.dart';
import 'package:moftahak/core/widgets/custem_drawing_widgets.dart';
import 'package:moftahak/core/widgets/custem_elevatedButton_widgets.dart';
import 'package:moftahak/core/widgets/custem_image_icon_widgets.dart';
import 'package:moftahak/core/widgets/name_drawer_widgets.dart';

import '../../core/constants/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 20),

                  // مسافة علوية إضافية
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      NameDrawerWidgets(TextName: 'الأبناء'),
                      CustemImageIconWidgets(
                        width: 60,
                        height: 60,
                        imagepath: 'assets/images/on_boarding_new.png',
                      ),
                    ],
                  ),
                  // *******************
                  // رسالة الترحيب
                  // *******************
                  const SizedBox(height: 10),
                  const Text(
                    '!مرحبا محمد علي مساء الخير',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  // *******************
                  // زر رسمة جديدة
                  // *******************
                  const SizedBox(height: 25),
                  CustemElevatedbuttonWidgets(
                    onPressed: () {
                      customNavigatePush(context, "/settings");
                    },
                    width: double.infinity,
                    textButton: 'رسمة جديدة',
                  ),
                  SizedBox(height: 15),
                  // *******************
                  // نظرة على رسومات طفلك
                  // *******************
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'انظر المزيد',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.arrow_back_ios),
                            ),
                          ],
                        ),

                        const Text(
                          'نظرة على رسومات طفلك',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),

                  // *******************
                  // عرض الرسومات الرأسي
                  // *******************
                  CustemDrawingWidgets(
                    width: double.infinity,
                    Textimage: 'assets/images/on_boarding2.png',
                  ),

                  const SizedBox(height: 40),

                  // *******************
                  // تقييم الطبيب النفسي
                  // *******************
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          'أبنائي',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 40),

                        CustemImageIconWidgets(
                          width: 135,
                          height: 135,
                          imagepath: 'assets/images/on_boarding_new.png',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
