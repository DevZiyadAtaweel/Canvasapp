import 'package:flutter/material.dart';
class CustemDrawingWidgets extends StatelessWidget {
  const CustemDrawingWidgets({
    super.key, required this.width,
    this.textContainer = const SizedBox(), required this.Textimage,});
  final double width ;
  final Widget textContainer;
  final String Textimage;
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Container(
          height: 175,
          width: width,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(Textimage),fit: BoxFit.cover),
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(18)),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        textContainer,
      ],
    );
  }
}
// fit: BoxFit.cover,
