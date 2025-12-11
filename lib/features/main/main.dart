import 'package:flutter/material.dart';
import 'package:moftahak/features/add%20child/add_child_view.dart';
import 'package:moftahak/features/child%20analysis/child_analysis_view.dart';
import 'package:moftahak/features/drawing/drawing_screen.dart';
import 'package:moftahak/features/home/home_screen.dart';
import 'package:moftahak/features/main/widgets/nav_item.dart';
import 'package:moftahak/features/settings/settings_view.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int _selectedIndex = 0;

  late final List<Widget> _pages = [
    HomeScreen(onGoToAddChild: () => _onNavItemTapped(1)),
    AddChildView(),
    DrawingScreen(),
    ChildAnalysisScreen(),
    SettingsView(),
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
                              NavItem(
                                icon: const Icon(Icons.home_filled),
                                label: 'الرئيسية',
                                isActive: _selectedIndex == 0,
                                onTap: () => _onNavItemTapped(0),
                              ),

                              NavItem(
                                icon: Stack(
                                  alignment: Alignment.center,
                                  children: const [
                                    Icon(Icons.child_care, size: 26),
                                    Positioned(
                                      right: -1,
                                      top: -1,
                                      child: Icon(
                                        Icons.add,
                                        size: 12,
                                        // شيل fontWeight هون لأنه مش موجود في Icon
                                      ),
                                    ),
                                  ],
                                ),
                                label: 'اضافة طفل',
                                isActive: _selectedIndex == 1,
                                onTap: () => _onNavItemTapped(1),
                              ),

                              const SizedBox(width: 60),

                              NavItem(
                                icon: const Icon(Icons.history),
                                label: 'تحليل الرسمات',
                                isActive: _selectedIndex == 3,
                                onTap: () => _onNavItemTapped(3),
                              ),

                              NavItem(
                                icon: const Icon(Icons.settings_outlined),
                                label: 'الإعدادات',
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
