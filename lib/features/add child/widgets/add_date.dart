import 'package:flutter/material.dart';
import 'package:moftahak/core/constants/app_colors.dart';
import 'package:moftahak/core/constants/app_text_styles.dart';

class CustomDatePickerField extends StatefulWidget {
  final String label;
  final Function(DateTime)? onDateSelected;
  final String? Function(String?) validator;

  const CustomDatePickerField({
    super.key,
    required this.label,
    this.onDateSelected,
    required this.validator,
  });

  @override
  State<CustomDatePickerField> createState() => _CustomDatePickerFieldState();
}

class _CustomDatePickerFieldState extends State<CustomDatePickerField> {
  final TextEditingController _controller = TextEditingController();

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2015, 1, 1),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      final formatted =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";

      setState(() {
        _controller.text = formatted;
      });

      if (widget.onDateSelected != null) {
        widget.onDateSelected!(picked);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label, style: AppTextStyles.almarai500style16),
          const SizedBox(height: 8),
          SizedBox(
            width: 350,
            child: TextFormField(
              validator: widget.validator,
              controller: _controller,
              readOnly: true,
              onTap: _pickDate,
              decoration: InputDecoration(
                hintText: "اختر التاريخ",
                hintStyle: AppTextStyles.almarai500style16.copyWith(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                filled: true,
                fillColor: AppColors.textField,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: const Icon(Icons.calendar_today),
              ),
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
