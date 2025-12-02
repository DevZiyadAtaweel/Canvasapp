import 'package:flutter/material.dart';

class CustemImageIconWidgets extends StatelessWidget {
  const CustemImageIconWidgets({
    super.key,
    required this.imagepath,
    required this.width,
    required this.height,
    required this.onTap,
  });

  final String imagepath; // رابط الصورة (URL)
  final double width;
  final double height;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bool hasImage = imagepath.isNotEmpty;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          shape: BoxShape.circle,
          image: hasImage
              ? DecorationImage(
                  image: NetworkImage(imagepath),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: !hasImage
            ? const Icon(Icons.person, size: 30, color: Colors.white)
            : null,
      ),
    );
  }
}
