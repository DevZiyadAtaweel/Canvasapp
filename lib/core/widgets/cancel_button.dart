import 'package:flutter/material.dart';
import 'package:moftahak/core/constants/app_text_styles.dart';
import 'package:moftahak/core/constants/navigation.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 55,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 6,
              offset: const Offset(0, 4), // نفس الشادو من تحت
            ),
          ],
        ),
        child: OutlinedButton(
          onPressed: () => customNavigatePop(context),
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white, // مهم عشان الشادو يبين
            side: const BorderSide(color: Colors.grey, width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text("إلغاء", style: AppTextStyles.almarai700style20),
        ),
      ),
    );
  }
}
