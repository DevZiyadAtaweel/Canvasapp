import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class NameDrawerWidgets extends StatefulWidget {
  const NameDrawerWidgets({super.key});

  @override
  State<NameDrawerWidgets> createState() => _NameDrawerWidgetsState();
}

class _NameDrawerWidgetsState extends State<NameDrawerWidgets> {
  String? itemName = 'الأبناء';

  List<String> items = ['الأبناء', 'الأمهات', 'الآباء', 'الأصدقاء'];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButton<String>(
          value: itemName,

          // ⬅️ **تم إضافة menuStyle هنا (المكان الصحيح)**
          icon: const Icon(
            Icons.arrow_drop_down, // أيقونة السهم القياسية
            size: 40.0,
            color: Colors.yellow,
          ),
          style: const TextStyle(color: Colors.black, fontSize: 25.0),

          items: items.map<DropdownMenuItem<String>>((String item) {
            return DropdownMenuItem<String>(value: item, child: Text(item));
          }).toList(),

          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                itemName = newValue;
              });
            }
          },
        ),
      ],
    );
  }
}
