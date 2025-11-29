import 'package:flutter/material.dart';
import 'package:moftahak/core/widgets/custem_elevatedButton_widgets.dart';
import 'package:moftahak/core/widgets/name_drawer_widgets.dart';
import 'package:moftahak/features/home/home_screen.dart';

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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
          icon: Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            NameDrawerWidgets(),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustemElevatedbuttonWidgets(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
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
            SizedBox(height: 80),
            Divider(
              color: Colors.black,
              height: 40,
              thickness: 1,
              indent: 1,
              endIndent: 1,
            ),
            Text(
              'تاكد من الاتي قبل التقاط الصورة',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      // لون الظل ودرجة الشفافية (مهم جداً للواقعية)
                      offset: Offset(0, 4),
                      // إزاحة الظل: 0 أفقياً، 4 رأسياً (للأسفل)
                      blurRadius: 8,
                      // مدى نعومة الظل وانتشاره
                      spreadRadius: 2, // انتشار الظل قليلاً للخارج
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 28,
                    horizontal: 22,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'تأكد من وضوح التصوير   \u2022',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'تأكد من عدم وجود ظلال   \u2022',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'تأكد من عدم وجود ظلال   \u2022',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'تأكد من ثبات الكاميرا عند التصوير  \u2022',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
