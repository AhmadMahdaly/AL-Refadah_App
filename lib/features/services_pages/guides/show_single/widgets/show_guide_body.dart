import 'package:alrefadah/features/services_pages/guides/main/models/get_guide_model.dart';
import 'package:alrefadah/features/services_pages/guides/show_single/widgets/guide_single_data_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowGuideBody extends StatelessWidget {
  const ShowGuideBody({required this.employe, super.key});

  final GetGuidesModel employe;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.h,
      children: [
        GuideSingleDataCard(
          title: 'رقم المرشد',
          info: employe.empNo.toString(),
        ),
        GuideSingleDataCard(title: 'اسم المرشد', info: employe.empName),
        // GuideSingleDataCard(
        //   title: 'الجنسية',
        //   info: employe.natiNo == 1 ? 'السعودية' : '',
        // ),
        GuideSingleDataCard(title: 'رقم الهوية', info: employe.idNo.toString()),
        GuideSingleDataCard(title: 'رقم الجوال', info: employe.jawNo),
        GuideSingleDataCard(title: 'البريد الإلكتروني', info: employe.email),
      ],
    );
  }
}
