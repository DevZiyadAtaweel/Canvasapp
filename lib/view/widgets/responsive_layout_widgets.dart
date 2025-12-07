import 'package:flutter/material.dart';

import '../../features/drawing/drawing_screen.dart';
import 'drawing_responsive_tablet_widgets.dart';
class ResponsiveLayoutWidgets extends StatelessWidget {
  const ResponsiveLayoutWidgets({super.key,
    required this.mobile,
    this.tablet,
    this.desktop
  });
final Widget mobile;
final Widget? tablet;
final Widget? desktop;
  @override
  Widget build(BuildContext context) {
    final Size size =MediaQuery.of(context).size;
    if (size.width>=1100&&desktop!=null )
    {
      return desktop!;

    }else if(size.width>=650&&tablet!=null)
    {
      return ScreenTablet();
    }
    else {
      return DrawingScreen();
    }
    }
  }
