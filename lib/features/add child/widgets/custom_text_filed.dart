import 'package:flutter/material.dart';
import 'package:moftahak/core/constants/app_colors.dart';
import 'package:moftahak/core/constants/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.text,
    required this.controller,
    required this.validator,
  });
  final String text;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text, style: AppTextStyles.sen700style20),
          SizedBox(height: 8),
          SizedBox(
            width: 350,
            child: TextFormField(
              validator: validator,

              controller: controller,
              style: TextStyle(color: Colors.black, fontFamily: "Sen"),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
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
