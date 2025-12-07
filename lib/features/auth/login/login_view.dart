import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moftahak/core/constants/app_colors.dart';
import 'package:moftahak/core/constants/app_text_styles.dart';
import 'package:moftahak/core/constants/app_assets.dart';
import 'package:moftahak/core/constants/navigation.dart';
import 'package:moftahak/features/auth/cubit/auth_cubit.dart';
import 'package:moftahak/features/auth/widgets/auth_text_filed.dart';
import 'package:moftahak/features/auth/widgets/auth_toggle_tabs.dart';
import 'package:moftahak/features/auth/widgets/auth_validator.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final ValueNotifier<bool> emailError = ValueNotifier(false);
  final ValueNotifier<bool> passError = ValueNotifier(false);
  final ValueNotifier<bool> rememberMe = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (context) => AuthCubit(),
        child: Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("تم تسجيل الدخول بنجاح")),
                );
                customNavigatePushReplacement(context, "/home");
              } else if (state is AuthFailure) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              } else if (state is AuthPasswordResetEmailSent) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني",
                    ),
                  ),
                );
              } else if (state is GmailAuthLoading) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("جاري تسجيل الدخول باستخدام جوجل..."),
                  ),
                );
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  const SizedBox(height: 120),

                  // ---------- العنوان ----------
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        Text(
                          'تسجيل الدخول',
                          style: AppTextStyles.lato600style20.copyWith(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'مرحبا بعودتك! يرجى تسجيل الدخول للمتابعة',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.lato600style20.copyWith(
                            fontSize: 22,
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
                            AuthToggleTabs(
                              isLoginSelected: true,
                              onLoginTap: () {},
                              onSignupTap: () {
                                customNavigatePush(context, "/signUp");
                              },
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const SizedBox(height: 24),

                                  // -------------------
                                  // البريد الإلكتروني
                                  // -------------------
                                  _buildLabel("البريد الإلكتروني", emailError),
                                  const SizedBox(height: 8),

                                  ValueListenableBuilder<bool>(
                                    valueListenable: emailError,
                                    builder: (context, hasError, _) {
                                      return AuthTextField(
                                        controller: emailController,
                                        hint: 'example@gmail.com',
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        showError: hasError,
                                      );
                                    },
                                  ),

                                  const SizedBox(height: 16),

                                  // -------------------
                                  // كلمة المرور
                                  // -------------------
                                  _buildLabel("كلمة المرور", passError),
                                  const SizedBox(height: 8),

                                  ValueListenableBuilder<bool>(
                                    valueListenable: passError,
                                    builder: (context, hasError, _) {
                                      return AuthTextField(
                                        controller: passController,
                                        hint: '********',
                                        isPassword: true,
                                        showError: hasError,
                                      );
                                    },
                                  ),

                                  const SizedBox(height: 8),

                                  // تذكّرني + نسيت كلمة المرور
                                  ValueListenableBuilder<bool>(
                                    valueListenable: rememberMe,
                                    builder: (context, isChecked, _) {
                                      return Row(
                                        children: [
                                          Checkbox(
                                            value: isChecked,
                                            onChanged: (val) {
                                              rememberMe.value = val ?? false;
                                            },
                                            activeColor: AppColors.green,
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
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
                                            onPressed: state is AuthLoading
                                                ? null
                                                : () {
                                                    final email =
                                                        emailController.text
                                                            .trim();

                                                    final emailErrorMsg =
                                                        AuthValidator.validateEmail(
                                                          email,
                                                        );

                                                    emailError.value =
                                                        emailErrorMsg != null;

                                                    if (emailErrorMsg != null) {
                                                      ScaffoldMessenger.of(
                                                        context,
                                                      ).showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            emailErrorMsg,
                                                          ),
                                                        ),
                                                      );
                                                      return;
                                                    }

                                                    context
                                                        .read<AuthCubit>()
                                                        .resetPassword(
                                                          email: email,
                                                        );
                                                  },
                                            child: Text(
                                              'نسيت كلمة المرور؟',
                                              style: AppTextStyles
                                                  .lato600style20
                                                  .copyWith(
                                                    fontSize: 12,
                                                    color: Colors.redAccent,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),

                                  const SizedBox(height: 16),

                                  // زر تسجيل الدخول
                                  _buildLoginButton(state, context),

                                  const SizedBox(height: 12),

                                  // لا تملك حساب؟
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
                                          customNavigatePush(
                                            context,
                                            "/signUp",
                                          );
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

                                  // زر تسجيل الدخول باستخدام جوجل
                                  GestureDetector(
                                    onTap: state is GmailAuthLoading
                                        ? null
                                        : () {
                                            context
                                                .read<AuthCubit>()
                                                .signInWithGoogle();
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
                                          if (state is GmailAuthLoading)
                                            const SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            )
                                          else ...[
                                            Image.asset(
                                              AppAssets.googleIcon,
                                              width: 24,
                                              height: 24,
                                            ),
                                            const SizedBox(width: 12),
                                            Text(
                                              'تسجيل الدخول باستخدام جوجل',
                                              style: AppTextStyles
                                                  .lato600style20
                                                  .copyWith(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ],
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
              );
            },
          ),
        ),
      ),
    );
  }

  // ================== Widgets مساعدة ==================

  Widget _buildLabel(String text, ValueNotifier<bool> errorNotifier) {
    return Row(
      children: [
        Text(
          text,
          style: AppTextStyles.lato600style20.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 4),
        ValueListenableBuilder<bool>(
          valueListenable: errorNotifier,
          builder: (context, hasError, _) {
            return hasError
                ? const Text("*", style: TextStyle(color: Colors.red))
                : const SizedBox();
          },
        ),
      ],
    );
  }

  Widget _buildLoginButton(AuthState state, BuildContext context) {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        onPressed: state is AuthLoading
            ? null
            : () {
                final email = emailController.text.trim();
                final password = passController.text.trim();

                final emailErrorMsg = AuthValidator.validateEmail(email);
                final passErrorMsg = AuthValidator.validatePassword(password);

                emailError.value = emailErrorMsg != null;
                passError.value = passErrorMsg != null;

                if (emailErrorMsg != null || passErrorMsg != null) {
                  final firstError = emailErrorMsg ?? passErrorMsg;
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(firstError!)));
                  return;
                }

                context.read<AuthCubit>().login(
                  email: email,
                  password: password,
                );
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: state is AuthLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(
                'تسجيل الدخول',
                style: AppTextStyles.lato600style20.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ),
    );
  }
}
