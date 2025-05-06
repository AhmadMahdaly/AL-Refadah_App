import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/edit/widgets/edit_oprating_body.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/models/get_all_operatings_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditOpratingCommands extends StatelessWidget {
  const EditOpratingCommands({required this.data, super.key});
  final GetAllOperatingsModel data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'تعديل أمر التشغيل ${data.fOperatingNo}',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: kMainColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            height: 1.20.h,
          ),
        ),
      ),
      body: EditOpratingBody(data: data),
    );
  }
}
