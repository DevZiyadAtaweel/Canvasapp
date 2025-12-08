import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moftahak/core/constants/app_text_styles.dart';

import 'package:moftahak/core/constants/navigation.dart';
import 'package:moftahak/core/widgets/custem_drawing_widgets.dart';
import 'package:moftahak/core/widgets/custem_elevatedButton_widgets.dart';
import 'package:moftahak/core/widgets/custem_image_icon_widgets.dart';
import 'package:moftahak/features/home/cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onGoToAddChild});
  final VoidCallback onGoToAddChild;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              // ----------------- حالات التحميل / الخطأ -----------------
              if (state is HomeLoading || state is HomeInitial) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is HomeError) {
                return Center(
                  child: Text(
                    state.message,
                    style: AppTextStyles.almarai700style20,
                  ),
                );
              }

              if (state is! HomeSuccess) {
                return const SizedBox.shrink();
              }

              // ----------------- حالة البيانات المحمّلة -----------------
              final user = state.user; // UserProfile
              final firstName = context.read<HomeCubit>().getFirstName(
                user.name,
              );
              final children = state.children;

              return ListView(
                children: [
                  const SizedBox(height: 30),

                  // ================== رسالة الترحيب ==================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        ' $firstName  مرحبا',
                        textAlign: TextAlign.right,
                        style: AppTextStyles.almarai700style20,
                      ),
                      const SizedBox(width: 10),
                      CustemImageIconWidgets(
                        width: 60,
                        height: 60,
                        imagepath: user
                            .imageUrl, // 👈 رابط ui-avatars اللي خزّنّاه في Firestore
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),
                  Text(
                    "ابدأي يومك بالعناية بصحة طفلك النفسية",
                    textAlign: TextAlign.right,
                    style: AppTextStyles.almarai700style20.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // ================== زر رسمة جديدة ==================
                  CustemElevatedbuttonWidgets(
                    onPressed: () {
                      customNavigatePush(context, "/drawing");
                    },
                    width: double.infinity,
                    textButton: 'رسمة جديدة',
                  ),

                  const SizedBox(height: 40),

                  Center(
                    child: Column(
                      children: [
                        Text('أبنائي', style: AppTextStyles.almarai700style28),
                        const SizedBox(height: 16),
                        // 🔥 Scrollable Row
                        if (children.isEmpty)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,

                            children: [
                              GestureDetector(
                                onTap: onGoToAddChild,
                                child: Text(
                                  'أضف طفلك الأول',
                                  style: AppTextStyles.almarai500style16
                                      .copyWith(
                                        color: const Color(0xFF8A3FFC),
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration
                                            .underline, // لو بدك شكل رابط
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Text(
                                '   لم تقم بإضافة أي أطفال بعد',
                                style: AppTextStyles.almarai500style16,
                              ),

                              // 🔥 النص القابل للضغط
                            ],
                          )
                        else
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: children.map((child) {
                                return GestureDetector(
                                  onTap: () {
                                    customNavigatePush(
                                      context,
                                      '/childDetails/${child.id}',
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 18,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF8A3FFC), // بنفسجي
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 6,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      child.name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  // ================== نظرة على رسومات طفلك ==================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'انظر المزيد',
                            style: AppTextStyles.almarai700style20.copyWith(
                              fontSize: 16,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'نظرة على رسومات طفلك',
                        style: AppTextStyles.almarai700style20.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  // ================== عرض الرسومات ==================
                  CustemDrawingWidgets(
                    width: double.infinity,
                    Textimage: 'assets/images/on_boarding2.png',
                  ),

                  const SizedBox(height: 40),

                  // ================== قسم أبنائي ==================
                  const SizedBox(height: 40),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
