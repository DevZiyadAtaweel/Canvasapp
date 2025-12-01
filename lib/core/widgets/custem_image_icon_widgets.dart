import 'package:flutter/material.dart';

class CustemImageIconWidgets extends StatelessWidget {
  const CustemImageIconWidgets({
    super.key,
    required this.imagepath,
    required this.width,
    required this.height,
    required this.onTap,
  });
  final String imagepath;
  final double width;
  final double height;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(imagepath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
