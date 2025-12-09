// ملف جديد: drawing_screen_mobile.dart

import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/widgets/custem_elevatedButton_widgets.dart';
// استيراد بقية الملفات التي يحتاجها التخطيط ...
// ...

class ScreenMobile extends StatelessWidget {
  // يجب عليك تمرير الدوال التي تنفذ التقاط الصور عبر Constructor
  final Function(ImageSource)? onImageButtonPressed;
  final Future<Uint8List?> Function()? pickImage;

  const ScreenMobile({super.key, this.onImageButtonPressed, this.pickImage});

  @override
  Widget build(BuildContext context) {
    // محتوى الـ build الحالي كله ينتقل إلى هنا.
    // ...
    // يمكنك الإبقاء على القيم الثابتة مثل width: 200 هنا
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          // ...
          children: [
            // ...
            // --- صف الأزرار (نستخدم الـ Functions المُمررة) ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // زر إرفاق صورة (المعرض)
                CustemElevatedbuttonWidgets(
                  onPressed: () async {
                    await pickImage!();
                    // ... منطق التوجيه ...
                  },
                  textButton: 'ارفاق صورة',
                  width: 200, // **القيمة الثابتة التي طلبت عدم تغييرها**
                  // ...
                ),
                // زر التقاط صورة (الكاميرا)
                CustemElevatedbuttonWidgets(
                  onPressed: () {
                    onImageButtonPressed!(ImageSource.camera);
                  },
                  textButton: 'التقاط صورة',
                  width: 200, // **القيمة الثابتة التي طلبت عدم تغييرها**
                  // ...
                ),
              ],
            ),
            // ... بقية عناصر الصفحة ...
          ],
        ),
      ),
    );
  }
}
