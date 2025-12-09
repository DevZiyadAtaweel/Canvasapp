import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moftahak/features/ai_logic/analysis_arg.dart';

import 'analysi_imageby_ai_screen.dart';

// شاشة جديدة لعرض الصورة المختارة
class DisplayImageScreen extends StatelessWidget {
  final Uint8List imageBytes;

  // 🆕 مسار الملف عشان نقدر نعمل File لاحقاً
  final String imageFilePath;

  // 🆕 معرف الطفل صاحب الرسمة
  final String childId;

  const DisplayImageScreen({
    super.key,
    required this.imageBytes,
    required this.imageFilePath,
    required this.childId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('معاينة الصورة'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // زر إلغاء (رجوع)
                  ElevatedButton.icon(
                    onPressed: () {
                      // بدل ما نفتح DrawingScreen من جديد، نرجع خطوة للخلف
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.cancel),
                    label: const Text('إلغاء'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                  ),

                  ElevatedButton.icon(
                    onPressed: () {
                      // نجهز الـ args
                      final args = AnalysisArgs(
                        imageBytes: imageBytes,
                        imageFilePath: imageFilePath,
                        childId: childId,
                      );

                      // نستخدم GoRouter بدل Navigator
                      context.push('/analysisDrawing', extra: args);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'تم تأكيد الصورة، يتم المتابعة للتحليل...',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.check_circle),
                    label: const Text('تأكيد والمتابعة'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
