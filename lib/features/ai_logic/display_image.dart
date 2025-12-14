import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:moftahak/core/widgets/cancel_button.dart';
import 'package:moftahak/features/ai_logic/analysis_arg.dart';
import 'package:moftahak/features/home/model/child_model.dart';
import '../../core/widgets/custem_elevatedButton_widgets.dart';

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
      appBar: AppBar(
        title: const Text('معاينة الصورة'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.memory(imageBytes),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  CancelButton(),

                  CustemElevatedbuttonWidgets(
                    textButton: 'تأكيد والمتابعة',
                    width: 150,
                    onPressed: () {
                      // نجهز الـ args مع بيانات الطفل
                      final args = AnalysisArgs(
                        imageBytes: imageBytes,
                        imageFilePath: imageFilePath,
                        childId: childId,
                        child: child, // 🆕 تمرير بيانات الطفل
                      );

                      // نستخدم GoRouter بدل Navigator
                      context.pushReplacement('/analysisDrawing', extra: args);
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
