import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/add/widgets/add_oprating_command_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddOpratingCommandsPage extends StatelessWidget {
  const AddOpratingCommandsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'إضافة أمر تشغيل',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: kMainColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            height: 1.20.h,
          ),
        ),
      ),
      body: const AddOpratingCommandBody(),
    );
  }
}
