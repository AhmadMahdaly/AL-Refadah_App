import 'package:alrefadah/core/widgets/custom_help_button.dart';
import 'package:alrefadah/core/widgets/leading_icon.dart';
import 'package:alrefadah/core/widgets/title_appbar.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/widgets/transfer_stage_body.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/widgets/transfer_stage_season_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// حصص مراحل النقل
class TransferStagePage extends StatelessWidget {
  const TransferStagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appBar(context), body: const TransferStageBody());
  }

  PreferredSizeWidget appBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 100.h,
      leading: const LeadingIcon(),
      title: const TitleAppBar(title: 'حصص مراحل النقل'),
      actions: const [
        /// Help button
        CustomHelpButton(),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(50.h),

        /// Season dropdown
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: const TransferStageSeasonDropdown(),
        ),
      ),
    );
  }
}
