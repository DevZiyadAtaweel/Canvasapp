import 'package:flutter/material.dart';
import 'package:moftahak/core/constants/app_text_styles.dart';

class NavItem extends StatelessWidget {
  final Widget icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const NavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color activeColor = const Color(0xFF8A3FFC);
    final Color inactiveColor = Colors.grey.shade500;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconTheme(
              data: IconThemeData(
                size: 26,
                color: isActive ? activeColor : inactiveColor,
              ),
              child: icon,
            ),

            const SizedBox(height: 4),

            Text(
              label,
              style: AppTextStyles.almarai500style16.copyWith(
                color: isActive ? activeColor : inactiveColor,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
