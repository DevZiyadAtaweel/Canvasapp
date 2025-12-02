import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moftahak/core/constants/navigation.dart';
import 'package:moftahak/features/home/cubit/home_cubit.dart';

class ChildrenDropdown extends StatelessWidget {
  const ChildrenDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        // لو لسه بتحميل أو initial ما نعرض إشي (عادي)
        if (state is HomeLoading || state is HomeInitial) {
          return const SizedBox.shrink();
        }

        if (state is HomeError) {
          return const SizedBox.shrink();
        }

        if (state is! HomeSuccess) {
          return const SizedBox.shrink();
        }

        final children = state.children;
        const addNewValue = '__add_child__';

        // نحدد القيمة اللي رح تظهر حاليًا في الـ Dropdown
        String? currentValue = state.selectedChildId;

        // لو ما في أطفال: القيمة الوحيدة = "إضافة ابن جديد"
        if (children.isEmpty) {
          currentValue = addNewValue;
        }

        // لو في أطفال بس selectedChildId لسه null → نخليها أول طفل
        if (children.isNotEmpty && currentValue == null) {
          currentValue = children.first.id;
        }

        // نضمن 100% إن القيمة ما هي null قبل ما نمررها
        currentValue ??= addNewValue;

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
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.centerRight,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: currentValue, // ✅ مضمونة مش null
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down),
              items: items,
              onChanged: (value) {
                if (value == null) return;

                if (value == addNewValue) {
                  // الذهاب لشاشة إضافة ابن جديد
                  customNavigatePush(context, '/addChild');
                } else {
                  // اختيار طفل معيّن
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
