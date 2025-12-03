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

        // نبني العناصر اللي داخل القائمة
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
            color: Colors.transparent, // غيّرها للّون اللي بدك إياه
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.centerRight,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              // 👈 نخلي القيمة دايمًا null عشان يظهر الـ hint
              value: null,
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
              // النص اللي يظهر دائمًا فوق:
              hint: const Text(
                'الأبناء',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              items: items,
              onChanged: (value) {
                if (value == null) return;

                if (value == addNewValue) {
                  // الذهاب لشاشة إضافة ابن جديد
                  customNavigatePush(context, '/addChild');
                } else {
                  // اختيار طفل معيّن (للاستخدام داخل الكيوبت)
                  context.read<HomeCubit>().selectChild(context, value);
                }
              },
            ),
          ),
        );
      },
    );
  }
}
