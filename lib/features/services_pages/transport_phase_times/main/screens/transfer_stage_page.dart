import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/widgets/transfer_stage_body.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/widgets/transfer_stage_season_dropdown.dart';
import 'package:alrefadah/presentation/app/shared_widgets/custom_help_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// حصص مراحل النقل
class TransferStagePage extends StatelessWidget {
  const TransferStagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: const TransferStageBody(),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: () => Navigator.pop(context),
      ),
      toolbarHeight: 100.h,
      title: Text(
        'حصص مراحل النقل',
        style: TextStyle(
          color: kMainColor,
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          height: 1.20.h,
        ),
      ),
      actions: const [CustomHelpButton()],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [TransferStageSeasonDropdown()],
          ),
        ),
      ),
    );
  }
}
