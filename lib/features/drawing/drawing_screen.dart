// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:moftahak/core/widgets/custem_elevatedButton_widgets.dart';
// import 'package:moftahak/core/widgets/name_drawer_widgets.dart';
// import 'package:moftahak/features/home/home_screen.dart';
//
// import 'dart:io'; // لـ File
// import 'package:flutter/material.dart'; // لـ BuildContext و Widget
// import 'package:image_picker/image_picker.dart'; // لـ ImagePicker و XFile
//
// import '../../core/constants/app_colors.dart';
//
// class DrawingScreen extends StatefulWidget {
//   const DrawingScreen({super.key});
//
//   @override
//   State<DrawingScreen> createState() => _DrawingScreenState();
//
// }
//
// class _DrawingScreenState extends State<DrawingScreen> {
//
//   final ImagePicker _picker = ImagePicker();
//   List<XFile>? _mediaFileList;
//   dynamic _pickImageError;
//   String? _retrieveDataError;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Drawing Screen')),
//       body: Center(
//         child: _previewImages(),
//       ),
//     );
//   }
// }
//
// @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backGroundColor,
//
//       appBar: AppBar(
//         backgroundColor: AppColors.backGroundColor,
//
//         title: Text('اختر فنان اليوم'),
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => HomeScreen()),
//             );
//           },
//           icon: Icon(Icons.arrow_back_outlined),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             NameDrawerWidgets(),
//             SizedBox(height: 50),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 CustemElevatedbuttonWidgets(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => HomeScreen()),
//                     );
//                   },
//                   textButton: 'ارفاق صورة',
//                   width: 200,
//                   icon: Icon(Icons.upload, size: 22),
//                 ),
//                 CustemElevatedbuttonWidgets(
//                   onPressed: ()
//                   {
//                     _onImageButtonPressed(ImageSource.camera, context: context);
//                   },
//                   textButton: 'التقاط صورة',
//                   width: 200,
//                   icon: Icon(Icons.camera_alt_outlined, size: 22),
//                 ),
//               ],
//             ),
//             SizedBox(height: 80),
//             Divider(
//               color: Colors.black,
//               height: 40,
//               thickness: 1,
//               indent: 1,
//               endIndent: 1,
//             ),
//             Text(
//               'تاكد من الاتي قبل التقاط الصورة',
//               style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
//             ),
//
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 40),
//               child: Container(
//                 height: 300,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.2),
//                   borderRadius: BorderRadius.all(Radius.circular(16)),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.3),
//                       // لون الظل ودرجة الشفافية (مهم جداً للواقعية)
//                       offset: Offset(0, 4),
//                       // إزاحة الظل: 0 أفقياً، 4 رأسياً (للأسفل)
//                       blurRadius: 8,
//                       // مدى نعومة الظل وانتشاره
//                       spreadRadius: 2, // انتشار الظل قليلاً للخارج
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 28,
//                     horizontal: 22,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         'تأكد من وضوح التصوير   \u2022',
//                         style: TextStyle(
//                           fontSize: 28,
//                           fontWeight: FontWeight.w300,
//                           color: Colors.white,
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         'تأكد من عدم وجود ظلال   \u2022',
//                         style: TextStyle(
//                           fontSize: 28,
//                           fontWeight: FontWeight.w300,
//                           color: Colors.white,
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         'تأكد من عدم وجود ظلال   \u2022',
//                         style: TextStyle(
//                           fontSize: 28,
//                           fontWeight: FontWeight.w300,
//                           color: Colors.white,
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         'تأكد من ثبات الكاميرا عند التصوير  \u2022',
//                         style: TextStyle(
//                           fontSize: 28,
//                           fontWeight: FontWeight.w300,
//                           color: Colors.white,
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// Future<void> _onImageButtonPressed(
//     ImageSource source, {
//       required BuildContext context,
//       bool allowMultiple = false,
//       bool isMedia = false,
//     }); async {
//   try {
//     final XFile? ;pickedFile = await _picker.pickImageku(source: source);
//     setState(() {
//       _;setImageFileListFromFile(pickedFile);
//     });
//   } catch (e) {
//     setState(() {
//       _;pickImageError = e;
//     });
//   }
// }
//
// void _setImageFileListFromFile(XFile? value) {
//
//   _mediaFileList = value == null ? null : <XFile>[value];
// }
//
//
// Widget _previewImages() {
//
//   if (_mediaFileList != null) {
//     return Semantics(
//       label: 'image_picker_example_picked_images',
//       child: ListView.builder(
//         key: UniqueKey(),
//         itemBuilder: (BuildContext context, int index) {
//           return Semantics(
//             label: 'image_picker_example_picked_image',
//             child: Image.file(
//               File(_mediaFileList![index].path),
//               errorBuilder:
//                   (BuildContext context, Object error, StackTrace? stackTrace) {
//                 return const Center(
//                   child: Text('This image type is not supported'),
//                 );
//               },
//             ),
//           );
//         },
//         itemCount: _mediaFileList!.length,
//       ),
//     );
//   } else if (_pickImageError != null) {
//     return Text('Pick image error: $_pickImageError', textAlign: TextAlign.center);
//   } else {
//     return const Text('You have not yet picked an image.', textAlign: TextAlign.center);
//   }
// }
//}
//
