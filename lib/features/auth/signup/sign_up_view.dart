import 'package:flutter/material.dart';
import 'package:moftahak/core/constants/app_colors.dart';
import 'package:moftahak/core/constants/app_text_styles.dart';
import 'package:moftahak/core/constants/navigation.dart';
import 'package:moftahak/features/auth/widgets/auth_text_filed.dart';
import 'package:moftahak/features/auth/widgets/auth_toggle_tabs.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.backGroundColor,
        body: Stack(
          children: [
            // ربع الدائرة الصفراء
            Positioned(
              top: -61,
              left: -44,
              child: Container(
                width: 122,
                height: 164,
                decoration: BoxDecoration(
                  color: AppColors.yellow,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(80),
                  ),
                ),
              ),
            ),

            Column(
              children: [
                const SizedBox(height: 120),

                // ---------- العنوان ----------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      Text(
                        'إنشاء حساب',
                        style: AppTextStyles.lato600style20.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'سجل بياناتك للبدء باستخدام التطبيق',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.lato600style20.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ---------- الكارد الأبيض ----------
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Tabs
                          AuthToggleTabs(
                            isLoginSelected: false,
                            onLoginTap: () {
                              customNavigate(context, "/login");
                            },
                            onSignupTap: () {},
                          ),

                          // باقي المحتوى
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(height: 24),

                                // الاسم
                                Text(
                                  'الاسم الكامل',
                                  style: AppTextStyles.lato600style20.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const AuthTextField(
                                  hint: 'اكتب اسمك هنا',
                                  keyboardType: TextInputType.name,
                                ),
                                const SizedBox(height: 16),

                                // البريد الإلكتروني
                                Text(
                                  'البريد الإلكتروني',
                                  style: AppTextStyles.lato600style20.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const AuthTextField(
                                  hint: 'example@gmail.com',
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                const SizedBox(height: 16),

                                // كلمة المرور
                                Text(
                                  'كلمة المرور',
                                  style: AppTextStyles.lato600style20.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const AuthTextField(
                                  hint: '********',
                                  isPassword: true,
                                ),
                                const SizedBox(height: 16),

                                // إعادة كتابة كلمة المرور
                                Text(
                                  'إعادة كتابة كلمة المرور',
                                  style: AppTextStyles.lato600style20.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const AuthTextField(
                                  hint: '********',
                                  isPassword: true,
                                ),

                                const SizedBox(height: 24),

                                // زر إنشاء حساب
                                SizedBox(
                                  height: 48,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // TODO: منطق إنشاء الحساب
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: Text(
                                      'إنشاء حساب',
                                      style: AppTextStyles.lato600style20
                                          .copyWith(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 12),

                                // لديك حساب؟
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "لديك حساب بالفعل؟ ",
                                      style: AppTextStyles.lato600style20
                                          .copyWith(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                          ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        customNavigate(context, "/login");
                                      },
                                      child: Text(
                                        'تسجيل الدخول',
                                        style: AppTextStyles.lato600style20
                                            .copyWith(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.green,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 24),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
