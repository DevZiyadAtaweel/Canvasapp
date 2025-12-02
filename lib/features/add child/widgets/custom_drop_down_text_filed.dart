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
  });

  final String label;
  final List<T> items;
  final T? value;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.sen700style20),
          const SizedBox(height: 8),
          SizedBox(
            width: 350,
            child: DropdownButtonFormField<T>(
              // 👈 نحمي أنفسنا من القيم الغلط
              initialValue: (value != null && items.contains(value)) ? value : null,

              hint: const Text(
                "انقر للاختيار",
                style: TextStyle(color: Colors.grey, fontFamily: "Sen"),
              ),

              items: items
                  .map(
                    (e) => DropdownMenuItem<T>(
                      value: e,
                      child: Text(
                        e.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: "Sen",
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: onChanged,
              style: const TextStyle(color: Colors.black, fontFamily: "Sen"),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.textField,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              icon: const Icon(Icons.arrow_drop_down),
            ),
          ),
        ],
      ),
    );
  }
}
