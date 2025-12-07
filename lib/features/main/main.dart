import 'package:flutter/material.dart';
import 'package:moftahak/features/add%20child/add_child_view.dart';
import 'package:moftahak/features/all_drawings/all_drawings.dart';
import 'package:moftahak/features/drawing/drawing_screen.dart';
import 'package:moftahak/features/home/home_screen.dart';
import 'package:moftahak/features/settings/settings_view.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    SettingsView(),
    DrawingScreen(),
    AllDrawings(),
    AddChildView(),
  ];

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onAddPressed() {
    setState(() {
      _selectedIndex = 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // خليه نفس لون الخلفية العامة عشان يندمج حلو
      backgroundColor: const Color(0xFFF8F8F8),
      body: Stack(
        children: [
          Positioned.fill(child: _pages[_selectedIndex]),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: SizedBox(
                height: 96,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // الخلفية بدون ظل – فقط حد خفييف
                    Positioned.fill(
                      top: 18,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(
                              color: Colors.grey.shade200,
                              width: 2,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _NavItem(
                                icon: Icons.home_filled,
                                label: 'الرئيسية',
                                isActive: _selectedIndex == 0,
                                onTap: () => _onNavItemTapped(0),
                              ),
                              _NavItem(
                                icon: Icons.settings_outlined,
                                label: 'الإعدادات',
                                isActive: _selectedIndex == 1,
                                onTap: () => _onNavItemTapped(1),
                              ),
                              const SizedBox(width: 60),
                              _NavItem(
                                icon: Icons.history,
                                label: 'السجل',
                                isActive: _selectedIndex == 3,
                                onTap: () => _onNavItemTapped(3),
                              ),
                              _NavItem(
                                icon: Icons.person_outline,
                                label: 'أنا',
                                isActive: _selectedIndex == 4,
                                onTap: () => _onNavItemTapped(4),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // زر + في النص
                    Align(
                      alignment: Alignment.topCenter,
                      child: GestureDetector(
                        onTap: _onAddPressed,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF8A3FFC),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
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
      borderRadius: BorderRadius.circular(24),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: EdgeInsets.symmetric(
          horizontal: isActive ? 14 : 8,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isActive ? activeColor.withOpacity(0.06) : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22, color: isActive ? activeColor : inactiveColor),
            if (isActive) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: activeColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
