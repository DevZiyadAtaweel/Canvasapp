import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moftahak/core/constants/app_gradients.dart';
import 'package:moftahak/core/constants/app_text_styles.dart';
import 'package:moftahak/core/constants/navigation.dart';
import 'package:moftahak/core/widgets/corner_decoration.dart';
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
          appBar: AppBar(
            title: Text("اعداداتي", style: AppTextStyles.lato700style28),
            toolbarHeight: 80,
            leading: IconButton(
              onPressed: () {
                customNavigatePop(context);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
          ),
          extendBodyBehindAppBar: true,
          body: Stack(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 24.0,
                ),
                decoration: const BoxDecoration(
                  gradient: AppGradients.mainGradient,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: kToolbarHeight + 20),
                    const Divider(color: Colors.white),

                    // ================== بيانات المستخدم من HomeCubit ==================
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        if (state is HomeLoading || state is HomeInitial) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
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
                              radius: 50,
                              backgroundImage: NetworkImage(user.imageUrl),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              user.name, // 👈 الاسم كامل هنا
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              user.email,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
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
                              const SizedBox(height: 24),

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

                              _SettingsCard(
                                title: 'الأبناء',
                                items: [
                                  _SettingsItem(title: 'عمر', onTap: () {}),
                                  _SettingsItem(
                                    title: 'إضافة ابن جديد',
                                    onTap: () {
                                      customNavigatePush(context, '/addChild');
                                    },
                                  ),
                                ],
                              ),

                              const SizedBox(height: 16),

                              _SettingsCard(
                                title: 'الرسومات',
                                items: [
                                  _SettingsItem(
                                    title: 'تحليل الرسومات',
                                    onTap: () {},
                                  ),
                                  _SettingsItem(
                                    title: 'رسمة جديدة',
                                    onTap: () {},
                                  ),
                                ],
                              ),

                              const SizedBox(height: 24),

                              Center(
                                child: Column(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        customNavigatePush(context, '/support');
                                      },
                                      child: const Text(
                                        'الدعم والمساعدة',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        context.read<AuthCubit>().logout();
                                      },
                                      child: const Text(
                                        'تسجيل الخروج',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
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

              const CornerDecoration(),
            ],
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
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
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
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                        onTap: item.onTap,
                      ),
                      if (item != items.last)
                        const Divider(height: 1, thickness: 0.5),
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
