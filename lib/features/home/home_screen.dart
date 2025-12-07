import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moftahak/core/constants/app_text_styles.dart';

import 'package:moftahak/core/constants/navigation.dart';
import 'package:moftahak/core/widgets/children_dropdown.dart';
import 'package:moftahak/core/widgets/custem_drawing_widgets.dart';
import 'package:moftahak/core/widgets/custem_elevatedButton_widgets.dart';
import 'package:moftahak/core/widgets/custem_image_icon_widgets.dart';
import 'package:moftahak/features/home/cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                  const SizedBox(height: 20),

                  // ================== الهيدر (اسم + أيقونة الإعدادات) ==================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // لو حابب تمرر الاسم لـ ChildrenDropdown عدّل الويجت يستقبل اسم
                      SizedBox(width: 100, child: ChildrenDropdown()),

                      const SizedBox(width: 70),

                      CustemImageIconWidgets(
                        onTap: () {
                          customNavigatePush(context, "/settings");
                        },
                        width: 60,
                        height: 60,
                        imagepath: user
                            .imageUrl, // 👈 رابط ui-avatars اللي خزّنّاه في Firestore
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // ================== رسالة الترحيب ==================
                  Text(
                    ' $firstName مرحبا',
                    textAlign: TextAlign.right,
                    style: AppTextStyles.almarai700style20,
                  ),

                  const SizedBox(height: 25),

                  // ================== زر رسمة جديدة ==================
                  CustemElevatedbuttonWidgets(
                    onPressed: () {
                      customNavigatePush(context, "/drawing");
                    },
                    width: double.infinity,
                    textButton: 'رسمة جديدة',
                  ),

                  const SizedBox(height: 15),

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
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('أبنائي', style: AppTextStyles.almarai700style28),
                        const SizedBox(height: 16),

                        // 🔥 Scrollable Row
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
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:moftahak/core/widgets/custem_drawing_widgets.dart';
// import 'package:moftahak/core/widgets/custem_elevatedButton_widgets.dart';
// import 'package:moftahak/core/widgets/custem_image_icon_widgets.dart';
//
//
// import '../../core/constants/app_colors.dart';
//
// import '../../core/widgets/name_drawer_widgets.dart';
// import '../../view/screen/drawing_screen.dart';
// import '../widgets/custem_elevatedButton_widgets.dart';
// import '../widgets/custem_image_icon_widgets.dart';
// import '../widgets/name_drawer_widgets.dart';
// import 'drawing_screen.dart';
//
// // =======
// // >>>>>>> 8c98d7b106ddb0927500bed0785b77d66099d337:lib/features/home/home_screen.dart
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backGroundColor,
//
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0)
//           ,
//           child
//               :
//           ListView
//             (
//             children
//                 :
//             [
//             Column
//             (
//             mainAxisAlignment
//             :
//             MainAxisAlignment
//             .
//             center
//             ,
//             crossAxisAlignment
//                 :
//             CrossAxisAlignment
//                 .
//             end
//             ,
//             children
//                 :
//             [
//               const
//               SizedBox
//                 (
//                   height
//                       :
//                   20
//               )
//               ,
//
//               // مسافة علوية إضافية
//               Row
//                 (
//                 mainAxisAlignment
//                     :
//                 MainAxisAlignment
//                     .
//                 end
//                 ,
//                 crossAxisAlignment
//                     :
//                 CrossAxisAlignment
//                     .
//                 center
//                 ,
//                 children
//                     :
//                 [
// // <<<<<<< HEAD:lib/view/screen/home_screen.dart
//
//                   NameDrawerWidgets
//                     (
//                   )
//                   ,
//                   SizedBox
//                     (
//                     width
//                         :
//                     70
//                     ,
// // =======
//                     child: NameDrawerWidgets
//                       (
//                     ),
//                     SizedBox
//                       (
//                         width: 70
//                     ),
//
//                     CustemImageIconWidgets
//                       (
//                       width
//                           :
//                       60
//                       ,
//                       height
//                           :
//                       60
//                       ,
//                       imagepath
//                           :
//                       '
//                       assets/images/on_boarding_new.png
//                       '
//                       ,
// // >>>>>>> 8c98d7b106ddb0927500bed0785b77d66099d337:lib/features/home/home_screen.dart
//                     )
//                     ,
//
//                     CustemImageIconWidgets
//                       (
//                       width
//                           :
//                       60
//                       ,
//                       height
//                           :
//                       60
//                       ,
//                       imagepath
//                           :
//                       '
//                       assets/images/on_boarding_new.png
//                       '
//                       ,
//                     )
//                     ,
//
//                     ],
//                   ),
//                   // *******************
//                   // رسالة الترحيب
//                   // *******************
//                   const SizedBox(height: 10),
//                   const Text(
//                     '!مرحبا محمد علي مساء الخير',
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//
//                   // *******************
//                   // زر رسمة جديدة
//                   // *******************
//                   const SizedBox(height: 25),
//                   CustemElevatedbuttonWidgets(
//                     // <<<<<<< HEAD,
//                     // :lib/view/screen/home_screen.dart
//                     onPressed: () {
//                       // =======
//
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => DrawingScreen(),
//                         ),
//                       );
//                       // >>>>>>> 8c98d7b106ddb0927500bed0785b77d66099d337:lib/features/home/home_screen.dart
//                     },
//                     width: double.infinity,
//                     textButton: 'رسمة جديدة',
//                   ),
//                   SizedBox(height: 15),
//                   // *******************
//                   // نظرة على رسومات طفلك
//                   // *******************
//                   Container(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             const Text(
//                               'انظر المزيد',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             IconButton(
//                               onPressed: () {},
//                               icon: const Icon(Icons.arrow_back_ios),
//                             ),
//                           ],
//                         ),
//
//                         const Text(
//                           'نظرة على رسومات طفلك',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 15),
//
//                   // *******************
//                   // عرض الرسومات الرأسي
//                   // *******************
//                   CustemDrawingWidgets(
//                     width: double.infinity,
//                     Textimage: 'assets/images/on_boarding2.png',
//                   ),
//
//                   const SizedBox(height: 40),
//
//                   // *******************
//                   // تقييم الطبيب النفسي
//                   // *******************
//                   Center(
//                     child: Column(
//                       children: [
//                         const Text(
//                           'أبنائي',
//                           style: TextStyle(
//                             fontSize: 40,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//
//                         const SizedBox(height: 40),
//
//                         CustemImageIconWidgets(
//                           width: 135,
//                           height: 135,
//                           imagepath: 'assets/images/on_boarding_new.png',
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
