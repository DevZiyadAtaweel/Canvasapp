import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              'إضافة ابن جديد',
              style: TextStyle(fontWeight: FontWeight.bold),
              textDirection: TextDirection.rtl,
            ),
          ),
        ];

        return Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.centerRight,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              // 🔥 القيمة الحالية (إما null أو selectedChildId)
              value: selectedChildId,

              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down, color: Colors.black),

              // 🔥 الهينت يظهر فقط إذا القيمة null
              hint: Text(
                'الأبناء',
                textDirection: TextDirection.rtl,
                style: AppTextStyles.almarai700style20,
              ),

              items: items,
              onChanged: (value) {
                if (value == null) return;

                if (value == addNewValue) {
                  customNavigatePush(context, '/addChild');
                } else {
                  context.read<HomeCubit>().selectChild(value);
                }
              },
            ),
          ),
        );
      },
    );
  }
}
