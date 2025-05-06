import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/models/get_all_operatings_model.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/show/widgets/show_oprating_commands_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowOpratingCommandsPage extends StatelessWidget {
  const ShowOpratingCommandsPage({required this.data, super.key});
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
          'أمر تشغيل ${data.fOperatingNo}',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: kMainColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            height: 1.20.h,
          ),
        ),
      ),
      body: ShowOpratingCommandsBody(data: data),
    );
  }
}
