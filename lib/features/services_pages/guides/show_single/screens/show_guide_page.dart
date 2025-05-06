import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/features/services_pages/guides/main/models/get_centers_model.dart';
import 'package:alrefadah/features/services_pages/guides/main/models/get_guide_model.dart';
import 'package:alrefadah/features/services_pages/guides/show_single/widgets/show_guide_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowGuidePage extends StatelessWidget {
  const ShowGuidePage({required this.center, required this.employe, super.key});
  final GetGuidesCenterModel center;
  final GetGuidesModel employe;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '${center.fCenterName} - رقم ${center.fCenterNo}',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: kMainColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            height: 1.20.h,
          ),
        ),
      ),
      body: ShowGuideBody(employe: employe),
    );
  }
}
