import 'package:flutter/material.dart';
import 'package:moftahak/core/constants/app_colors.dart';
import 'package:moftahak/core/constants/app_text_styles.dart';
import 'package:moftahak/core/constants/app_assets.dart';
import 'package:moftahak/core/constants/navigation.dart';
import 'package:moftahak/features/auth/widgets/auth_text_filed.dart';
import 'package:moftahak/features/auth/widgets/auth_toggle_tabs.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.backGroundColor,
        body: Stack(
          children: [
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

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      Text(
                        'تسجيل الدخول',
                        style: AppTextStyles.lato600style20.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'مرحبا بعودتك! يرجى تسجيل الدخول للمتابعة',
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
                          AuthToggleTabs(
                            isLoginSelected: true,
                            onLoginTap: () {},
                            onSignupTap: () {
                              customNavigate(context, "/signUp");
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(height: 24),

                                // Email
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

                                // Password
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

                                const SizedBox(height: 8),

                                Row(
                                  children: [
                                    Checkbox(
                                      value: true,
                                      onChanged: (_) {
                                        // TODO: Handle remember me checkbox state change
                                      },
                                      activeColor: AppColors.green,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    Text(
                                      'تذكّرني',
                                      style: AppTextStyles.lato600style20
                                          .copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                    ),
                                    const Spacer(),
                                    TextButton(
                                      onPressed: () {
                                        //TODO: منطق استعادة كلمة المرور
                                      },
                                      child: Text(
                                        'نسيت كلمة المرور؟',
                                        style: AppTextStyles.lato600style20
                                            .copyWith(
                                              fontSize: 12,
                                              color: Colors.redAccent,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 16),

                                // Login button
                                SizedBox(
                                  height: 48,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      //TODO: منطق تسجيل الدخول
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: Text(
                                      'تسجيل الدخول',
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

                                // Don't have account?
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "ليس لديك حساب؟ ",
                                      style: AppTextStyles.lato600style20
                                          .copyWith(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                          ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        customNavigate(context, "/signUp");
                                      },
                                      child: Text(
                                        'إنشاء حساب',
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

                                const SizedBox(height: 16),

                                // Divider
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Divider(
                                        thickness: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      child: Text(
                                        'أو',
                                        style: AppTextStyles.lato600style20
                                            .copyWith(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      child: Divider(
                                        thickness: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 16),

                                // Google Login
                                GestureDetector(
                                  onTap: () {
                                    //  TODO: Handle Google login logic here
                                  },
                                  child: Container(
                                    height: 48,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey[400]!,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          AppAssets.googleIcon,
                                          width: 24,
                                          height: 24,
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          'تسجيل الدخول باستخدام جوجل',
                                          style: AppTextStyles.lato600style20
                                              .copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
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
