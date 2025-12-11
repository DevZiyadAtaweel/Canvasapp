import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moftahak/features/ai_logic/analysis_arg.dart';
import 'package:moftahak/features/home/model/child_model.dart';

import '../../core/constants/app_text_styles.dart';
import '../../core/constants/navigation.dart';
import '../../core/widgets/custem_elevatedButton_widgets.dart';
import 'analysi_imageby_ai_screen.dart';

// شاشة جديدة لعرض الصورة المختارة
class DisplayImageScreen extends StatelessWidget {
  final Uint8List imageBytes;

  // 🆕 مسار الملف عشان نقدر نعمل File لاحقاً
  final String imageFilePath;

  // 🆕 معرف الطفل صاحب الرسمة
  final String childId;
  final ChildModel child;

  const DisplayImageScreen({
    super.key,
    required this.imageBytes,
    required this.imageFilePath,
    required this.childId,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('معاينة الصورة'), centerTitle: true),
      body: Center(
        child: Column(
          children: [
            // 1. عرض الصورة
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.memory(imageBytes),
              ),
            ),

            // 2. أزرار الإجراءات
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  CustemElevatedbuttonWidgets(
                    onPressed: () {
                      // بدل ما نفتح DrawingScreen من جديد، نرجع خطوة للخلف
                      Navigator.pop(context);
                    },
                    textButton: 'الغاء',
                    // width: double.infinity,
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                  SizedBox(width: 10),

                  CustemElevatedbuttonWidgets(
                    textButton: 'تأكيد والمتابعة',
                    width: MediaQuery.of(context).size.width * 0.4,
                    onPressed: () {
                      // نجهز الـ args مع بيانات الطفل
                      final args = AnalysisArgs(
                        imageBytes: imageBytes,
                        imageFilePath: imageFilePath,
                        childId: childId,
                        child: child, // 🆕 تمرير بيانات الطفل
                      );

                      // نستخدم GoRouter بدل Navigator
                      context.push('/analysisDrawing', extra: args);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 120),
          ],
        ),
      ),
    );
  }
}
