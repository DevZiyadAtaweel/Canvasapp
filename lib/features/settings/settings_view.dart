import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moftahak/core/constants/app_gradients.dart';
import 'package:moftahak/core/constants/app_text_styles.dart';
import 'package:moftahak/core/constants/navigation.dart';
import 'package:moftahak/core/widgets/corner_decoration.dart';
import 'package:moftahak/features/auth/cubit/auth_cubit.dart';

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
        child: Scaffold(
          appBar: AppBar(
            title: Text("اعداداتي", style: AppTextStyles.lato700style28),
            toolbarHeight: 100,
            leading: IconButton(
              onPressed: () {
                customNavigatePop(context);
              },
              icon: Icon(Icons.arrow_back, color: Colors.white),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
          ),
          extendBodyBehindAppBar: true,
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 24.0),
                decoration: BoxDecoration(gradient: AppGradients.mainGradient),
                child: Column(
                  children: [
                    SizedBox(height: kToolbarHeight),
                    Divider(color: Colors.white),

                    CircleAvatar(
                      radius: 40,
                      backgroundImage: const NetworkImage(
                        'https://i.pravatar.cc/150?img=47', // غيّريها لـ AssetImage لو عندك صورة محلية
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'هالة علي',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'haal123@gmail.com',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),

                    const SizedBox(height: 16),

                    // زر تعديل الملف الشخصي
                    SizedBox(
                      width: 180,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFD400),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'تعديل الملف الشخصي',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    Expanded(
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'الحساب',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              _SettingsCard(
                                items: [
                                  _SettingsItem(
                                    title: 'تغيير كلمة المرور',
                                    onTap: () {},
                                  ), // TODO
                                  _SettingsItem(
                                    title: 'تحديث البريد الالكتروني',
                                    onTap: () {},
                                  ),
                                ],
                              ),

                              const SizedBox(height: 16),

                              // قسم الأبناء
                              const Text(
                                'الأبناء',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              _SettingsCard(
                                items: [
                                  _SettingsItem(title: 'عمر', onTap: () {}),
                                  _SettingsItem(
                                    title: 'إضافة ابن جديد',
                                    onTap: () {},
                                  ),
                                ],
                              ),

                              const SizedBox(height: 16),

                              // قسم الرسومات
                              const Text(
                                'الرسومات',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              _SettingsCard(
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

                              // الدعم وتسجيل الخروج
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
              CornerDecoration(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final List<_SettingsItem> items;

  const _SettingsCard({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class _SettingsItem {
  final String title;
  final VoidCallback onTap;

  _SettingsItem({required this.title, required this.onTap});
}
