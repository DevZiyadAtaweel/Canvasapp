import 'package:flutter/material.dart';
import 'package:moftahak/core/constants/app_colors.dart';

class AuthToggleTabs extends StatelessWidget {
  const AuthToggleTabs({
    super.key,
    required this.isLoginSelected,
    required this.onLoginTap,
    required this.onSignupTap,
  });

  final bool isLoginSelected;
  final VoidCallback onLoginTap;
  final VoidCallback onSignupTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: const BoxDecoration(
        color: Color(0xFFE0E0E0),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onLoginTap,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isLoginSelected ? AppColors.textField : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(32),
                  ),
                  border: isLoginSelected
                      ? null
                      : Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  "تسجيل الدخول",
                  style: TextStyle(
                    fontFamily: "Almarai",
                    fontSize: 14,
                    fontWeight: isLoginSelected
                        ? FontWeight.w700
                        : FontWeight.w500,
                    color: isLoginSelected ? Colors.black : Colors.grey[700],
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: GestureDetector(
              onTap: onSignupTap,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: !isLoginSelected
                      ? null
                      : Border.all(color: Colors.grey.shade300),

                  color: !isLoginSelected ? AppColors.textField : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32),
                  ),
                ),
                child: Text(
                  "إنشاء حساب",
                  style: TextStyle(
                    fontFamily: "Almarai",

                    fontSize: 14,
                    fontWeight: !isLoginSelected
                        ? FontWeight.w700
                        : FontWeight.w500,
                    color: !isLoginSelected ? Colors.black : Colors.grey[700],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
