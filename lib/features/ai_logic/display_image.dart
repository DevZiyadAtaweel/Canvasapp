import 'dart:typed_data';
import 'package:flutter/material.dart';

import 'analysi_imageby_ai_screen.dart';

// شاشة جديدة لعرض الصورة المختارة
class DisplayImageScreen extends StatelessWidget {
  // يجب أن تستقبل ملف الصورة (XFile) كمتطلب أساسي

  final Uint8List imageBytes;

   const DisplayImageScreen({super.key, required this.imageBytes});


  @override
  Widget build(BuildContext context) {
    // نستخدم File(path) لتحويل XFile إلى ويدجيت File


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
                child: Image.memory(imageBytes
                ),
              ),
            ),

            // 2. أزرار الإجراءات
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // زر إلغاء (العودة للصفحة السابقة)
                  ElevatedButton.icon(
                    onPressed: () {
                      // العودة إلى شاشة الرسم (DrawingScreen)

                    },
                    icon: const Icon(Icons.cancel),
                    label: const Text('إلغاء'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                  ),

                  // زر تأكيد (للانتقال إلى الخطوة التالية أو الرفع)
                  ElevatedButton.icon(
                    onPressed: () {

                      Navigator.push(context, MaterialPageRoute(builder: (context)
                      {
                        return AnalysiImagebyAiScreen(imageFile: imageBytes);
                      }));

                      // هنا تضع منطق إرسال/رفع الصورة (على سبيل المثال، إلى Firebase)
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('تم تأكيد الصورة! (يتم الآن إرسالها...)')),
                      );
                      // يمكنك التوجيه إلى شاشة أخرى بعد التأكيد
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => NextStepScreen()));
                    },
                    icon: const Icon(Icons.check_circle),
                    label: const Text('تأكيد والمتابعة'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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