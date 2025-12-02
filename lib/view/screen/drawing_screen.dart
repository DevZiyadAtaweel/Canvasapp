import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/constants/app_colors.dart';
import '../../core/widgets/custem_elevatedButton_widgets.dart';
import '../../features/home/home_screen.dart';
import '../widgets/name_drawer_widgets.dart';
import 'analysi_imageby_ai_screen.dart' as picker;
import 'display_image.dart';

class DrawingScreen extends StatefulWidget {
  const DrawingScreen({super.key});

  @override
  State<DrawingScreen> createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  // --- منطق التقاط الصور (Image Picker Logic) ---
  List<XFile>? _mediaFileList;
  final ImagePicker _picker = ImagePicker();
  dynamic _pickImageError;

  Uint8List? selectedImage;



  // لتعيين ملف الصورة المختارة (تم الإبقاء عليها لأغراض التنظيف)
  void _setImageFileListFromFile(XFile? value) {
    _mediaFileList = value == null ? null : <XFile>[value];
  }
  Future<Uint8List?> pickImage() async {
    final picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);

    if (file == null) return null;
    return await file.readAsBytes();
  }
  // دالة التقاط الصورة/اختيارها من المعرض
  Future<void> _onImageButtonPressed(ImageSource source) async {
    try {
      final XFile? file =
      (await picker.pickImage(source: ImageSource.gallery)) as XFile?;

        if(file==null)
          return;

      final bytes = await file.readAsBytes();

      setState(() {
        selectedImage= bytes;
      });
      // // *** التعديل الرئيسي: التوجيه إلى الشاشة الجديدة ShowImageScreen ***
      // if (pickedFile != null) {
      //   // إذا تم التقاط أو اختيار الصورة بنجاح:
        await Navigator.push(
          context,
          MaterialPageRoute(
            // التوجيه إلى شاشة العرض الجديدة مع تمرير ملف الصورة الملتقطة
            builder: (context) => DisplayImageScreen(imageBytes: selectedImage!,),
          ),
        );
      //
      //   // *اختياري*: عند العودة من شاشة المعاينة (بالضغط على زر الرجوع أو الإلغاء)،
      //   // نقوم بمسح الصورة من حالة هذه الشاشة.
      //   setState(() {
      //     _mediaFileList = null;
      //     _pickImageError = null;
      //   });
      // } else {
      //   // إذا قام المستخدم بالإلغاء، نمسح أي حالة خطأ سابقة.
      //   setState(() {
      //     _pickImageError = null;
      //   });
      // }
      // *** نهاية التعديل ***
    } catch (e) {
      // التعامل مع أخطاء الالتقاط
      setState(() {
        _pickImageError = e;
        _mediaFileList = null; // مسح الصورة في حالة الخطأ
      });
    }
  }

  // ويدجيت لعرض الصورة المختارة (سيعرض الآن حالة البداية أو الخطأ فقط)
  Widget _imagePreview() {
    if (_mediaFileList != null && _mediaFileList!.isNotEmpty) {
      // هذه الحالة لن تتحقق عادةً بعد التعديل، لأننا ننتقل لشاشة أخرى
      return Image.file(
        File(_mediaFileList!.first.path),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Center(child: Text('نوع الصورة غير مدعوم'));
        },
      );
    } else if (_pickImageError != null) {
      // إذا حدث خطأ أثناء الالتقاط
      return Center(
        child: Text(
          'خطأ في التقاط الصورة: $_pickImageError',
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.red),
        ),
      );
    } else {
      // في حالة عدم اختيار أي صورة بعد
      return const Center(
        child: Text(
          'لم يتم اختيار أو التقاط أي صورة.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70),
        ),
      );
    }
  }

  // ---------------------------------------------------

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backGroundColor,
        title: const Text(
          'اختر فنان اليوم',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
          icon: const Icon(Icons.arrow_back_outlined, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const NameDrawerWidgets(),
              const SizedBox(height: 50),

              // --- صف الأزرار ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // زر إرفاق صورة (المعرض)
                  CustemElevatedbuttonWidgets(
                    onPressed: () async {
                      final bytes = await pickImage();
                      if (bytes == null) return;

                      setState(() {
                        selectedImage = bytes;
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DisplayImageScreen(
                            imageBytes: selectedImage!,
                          ),
                        ),
                      );
                      //_onImageButtoknPressed(ImageSource.gallery);
                    },
                    textButton: 'ارفاق صورة',
                    width: 200,
                    icon: const Icon(Icons.upload, size: 22),
                  ),
                  // زر التقاط صورة (الكاميرا)
                  CustemElevatedbuttonWidgets(
                    onPressed: () {
                      _onImageButtonPressed(ImageSource.camera);
                    },
                    textButton: 'التقاط صورة',
                    icon: const Icon(Icons.camera_alt_outlined, size: 22),
                    width: 200,
                  ),
                ],
              ),
              const SizedBox(height: 60),

              const Divider(
                color: Colors.black,
                height: 40,
                thickness: 1,
                indent: 1,
                endIndent: 1,
              ),

              const SizedBox(height: 60),

              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(0, 4),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 18,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'تاكد من الاتي قبل التقاط الصورة',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              _buildInstructionText('تأكد من وضوح التصوير'),
                              _buildInstructionText('تأكد من عدم وجود ظلال'),
                              _buildInstructionText(
                                'تأكد من ثبات الكاميرا عند التصوير',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // --- تعليمات إضافية ---
            ],
          ),
        ),
      ),
    );
  }

  // ويدجيت مساعد لتنسيق نصوص التعليمات
  Widget _buildInstructionText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        '$text   \u2022',
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
