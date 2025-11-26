import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
// class CustemElevatedbuttonWidgets extends StatelessWidget {
//   const CustemElevatedbuttonWidgets({super.key, required this.textButton, required this.width});
// final String textButton;
// final double width;
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 55,
//       width:width,
//       child: ElevatedButton(
//         onPressed: () {},
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.yellow,
//           foregroundColor: Colors.black,
//           elevation: 5,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         child:  Text(
//     textButton,
//     style: const TextStyle(
//     fontSize: 25,
//     fontWeight: FontWeight.bold,
//     ),
//
//           // style: TextStyle(
//           //   fontSize: 25,
//           //   fontWeight: FontWeight.bold,
//           ),
//
//       )
//     );
//   }
// }



class CustemElevatedbuttonWidgets extends StatelessWidget {
  const CustemElevatedbuttonWidgets({
    super.key,
    required this.textButton,
    required this.width,
    this.icon,
  });

  final String textButton;
  final double width;
  final Widget? icon; // ⬅ أيقونة اختيارية

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: width,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.yellow,
          foregroundColor: Colors.black,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        // 👇 هنا المنطق الجديد
        child: icon == null
            ? Text(
          textButton,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon!,
            const SizedBox(width: 10),
            Text(
              textButton,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
