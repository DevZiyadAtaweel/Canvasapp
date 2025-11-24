import 'package:flutter/material.dart';
class CustemImageIconWidgets extends StatelessWidget {
  const CustemImageIconWidgets({super.key, required this.imagepath, required this.width, required this.height});
final String imagepath;
  final double width ;
  final double height ;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        shape: BoxShape.circle,
        image:  DecorationImage(
          image: AssetImage(imagepath),fit: BoxFit.cover
          ),

        ),
    );
  }
}
