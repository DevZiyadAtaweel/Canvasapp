import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moftahak/features/home/cubit/home_cubit.dart';
import 'package:moftahak/features/child analysis/cubit/all_drawings_cubit.dart';

class ChildAnalysisScreen extends StatefulWidget {
  const ChildAnalysisScreen({super.key});

  @override
  State<ChildAnalysisScreen> createState() => _ChildAnalysisScreenState();
}

class _ChildAnalysisScreenState extends State<ChildAnalysisScreen> {
  String? _lastLoadedChildId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final homeState = context.read<HomeCubit>().state;

    if (homeState is HomeSuccess && homeState.selectedChildId != null) {
      final currentChildId = homeState.selectedChildId!;

      // عشان ما نعيد التحميل بدون داعي
      if (_lastLoadedChildId != currentChildId) {
        _lastLoadedChildId = currentChildId;
        context.read<AllDrawingsCubit>().loadChildDrawings(currentChildId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تحليلات الرسومات'),
          centerTitle: true,
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, homeState) {
            // لو ما في طفل مختار
            if (homeState is! HomeSuccess ||
                homeState.selectedChildId == null) {
              return const Center(
                child: Text('الرجاء اختيار طفل من الصفحة الرئيسية أولاً'),
              );
            }

            // نحاول نجيب بيانات الطفل بس عشان الاسم في العنوان
            final selectedChild = homeState.children.firstWhere(
              (c) => c.id == homeState.selectedChildId,
              orElse: () => homeState.children.first,
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // عنوان باسم الطفل
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'تحليلات رسومات: ${selectedChild.name}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Expanded(
                  child: BlocBuilder<AllDrawingsCubit, AllDrawingsState>(
                    builder: (context, state) {
                      if (state is AllDrawingsLoading ||
                          state is AllDrawingsInitial) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is AllDrawingsError) {
                        return Center(child: Text(state.message));
                      }

                      if (state is AllDrawingsLoaded) {
                        if (state.drawings.isEmpty) {
                          return const Center(
                            child: Text(
                              'لا توجد رسومات محلَّلة لهذا الطفل بعد.',
                            ),
                          );
                        }

                        return ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: state.drawings.length,
                          itemBuilder: (context, index) {
                            final drawing = state.drawings[index];

                            return Card(
                              margin: const EdgeInsets.only(bottom: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        drawing.drawingUrl,
                                        height: 180,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'حالة التحليل: ${drawing.analysisStatus}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'التقييم الأولي:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(drawing.emotion ?? 'غير متوفر'),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'تقرير مفصّل:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      drawing.description ?? 'غير متوفر',
                                      style: const TextStyle(height: 1.4),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
