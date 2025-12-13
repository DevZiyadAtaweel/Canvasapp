import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moftahak/core/constants/app_colors.dart';
import 'package:moftahak/core/constants/app_text_styles.dart';

import 'package:moftahak/core/constants/navigation.dart';
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
        child: Directionality(
          textDirection: TextDirection.rtl,
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
                final selectedChildId = state.selectedChildId;
                final lastDrawings = state.lastDrawings;
                final isDrawingsLoading = state.isDrawingsLoading;

                return ListView(
                  children: [
                    const SizedBox(height: 30),

                    // ================== رسالة الترحيب ==================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start, // يمين في RTL
                      children: [
                        CustemImageIconWidgets(
                          width: 60,
                          height: 60,
                          imagepath: user.imageUrl,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'مرحباً $firstName',
                          style: AppTextStyles.almarai700style20,
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

                    // ================== نظرة على رسومات طفلك + اختيار الطفل ==================
                    Center(
                      child: Column(
                        children: [
                          // ===== العنوان + "انظر المزيد" =====
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // العنوان على اليمين (أول عنصر في RTL)
                              Text(
                                'نظرة على رسومات طفلك',
                                style: AppTextStyles.almarai700style20.copyWith(
                                  fontSize: 16,
                                ),
                              ),

                              // // "انظر المزيد" على اليسار
                              // Row(
                              //   children: [
                              //     IconButton(
                              //       onPressed: () {
                              //         // TODO: روح لصفحة كل الرسومات مثلاً
                              //       },
                              //       icon: const Icon(
                              //         Icons.arrow_forward_ios,
                              //         size: 16,
                              //       ),
                              //     ),
                              //     Text(
                              //       'انظر المزيد',
                              //       style: AppTextStyles.almarai700style20
                              //           .copyWith(fontSize: 16),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          // 🔥 Scrollable Row
                          if (children.isEmpty)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'لم تقم بإضافة أي أطفال بعد   ',
                                  style: AppTextStyles.almarai500style16,
                                ),
                                GestureDetector(
                                  onTap: onGoToAddChild,
                                  child: Text(
                                    'أضف طفلك الأول',
                                    style: AppTextStyles.almarai500style16
                                        .copyWith(
                                          color: const Color(0xFF8A3FFC),
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            )
                          else
                            Align(
                              alignment: AlignmentDirectional.center,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: children.map((child) {
                                    final isSelected =
                                        child.id == selectedChildId;

                                    return GestureDetector(
                                      onTap: () {
                                        context.read<HomeCubit>().selectChild(
                                          child.id,
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
                                          color: isSelected
                                              ? const Color(0xFF8A3FFC)
                                              : AppColors.textField,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Text(
                                          child.name,
                                          style: TextStyle(
                                            color: isSelected
                                                ? Colors.white
                                                : AppColors.inactiveColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ================== عرض آخر ٣ رسومات للطفل المختار ==================
                    if (selectedChildId == null)
                      Center(
                        child: Text(
                          'اختر طفلاً من الأعلى لعرض رسوماته',
                          style: AppTextStyles.almarai500style16,
                        ),
                      )
                    else if (isDrawingsLoading)
                      const Center(
                        child: Column(
                          children: [
                            SizedBox(height: 100),
                            CircularProgressIndicator(),
                          ],
                        ),
                      )
                    else if (lastDrawings.isEmpty)
                      Center(
                        child: Column(
                          children: [
                            SizedBox(height: 100),
                            Text(
                              'لا توجد رسومات بعد لهذا الطفل',
                              style: AppTextStyles.almarai500style16,
                            ),
                          ],
                        ),
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 290,
                            width: double.infinity,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: lastDrawings.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 6),
                              itemBuilder: (context, index) {
                                final drawing = lastDrawings[index];
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: AspectRatio(
                                    aspectRatio: 4 / 5,
                                    child: Card(
                                      color: AppColors.kPrimaryPurple
                                          .withOpacity(0.1),
                                      margin: EdgeInsets.all(10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      elevation: 30,
                                      shadowColor: AppColors.kPrimaryPurple
                                          .withOpacity(0.4),
                                      child: Image.network(
                                        drawing.drawingUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              },
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
      ),
    );
  }
}
