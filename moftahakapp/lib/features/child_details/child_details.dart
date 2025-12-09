import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:moftahak/core/constants/app_text_styles.dart';
import 'package:moftahak/core/constants/navigation.dart';
import 'package:moftahak/core/widgets/custem_elevatedButton_widgets.dart';
import 'package:moftahak/features/child_details/cubit/child_details_cubit.dart';

class ChildDetailsView extends StatelessWidget {
  const ChildDetailsView({super.key});

  String _formatDate(DateTime date) {
    return DateFormat('yyyy/MM/dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    const themeColor = Color(0xFF8A3FFC);

    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text("تفاصيل الطفل", style: AppTextStyles.almarai700style20),
          leading: IconButton(
            onPressed: () => customNavigatePop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        body: BlocBuilder<ChildDetailsCubit, ChildDetailsState>(
          builder: (context, state) {
            if (state is ChildDetailsLoading || state is ChildDetailsInitial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ChildDetailsError) {
              return Center(
                child: Text(
                  state.message,
                  style: AppTextStyles.almarai700style20,
                ),
              );
            }

            if (state is! ChildDetailsLoaded) {
              return const SizedBox.shrink();
            }

            final child = state.child;
            final age = context.read<ChildDetailsCubit>().calculateAge(
              child.birthDate,
            );

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ===== صورة + اسم + عمر =====
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundColor: themeColor.withOpacity(0.1),
                        backgroundImage: child.photoUrl.isNotEmpty
                            ? NetworkImage(child.photoUrl)
                            : null,
                        child: child.photoUrl.isEmpty
                            ? const Icon(
                                Icons.child_care,
                                size: 40,
                                color: Colors.grey,
                              )
                            : null,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        child.name,
                        style: AppTextStyles.almarai700style20.copyWith(
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "العمر: $age سنة",
                        style: AppTextStyles.almarai700style20.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "تاريخ الميلاد: ${_formatDate(child.birthDate)}",
                        style: AppTextStyles.almarai700style20.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ===== البيانات الأساسية =====
                  _DetailsCard(
                    title: "البيانات الأساسية",
                    children: [
                      _InfoRow(
                        label: "الجنس",
                        value: child.gender, // عندك أصلاً "ذكر" / "أنثى"
                      ),
                      const SizedBox(height: 8),
                      _InfoRow(label: "مكان الإقامة", value: child.location),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // ===== اليد المستخدمة في الرسم =====
                  _DetailsCard(
                    title: "الرسم",
                    children: [
                      _InfoRow(
                        label: "اليد المستخدمة في الرسم",
                        value: child.drawingHand, // "اليمين" / "اليسار"
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // ===== وصف الحالة الصحية =====
                  _DetailsCard(
                    title: "وصف الحالة الصحية للطفل",
                    children: [
                      Text(
                        child.healthStatus.isEmpty
                            ? "لم يتم إدخال وصف للحالة الصحية بعد."
                            : child.healthStatus,
                        textAlign: TextAlign.right,
                        style: AppTextStyles.almarai700style20.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ===== زر عرض رسومات الطفل =====
                  CustemElevatedbuttonWidgets(
                    onPressed: () {
                      // TODO: عدّلي المسار حسب عندك
                      // مثال:
                      // customNavigatePush(context, '/childDrawings/${child.id}');
                    },
                    width: double.infinity,
                    textButton: "عرض رسومات الطفل",
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _DetailsCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _DetailsCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: AppTextStyles.almarai700style20.copyWith(fontSize: 16),
        ),
        const SizedBox(height: 8),
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: children,
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // القيمة
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.left,
            style: AppTextStyles.almarai700style20.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 5),
        // العنوان
        Text(
          label,
          style: AppTextStyles.almarai700style20.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
