import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moftahak/core/constants/app_text_styles.dart';
import 'package:moftahak/core/widgets/children_dropdown.dart';

import '../../core/widgets/custem_elevatedButton_widgets.dart';
import '../ai_logic/display_image.dart';
import '../home/cubit/home_cubit.dart';

class DrawingScreen extends StatefulWidget {
  const DrawingScreen({super.key});

  @override
  State<DrawingScreen> createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  final ImagePicker _picker = ImagePicker();
  Uint8List? selectedImage;

  // دالة مسؤولة عن التقاط أو اختيار الصورة
  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? file = await _picker.pickImage(source: source);

      if (file == null) return;

      final bytes = await file.readAsBytes();

      setState(() {
        selectedImage = bytes;
      });

      // الانتقال لصفحة عرض الصورة
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DisplayImageScreen(imageBytes: selectedImage!),
        ),
      );
    } catch (e) {
      print("خطأ في اختيار الصورة: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('اختر فنان اليوم'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            // حالة التحميل / البداية
            if (state is HomeLoading || state is HomeInitial) {
              return const Center(child: CircularProgressIndicator());
            }

            // حالة الخطأ
            if (state is HomeError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              );
            }

            // حالة النجاح
            if (state is HomeSuccess) {
              final homeCubit = context.read<HomeCubit>();

              // نفترض أن الـ UserModel فيه حقل name
              final firstName = homeCubit.getFirstName(state.user.name);
              // اختيار اسم الطفل المحدد إن وجد
              String? selectedChildName;
              for (final child in state.children) {
                if (child.id == state.selectedChildId) {
                  selectedChildName = child.name;
                  break;
                }
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Center(
                      child: SizedBox(width: 100, child: ChildrenDropdown()),
                    ),
                    const SizedBox(height: 16),

                    // عرض اسم المستخدم
                    if (firstName.isNotEmpty)
                      Text(
                        'أهلًا، $firstName 👋',
                        style: AppTextStyles.almarai700style20,
                        textAlign: TextAlign.right,
                      ),

                    const SizedBox(height: 8),

                    // عرض اسم الطفل المختار إن وجد
                    if (selectedChildName != null)
                      Text(
                        'الفنان اليوم: $selectedChildName',
                        style: AppTextStyles.almarai700style20,

                        textAlign: TextAlign.right,
                      ),

                    const SizedBox(height: 50),

                    // أزرار اختيار الصورة
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustemElevatedbuttonWidgets(
                          onPressed: () => pickImage(ImageSource.gallery),
                          textButton: 'إرفاق صورة',
                          width: MediaQuery.of(context).size.width * 0.4,
                          icon: const Icon(Icons.upload, size: 22),
                        ),
                        CustemElevatedbuttonWidgets(
                          onPressed: () => pickImage(ImageSource.camera),
                          textButton: 'التقاط صورة',
                          icon: const Icon(Icons.camera_alt_outlined, size: 22),
                          width: MediaQuery.of(context).size.width * 0.4,
                        ),
                      ],
                    ),

                    const SizedBox(height: 60),
                    const Divider(
                      color: Colors.black,
                      height: 40,
                      thickness: 1,
                    ),
                    const SizedBox(height: 60),

                    // صندوق التعليمات
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: const Offset(0, 4),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'تأكد من الآتي قبل التقاط الصورة',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 20),
                            _buildInstruction('تأكد من وضوح التصوير'),
                            _buildInstruction('تأكد من عدم وجود ظلال'),
                            _buildInstruction(
                              'تأكد من ثبات الكاميرا عند التصوير',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            // حالة احتياطية
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildInstruction(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        '• $text',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w300,
          color: Colors.white,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }
}
