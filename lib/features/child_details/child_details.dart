import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moftahak/features/child_details/cubit/child_details_cubit.dart';
import 'package:intl/intl.dart';

class ChildDetailsView extends StatelessWidget {
  const ChildDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تفاصيل الطفل")),
      body: BlocBuilder<ChildDetailsCubit, ChildDetailsState>(
        builder: (context, state) {
          if (state is ChildDetailsLoading || state is ChildDetailsInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ChildDetailsError) {
            return Center(child: Text(state.message));
          }

          if (state is! ChildDetailsLoaded) {
            return const SizedBox.shrink();
          }

          final child = state.child;

          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //   صورة الطفل
                CircleAvatar(
                  radius: 60,
                  backgroundImage: child.photoUrl.isNotEmpty
                      ? NetworkImage(child.photoUrl)
                      : null,
                  child: child.photoUrl.isEmpty
                      ? const Icon(Icons.person, size: 50)
                      : null,
                ),
                const SizedBox(height: 16),

                Text(
                  child.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),
                Text("الجنس: ${child.gender}"),
                Text("مكان الإقامة: ${child.location}"),
                Text("الحالة الصحية: ${child.healthStatus}"),
                Text("اليد المستخدمة بالرسم: ${child.drawingHand}"),
                Text(
                  "تاريخ الميلاد: ${DateFormat('yyyy-MM-dd').format(child.birthDate)}",
                ),
                Text(
                  "العمر: ${context.read<ChildDetailsCubit>().calculateAge(child.birthDate)} سنة",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
