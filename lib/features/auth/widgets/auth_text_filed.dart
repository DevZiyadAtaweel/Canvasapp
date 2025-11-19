import 'package:flutter/material.dart';
import 'package:moftahak/core/constants/app_colors.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    required this.hint,
    this.keyboardType,
    this.isPassword = false,
    required this.controller,
    required this.showError,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;
  final bool isPassword;
  final bool showError; // 👈 إضافة مهمة

  @override
  State<AuthTextField> createState() => AuthTextFieldState();
}

class AuthTextFieldState extends State<AuthTextField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword ? _isObscured : false,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        errorText: widget.showError ? '' : null, // 👈 يفعّل إطار أحمر بدون نص

        filled: true,
        fillColor: AppColors.lightGreen,
        hintText: widget.hint,
        hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),

        // ▼ هنا أضفنا الأيقونة
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
                icon: Icon(
                  _isObscured
                      ? Icons
                            .visibility_off // عين عليها شحطة
                      : Icons.visibility, // عين مفتوحة
                  color: Colors.grey[700],
                  size: 20,
                ),
              )
            : null,
      ),
    );
  }
}
