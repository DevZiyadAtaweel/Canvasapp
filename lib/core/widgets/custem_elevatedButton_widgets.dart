import 'package:flutter/material.dart';
import 'package:moftahak/core/constants/app_text_styles.dart';

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

class CustemElevatedbuttonWidgets extends StatefulWidget {
  const CustemElevatedbuttonWidgets({
    super.key,
    required this.textButton,
    required this.width,
    required this.onPressed,
    this.icon,
    // <<<<< HEAD:lib/view/widgets/custem_elevatedButton_widgets.dart
    // =======
    // >>>>>>> 8c98d7b106ddb0927500bed0785b77d66099d337:lib/core/widgets/custem_elevatedButton_widgets.dart
  });
  final VoidCallback? onPressed;
  final String textButton;
  final double width;
  final Widget? icon;
  @override
  State<CustemElevatedbuttonWidgets> createState() =>
      _CustemElevatedbuttonWidgetsState();
}

class _CustemElevatedbuttonWidgetsState
    extends State<CustemElevatedbuttonWidgets> {
  // ⬅ أيقونة اختيارية

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: widget.width,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.black,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        // 👇 هنا المنطق الجديد
        child: widget.icon == null
            ? Text(
                widget.textButton,
                style: AppTextStyles.almarai700style20.copyWith(
                  fontSize: 20,
                  color: Colors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.icon!,
                  Text(
                    widget.textButton,
                    style: AppTextStyles.almarai700style20,
                  ),
                ],
              ),
      ),
    );
  }
}
