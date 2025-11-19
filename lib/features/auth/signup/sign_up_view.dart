import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moftahak/core/constants/app_colors.dart';
import 'package:moftahak/core/constants/app_text_styles.dart';
import 'package:moftahak/core/constants/navigation.dart';
import 'package:moftahak/features/auth/cubit/auth_cubit.dart';
import 'package:moftahak/features/auth/widgets/auth_text_filed.dart';
import 'package:moftahak/features/auth/widgets/auth_toggle_tabs.dart';
import 'package:moftahak/features/auth/widgets/auth_validator.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final nameController = TextEditingController();
  final confirmPassController = TextEditingController();

  final ValueNotifier<bool> nameError = ValueNotifier(false);
  final ValueNotifier<bool> emailError = ValueNotifier(false);
  final ValueNotifier<bool> passError = ValueNotifier(false);
  final ValueNotifier<bool> confirmPassError = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (context) => AuthCubit(),
        child: Scaffold(
          backgroundColor: AppColors.backGroundColor,
          body: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("تم إنشاء الحساب بنجاح")),
                );
                customNavigate(context, "/home");
              } else if (state is AuthFailure) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },

            builder: (context, state) {
              return Stack(
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
                                AuthToggleTabs(
                                  isLoginSelected: false,
                                  onLoginTap: () =>
                                      customNavigate(context, "/login"),
                                  onSignupTap: () {},
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      const SizedBox(height: 24),

                                      // -------------------
                                      // الاسم
                                      // -------------------
                                      _buildLabel("الاسم الكامل", nameError),
                                      const SizedBox(height: 8),

                                      ValueListenableBuilder<bool>(
                                        valueListenable: nameError,
                                        builder: (context, hasError, _) {
                                          return AuthTextField(
                                            controller: nameController,
                                            hint: 'اكتب اسمك هنا',
                                            keyboardType: TextInputType.name,
                                            showError: hasError,
                                          );
                                        },
                                      ),

                                      const SizedBox(height: 16),

                                      // -------------------
                                      // البريد الإلكتروني
                                      // -------------------
                                      _buildLabel(
                                        "البريد الإلكتروني",
                                        emailError,
                                      ),
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

                                      const SizedBox(height: 16),

                                      // -------------------
                                      // تأكيد كلمة المرور
                                      // -------------------
                                      _buildLabel(
                                        "إعادة كتابة كلمة المرور",
                                        confirmPassError,
                                      ),
                                      const SizedBox(height: 8),

                                      ValueListenableBuilder<bool>(
                                        valueListenable: confirmPassError,
                                        builder: (context, hasError, _) {
                                          return AuthTextField(
                                            controller: confirmPassController,
                                            hint: '********',
                                            isPassword: true,
                                            showError: hasError,
                                          );
                                        },
                                      ),

                                      const SizedBox(height: 24),

                                      // زر إنشاء حساب
                                      _buildSubmitButton(state, context),

                                      const SizedBox(height: 12),

                                      // لديك حساب؟
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                            onTap: () => customNavigate(
                                              context,
                                              "/login",
                                            ),
                                            child: Text(
                                              'تسجيل الدخول',
                                              style: AppTextStyles
                                                  .lato600style20
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
              );
            },
          ),
        ),
      ),
    );
  }

  // -----------------------------------------------------------
  // Widgets صغيرة لزيادة النظافة
  // -----------------------------------------------------------

  Widget _buildLabel(String text, ValueNotifier<bool> notifier) {
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
        ValueListenableBuilder(
          valueListenable: notifier,
          builder: (_, hasError, __) => hasError
              ? const Text("*", style: TextStyle(color: Colors.red))
              : const SizedBox(),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(AuthState state, BuildContext context) {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        onPressed: state is AuthLoading
            ? null
            : () {
                final name = nameController.text.trim();
                final email = emailController.text.trim();
                final pass = passController.text.trim();
                final confirm = confirmPassController.text.trim();

                final nameMsg = AuthValidator.validateName(name);
                final emailMsg = AuthValidator.validateEmail(email);
                final passMsg = AuthValidator.validatePassword(pass);
                final confirmMsg = AuthValidator.validateConfirmPassword(
                  pass,
                  confirm,
                );

                nameError.value = nameMsg != null;
                emailError.value = emailMsg != null;
                passError.value = passMsg != null;
                confirmPassError.value = confirmMsg != null;

                if (nameMsg != null ||
                    emailMsg != null ||
                    passMsg != null ||
                    confirmMsg != null) {
                  final firstError =
                      nameMsg ?? emailMsg ?? passMsg ?? confirmMsg;
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(firstError!)));
                  return;
                }

                context.read<AuthCubit>().register(
                  email: email,
                  password: pass,
                  fullName: name,
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
                'إنشاء حساب',
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
