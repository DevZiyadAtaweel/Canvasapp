import 'package:flutter/material.dart';
import 'package:moftahak/core/constants/app_gradients.dart';
import 'package:moftahak/core/constants/app_text_styles.dart';
import 'package:moftahak/core/constants/navigation.dart';
import 'package:moftahak/core/widgets/corner_decoration.dart';
import 'package:moftahak/core/widgets/custem_elevatedButton_widgets.dart';
import 'package:moftahak/features/add%20son/widgets/custom_drop_down_text_filed.dart';
import 'package:moftahak/features/add%20son/widgets/custom_text_filed.dart';

class AddChildView extends StatefulWidget {
  const AddChildView({super.key});

  @override
  State<AddChildView> createState() => _AddChildViewState();
}

class _AddChildViewState extends State<AddChildView> {
  String? selectedGender;
  String? selectedCity;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,

            toolbarHeight: 100,
            title: Text("اضافة ابن جديد", style: AppTextStyles.lato700style28),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          extendBodyBehindAppBar: true,
          body: Container(
            width: double.infinity,

            decoration: BoxDecoration(gradient: AppGradients.mainGradient),

            child: Stack(
              children: [
                CornerDecoration(),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: kToolbarHeight + 20),

                    CustomTextField(text: "الاسم"),
                    CustomTextField(text: "تاريخ الميلاد"),
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
                    CustomTextField(text: "وصف الحالة الصحية للطفل"),
                    CustomTextField(text: "اليد التي يستعملها الطفل في الرسم "),
                    SizedBox(height: 20),
                    CustemElevatedbuttonWidgets(
                      onPressed: () {},
                      width: 200,
                      textButton: 'اضافة الابن',
                    ),
                    ElevatedButton(
                      onPressed: () {
                        customNavigatePop(context);
                      },
                      child: Text("رجوع"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
