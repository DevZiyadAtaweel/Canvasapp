import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:moftahak/core/constants/navigation.dart';
import 'package:moftahak/core/widgets/children_dropdown.dart';
import 'package:moftahak/core/widgets/custem_drawing_widgets.dart';
import 'package:moftahak/core/widgets/custem_elevatedButton_widgets.dart';
import 'package:moftahak/core/widgets/custem_image_icon_widgets.dart';
import 'package:moftahak/core/constants/app_gradients.dart';
import 'package:moftahak/features/drawing/drawing_screen.dart';
import 'package:moftahak/features/home/cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
const HomeScreen({super.key});

@override
Widget build(BuildContext context) {
return Container(
decoration: const BoxDecoration(
gradient: AppGradients.mainGradient, // الخلفية المتدرجة
),
child: Scaffold(
backgroundColor: Colors.transparent, // عشان يظهر التدرّج
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
style: const TextStyle(color: Colors.white),
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
style: const TextStyle(
fontSize: 24,
fontWeight: FontWeight.bold,
color: Colors.white,
),
),

const SizedBox(height: 25),

// ================== زر رسمة جديدة ==================
CustemElevatedbuttonWidgets(
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => const DrawingScreen(),
),
);
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
const Text(
'انظر المزيد',
style: TextStyle(
fontSize: 18,
fontWeight: FontWeight.bold,
color: Colors.white,
),
),
IconButton(
onPressed: () {},
icon: const Icon(
Icons.arrow_back_ios,
color: Colors.white,
),
),
],
),
const Text(
'نظرة على رسومات طفلك',
style: TextStyle(
fontSize: 18,
fontWeight: FontWeight.bold,
color: Colors.white,
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
children: [
const Text(
'أبنائي',
style: TextStyle(
fontSize: 40,
fontWeight: FontWeight.bold,
color: Colors.white,
),
),
const SizedBox(height: 40),
// CustemImageIconWidgets(
//   onTap: () {
//     // هنا لاحقًا تروح على شاشة الأبناء
//   },
//   width: 135,
//   height: 135,
//   imagepath: 'assets/images/on_boarding_new.png',
// ),
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
