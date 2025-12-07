import 'package:flutter/material.dart';
import 'package:moftahak/core/constants/app_colors.dart';
import 'package:moftahak/core/constants/app_text_styles.dart';

class CustomDropdownField<T> extends StatelessWidget {
  const CustomDropdownField({
    super.key,
    required this.label,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.validator,
  });

  final String label;
  final List<T> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String? Function(T?) validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.almarai500style16),
          const SizedBox(height: 8),
          SizedBox(
            width: 350,
            child: DropdownButtonFormField<T>(
              validator: validator,
              // 👈 نحمي أنفسنا من القيم الغلط
              // initialValue: (value != null && items.contains(value))
              //     ? value
              //     : null,
              value: value,

              hint: Text(
                "انقر للاختيار",
                style: AppTextStyles.almarai500style16.copyWith(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),

              items: items
                  .map(
                    (e) => DropdownMenuItem<T>(
                      value: e,
                      child: Text(
                        e.toString(),
                        style: AppTextStyles.almarai500style16,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: onChanged,
              style: AppTextStyles.almarai500style16,

              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),

                filled: true,
                fillColor: AppColors.textField,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
              icon: Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Icon(Icons.arrow_drop_down),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
