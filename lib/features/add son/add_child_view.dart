import 'package:flutter/material.dart';
import 'package:moftahak/core/constants/app_gradients.dart';
import 'package:moftahak/core/constants/app_text_styles.dart';
import 'package:moftahak/core/widgets/corner_decoration.dart';
import 'package:moftahak/features/add%20son/widgets/custom_text_filed.dart';

class AddChildView extends StatelessWidget {
  const AddChildView({super.key});

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
                    CustomTextField(text: "الجنس"),
                    CustomTextField(text: "مكان الاقامة"),
                    CustomTextField(text: "وصف الحالة الصحية للطفل"),
                    CustomTextField(text: "اليد التي يستعملها الطفل في الرسم "),
                    SizedBox(height: 20),
                    Text("button", style: AppTextStyles.lato700style28),
                    Text("button cancel", style: AppTextStyles.lato700style28),
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
