


import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// ... استيراد الملفات ...

class ScreenTablet extends StatelessWidget {
  final Function(ImageSource)? onImageButtonPressed;
  final Future<Uint8List?> Function()? pickImage;

  const ScreenTablet({
    super.key,
     this.onImageButtonPressed,
     this.pickImage,
  });

  @override
  Widget build(BuildContext context) {
    // 💡 التغيير: نضع الـ Content في Center لتحديد أقصى عرض له على الشاشة الكبيرة
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800), // أقصى عرض 800 بكسل
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32), // زيادة Padding
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ... بقية العناصر ...
                // --- صف الأزرار (يبقى بنفس الـ width: 200، لكنه الآن في حاوية محددة) ---
                // ...
              ],
            ),
          ),
        ),
      ),
    );
  }




}