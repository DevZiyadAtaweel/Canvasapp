import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:moftahak/core/constants/app_gradients.dart';
import 'package:moftahak/core/constants/app_text_styles.dart';
import 'package:moftahak/core/constants/navigation.dart';
import 'package:moftahak/core/widgets/corner_decoration.dart';
import 'package:moftahak/core/widgets/custem_elevatedButton_widgets.dart';
import 'package:moftahak/features/add%20child/cubit/add_child_cubit.dart';
import 'package:moftahak/features/add%20child/widgets/add_date.dart';
import 'package:moftahak/features/add%20child/widgets/custom_drop_down_text_filed.dart';
import 'package:moftahak/features/add%20child/widgets/custom_text_filed.dart';

class AddChildView extends StatefulWidget {
  const AddChildView({super.key});

  @override
  State<AddChildView> createState() => _AddChildViewState();
}

class _AddChildViewState extends State<AddChildView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _healthDescController = TextEditingController();

  String? selectedGender;
  String? selectedCity;
  String? selectedHand;
  DateTime? selectedBirthDate;

  File? childImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    ); // أو camera

    if (pickedFile != null) {
      setState(() {
        childImage = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _healthDescController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddChildCubit, AddChildState>(
      listener: (context, state) {
        if (state is AddChildSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("تم إضافة الإبن بنجاح")));
          // نرجع للهوم، و HomeCubit رح يلتقط الطفل الجديد تلقائيًا
          customNavigatePop(context);
        }

        if (state is AddChildFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          bottom: true,
          top: false,
          child: Scaffold(
            body: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(gradient: AppGradients.mainGradient),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    CornerDecoration(),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 40),
                          Text(
                            "اضافة ابن جديد",
                            style: AppTextStyles.lato700style28,
                          ),
                          SizedBox(height: 20),
                          // ===== صورة الطفل =====
                          InkWell(
                            onTap: _pickImage,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 55,
                                  backgroundColor: Colors.white,
                                  child: childImage == null
                                      ? const Icon(
                                          Icons.camera_alt,
                                          size: 40,
                                          color: Colors.grey,
                                        )
                                      : ClipOval(
                                          child: Image.file(
                                            childImage!,
                                            width: 110,
                                            height: 110,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "أضف صورة شخصية للطفل",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // ===== الحقول =====
                          CustomTextField(
                            text: "الاسم",
                            controller: _nameController,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "الرجاء إدخال الاسم";
                              }
                              return null;
                            },
                          ),
                          CustomDatePickerField(
                            label: "تاريخ الميلاد",
                            onDateSelected: (date) {
                              print("Selected DOB: $date");
                              selectedBirthDate = date;

                              // احفظي التاريخ إذا بدك
                            },
                          ),
                          CustomDropdownField<String>(
                            label: "الجنس",
                            value: selectedGender,
                            items: const ["ذكر", "أنثى"],
                            onChanged: (val) {
                              setState(() {
                                selectedGender = val;
                              });
                            },
                          ),
                          CustomDropdownField<String>(
                            label: "مكان الاقامة",
                            value: selectedCity,
                            items: const ["الرياض", "جدة", "الدمام", "غير ذلك"],
                            onChanged: (val) {
                              setState(() {
                                selectedCity = val;
                              });
                            },
                          ),
                          CustomTextField(
                            text: "وصف الحالة الصحية للطفل",
                            controller: _healthDescController,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "الرجاء إدخال وصف الحالة الصحية";
                              }
                              return null;
                            },
                          ),
                          CustomDropdownField<String>(
                            label: "اليد التي يستعملها الطفل في الرسم ",
                            value: selectedHand,
                            items: const ["اليمين", "اليسار"],
                            onChanged: (val) {
                              setState(() {
                                selectedHand = val;
                              });
                            },
                          ),

                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BlocBuilder<AddChildCubit, AddChildState>(
                                builder: (context, state) {
                                  final isLoading = state is AddChildLoading;

                                  return CustemElevatedbuttonWidgets(
                                    onPressed: isLoading
                                        ? null
                                        : () {
                                            if (!_formKey.currentState!
                                                .validate()) {
                                              return;
                                            }

                                            if (selectedBirthDate == null) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    "الرجاء اختيار تاريخ الميلاد",
                                                  ),
                                                ),
                                              );
                                              return;
                                            }

                                            if (selectedGender == null ||
                                                selectedCity == null ||
                                                selectedHand == null) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    "الرجاء تعبئة كل الحقول المطلوبة",
                                                  ),
                                                ),
                                              );
                                              return;
                                            }

                                            context
                                                .read<AddChildCubit>()
                                                .addChild(
                                                  name: _nameController.text
                                                      .trim(),
                                                  birthDate: selectedBirthDate!,
                                                  gender: selectedGender!,
                                                  location: selectedCity!,
                                                  healthStatus:
                                                      _healthDescController.text
                                                          .trim(),
                                                  drawingHand: selectedHand!,
                                                  photoFile:
                                                      childImage, // 👈 هون
                                                );
                                          },
                                    width: 150,
                                    textButton: isLoading
                                        ? 'جارِ الحفظ...'
                                        : 'اضافة الابن',
                                  );
                                },
                              ),

                              SizedBox(width: 20),
                              SizedBox(
                                width: 150,
                                height: 55,
                                child: OutlinedButton(
                                  onPressed: () => customNavigatePop(context),
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    "إلغاء",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
