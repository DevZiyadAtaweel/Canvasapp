import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moftahak/core/constants/app_colors.dart';
import 'package:moftahak/core/constants/app_text_styles.dart';
import 'package:moftahak/core/constants/navigation.dart';
import 'package:moftahak/features/auth/cubit/auth_cubit.dart';

import 'package:moftahak/features/home/cubit/home_cubit.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          customNavigatePushReplacement(context, '/login');
        }
        if (state is AuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: SafeArea(
        bottom: true,
        top: false,
        child: Scaffold(
          appBar: AppBar(title: Text("اعداداتي")),
          body: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
              //  vertical: 24.0,
            ),

            child: Column(
              children: [
                // const SizedBox(height: kToolbarHeight + 20),
                //  const Divider(color: Colors.grey),

                // ================== بيانات المستخدم من HomeCubit ==================
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoading || state is HomeInitial) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      );
                    }

                    if (state is HomeError) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    if (state is! HomeSuccess) {
                      return const SizedBox.shrink();
                    }

                    final user = state.user; // UserProfile

                    return Column(
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundImage: NetworkImage(user.imageUrl),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          user.name, // 👈 الاسم كامل هنا
                          style: AppTextStyles.almarai700style20,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user.email,
                          style: AppTextStyles.almarai700style20.copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    );
                  },
                ),

                // ================== باقي الصفحة كما هي ==================
                Expanded(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 15),
                          _SettingsCard(
                            title: 'الحساب',
                            items: [
                              _SettingsItem(
                                title: 'تغيير كلمة المرور',
                                onTap: () {},
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          BlocBuilder<HomeCubit, HomeState>(
                            builder: (context, state) {
                              // لو في تحميل أو حالة مبدئية
                              if (state is HomeLoading ||
                                  state is HomeInitial) {
                                return const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }

                              // لو في خطأ
                              if (state is HomeError) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                  ),
                                  child: Text(
                                    state.message,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                );
                              }

                              if (state is! HomeSuccess) {
                                return const SizedBox.shrink();
                              }

                              final children = state.children;

                              final List<_SettingsItem> items = [];

                              // لو في أبناء: أضف أسماءهم بالترتيب
                              if (children.isNotEmpty) {
                                for (final child in children) {
                                  items.add(
                                    _SettingsItem(
                                      title: child.name, // 👈 اسم الإبن
                                      onTap: () {
                                        // مثال: صفحة تفاصيل الطفل
                                        customNavigatePush(
                                          context,
                                          '/childDetails/${child.id}', // عدّل حسب الروت عندك
                                        );
                                      },
                                    ),
                                  );
                                }
                              }

                              // سواء في أبناء أو لا، دايماً نضيف "إضافة ابن جديد" في الآخر
                              items.add(
                                _SettingsItem(
                                  title: 'إضافة ابن جديد',
                                  onTap: () {
                                    customNavigatePush(context, '/addChild');
                                  },
                                ),
                              );

                              return _SettingsCard(
                                title: 'الأبناء',
                                items: items,
                              );
                            },
                          ),

                          const SizedBox(height: 16),

                          _SettingsCard(
                            title: 'الرسومات',
                            items: [
                              _SettingsItem(
                                title: 'تحليل الرسومات',
                                onTap: () {},
                              ),
                              _SettingsItem(title: 'رسمة جديدة', onTap: () {}),
                            ],
                          ),

                          //  const SizedBox(height: 10),
                          Center(
                            child: Column(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    customNavigatePush(context, '/support');
                                  },
                                  child: Text(
                                    'الدعم والمساعدة',
                                    style: AppTextStyles.almarai700style20
                                        .copyWith(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16,
                                        ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.read<AuthCubit>().logout();
                                  },
                                  child: Text(
                                    'تسجيل الخروج',
                                    style: AppTextStyles.almarai700style20
                                        .copyWith(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16,
                                        ),
                                  ),
                                ),
                                SizedBox(height: 100),
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
          ),
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final List<_SettingsItem> items;
  final String title;

  const _SettingsCard({required this.items, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topRight,
          child: Text(
            title,
            style: AppTextStyles.almarai700style20.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.textField,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: items
                .map(
                  (item) => Column(
                    children: [
                      ListTile(
                        title: Text(
                          item.title,
                          style: AppTextStyles.almarai700style20.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                        onTap: item.onTap,
                      ),
                      if (item != items.last)
                        const Divider(height: 1, thickness: 1),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _SettingsItem {
  final String title;
  final VoidCallback onTap;

  _SettingsItem({required this.title, required this.onTap});
}
