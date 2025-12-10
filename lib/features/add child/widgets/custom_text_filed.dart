import 'package:flutter/material.dart';
import 'package:moftahak/core/constants/app_colors.dart';
import 'package:moftahak/core/constants/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.text,
    required this.controller,
    required this.validator,
    this.maxLines = 1,
    this.hintText,
  });

  final String text;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final int maxLines;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text, style: AppTextStyles.almarai500style16),
          SizedBox(height: 8),
          SizedBox(
            width: 350,
            child: TextFormField(
              validator: validator,
              controller: controller,
              style: AppTextStyles.almarai500style16,

              maxLines: maxLines,

              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppTextStyles.almarai500style16.copyWith(
                  color: Colors.grey,
                  fontSize: 14,
                ),

                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                fillColor: AppColors.textField,
                filled: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
