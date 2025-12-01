import 'package:flutter/material.dart';
import 'package:moftahak/core/widgets/custem_drawing_widgets.dart';
import 'package:moftahak/core/widgets/custem_elevatedButton_widgets.dart';
import 'package:moftahak/core/widgets/custem_image_icon_widgets.dart';
import 'package:moftahak/core/constants/app_colors.dart';
import 'package:moftahak/core/widgets/name_drawer_widgets.dart';
import 'package:moftahak/view/screen/drawing_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 20),
                  // مسافة علوية إضافية
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // تم دمج التعارض هنا. سيتم اعتماد منطق الفرع الثاني الذي وضع العناصر داخل Row بشكل صحيح
                      const NameDrawerWidgets(),

                      const SizedBox(width: 70),

                      CustemImageIconWidgets(
                        width: 60,
                        height: 60,
                        imagepath: 'assets/images/on_boarding_new.png',
                      ),
                      // تم إزالة التكرار في CustemImageIconWidgets إذا كان القصد إضافة أيقونة واحدة.
                      // إذا كان القصد أيقونتين، يجب إضافة الثانية هنا بشكل واضح.
                      // افترضت هنا أن الكود المدمج كان يهدف لإظهار أيقونة واحدة في النهاية.

                      // إذا كنت تريد أيقونتين بجانب بعض، يجب أن يكون الكود هكذا:
                      // CustemImageIconWidgets(
                      //   width: 60,
                      //   height: 60,
                      //   imagepath: 'assets/images/on_boarding_new.png',
                      // ),
                      // CustemImageIconWidgets(
                      //   width: 60,
                      //   height: 60,
                      //   imagepath: 'assets/images/on_boarding_new.png',
                      // ),

                    ],
                  ),
                  // *******************
                  // رسالة الترحيب
                  // *******************
                  const SizedBox(height: 10),
                  const Text(
                    '!مرحبا محمد علي مساء الخير',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  // *******************
                  // زر رسمة جديدة
                  // *******************
                  const SizedBox(height: 25),
                  CustemElevatedbuttonWidgets(
                    // تم دمج وظيفة onPressed من الفرع الآخر
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DrawingScreen(), // إضافة const إذا كانت الشاشة ثابتة
                        ),
                      );
                    },
                    width: double.infinity,
                    textButton: 'رسمة جديدة',
                  ),
                  const SizedBox(height: 15),
                  // *******************
                  // نظرة على رسومات طفلك
                  // *******************
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'انظر المزيد',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_back_ios),
                          ),
                        ],
                      ),

                      const Text(
                        'نظرة على رسومات طفلك',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // *******************
                  // عرض الرسومات الرأسي
                  // *******************
                  CustemDrawingWidgets(
                    width: double.infinity,
                    Textimage: 'assets/images/on_boarding2.png',
                  ),

                  const SizedBox(height: 40),

                  // *******************
                  // تقييم الطبيب النفسي
                  // *******************
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          'أبنائي',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 40),

                        CustemImageIconWidgets(
                          width: 135,
                          height: 135,
                          imagepath: 'assets/images/on_boarding_new.png',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
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
