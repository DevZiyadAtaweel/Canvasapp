// // ملف: DrawingScreen.dart
//
// import 'dart:typed_data'; // تم تصحيح هذا الاستيراد
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:moftahak/view/widgets/responsive_layout_widgets.dart';
//
// import '../../core/constants/app_colors.dart';
// import '../../features/home/home_screen.dart'; // افترضت أن HomeScreen في هذا المسار
// import '../widgets/name_drawer_widgets.dart'; // افترضت أن هذا الـ Widget موجود
// import 'display_image.dart'; // افترضت أن هذا الـ Widget موجود
// import 'drawing_responsive_mobile_widgets.dart'; // يجب التأكد من مسار الاستيراد
// import 'drawing_responsive_tablet_widgets.dart'; // يجب التأكد من مسار الاستيراد
//
// class DrawingScreen extends StatefulWidget {
//   const DrawingScreen({super.key});
//
//   @override
//   State<DrawingScreen> createState() => _DrawingScreenState();
// }
//
// class _DrawingScreenState extends State<DrawingScreen> {
//   // --- المنطق الخاص بالـ State يبقى هنا ---
//   Uint8List? selectedImage;
//   // ... (أي متغيرات state أخرى مثل _mediaFileList, _pickImageError) ...
//
//   // دالة التقاط/اختيار الصورة
//   Future<void> _onImageButtonPressed(ImageSource source) async {
//     // يجب وضع كامل منطق التقاط الصورة والتوجيه هنا
//     // ... (كودك الأصلي للالتقاط والتوجيه) ...
//   }
//
//   // دالة اختيار الصورة من المعرض
//   Future<Uint8List?> pickImage() async {
//     // يجب وضع كامل منطق اختيار الصورة هنا
//     // ... (كودك الأصلي لـ pickImage) ...
//     final picker = ImagePicker();
//     final XFile? file = await picker.pickImage(source: ImageSource.gallery);
//     if (file == null) return null;
//     return await file.readAsBytes();
//   }
//
//   // دالة مساعدة لتنسيق النص (يمكنك نقلها لملف مساعد إن أردت)
//   Widget _buildInstructionText(String text) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Text(
//         '$text   \u2022',
//         style: const TextStyle(
//           fontSize: 20,
//           fontWeight: FontWeight.w300,
//           color: Colors.white,
//         ),
//         textAlign: TextAlign.right,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backGroundColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.backGroundColor,
//         title: const Text(
//           'اختر فنان اليوم',
//           style: TextStyle(color: Colors.white),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () {
//             // للتأكد من استخدام الدالة الأصلية في `HomeScreen`
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const HomeScreen()),
//             );
//           },
//           icon: const Icon(Icons.arrow_back_outlined, color: Colors.white),
//         ),
//       ),
//       // 💡 هنا يتم استخدام الـ Widget المتجاوب وتمرير الدوال إليه:
//       body: ResponsiveLayoutWidgets(
//         // التخطيط الخاص بالهاتف (Mobile)
//         mobile: DrawingScreenMobile(
//           // تمرير الدوال هنا
//           onImageButtonPressed: _onImageButtonPressed,
//           pickImage: pickImage,
//           buildInstructionText: _buildInstructionText, // تمرير الدالة المساعدة
//         ),
//         // التخطيط الخاص بالجهاز اللوحي (Tablet)
//         tablet: DrawingScreenTablet(
//           // تمرير الدوال هنا
//           onImageButtonPressed: _onImageButtonPressed,
//           pickImage: pickImage,
//           buildInstructionText: _buildInstructionText, // تمرير الدالة المساعدة
//         ),
//       ),
//     );
//   }
// }