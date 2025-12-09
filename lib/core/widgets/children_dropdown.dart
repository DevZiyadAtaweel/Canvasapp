import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:moftahak/core/constants/app_text_styles.dart';
import 'package:moftahak/core/constants/navigation.dart';
import 'package:moftahak/features/home/cubit/home_cubit.dart';

class ChildrenDropdown extends StatelessWidget {
  const ChildrenDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is! HomeSuccess) {
          return const SizedBox.shrink();
        }

        final children = state.children;
        final selectedChildId = state.selectedChildId;
        const addNewValue = '__add_child__';

        // نبني العناصر
        final items = <DropdownMenuItem<String>>[
          ...children.map(
            (child) => DropdownMenuItem<String>(
              value: child.id,
              child: Text(child.name, textDirection: TextDirection.rtl),
            ),
          ),
          const DropdownMenuItem<String>(
            value: addNewValue,
            child: Text(
              'إضافة ابن',
              style: TextStyle(fontWeight: FontWeight.bold),
              textDirection: TextDirection.rtl,
            ),
          ),
        ];

        // تأكد إن القيمة الحالية موجودة ضمن العناصر
        final String? currentValue =
            (selectedChildId != null &&
                children.any((c) => c.id == selectedChildId))
            ? selectedChildId
            : null;

        return Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.centerRight,
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              value: currentValue,
              isExpanded: true,

              // أيقونة السهم
              iconStyleData: const IconStyleData(
                icon: Icon(Icons.arrow_drop_down, color: Colors.black),
              ),

              // الهينت لما ما يكون في قيمة مختارة
              hint: Text(
                'الأبناء',
                textDirection: TextDirection.rtl,
                style: AppTextStyles.almarai700style20,
              ),

              items: items,

              onChanged: (value) {
                if (value == null) return;

                if (value == addNewValue) {
                  // فتح صفحة إضافة ابن جديد
                  customNavigatePush(context, '/addChild');
                } else {
                  // اختيار ابن
                  context.read<HomeCubit>().selectChild(value);
                }
              },

              // 👇 هنا نتحكم بمكان ظهور القائمة
              dropdownStyleData: DropdownStyleData(
                offset: const Offset(
                  0,
                  8,
                ), // زوّد القيمة (مثلاً 12 أو 16) عشان تنزل أكثر
                maxHeight: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
              ),

              menuItemStyleData: const MenuItemStyleData(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
          ),
        );
      },
    );
  }
}
