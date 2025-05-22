import 'package:alrefadah/core/widgets/custom_help_button.dart';
import 'package:alrefadah/core/widgets/leading_icon.dart';
import 'package:alrefadah/core/widgets/title_appbar.dart';
import 'package:alrefadah/features/services_pages/complaint/show_all/widgets/all_complaint_body.dart';
import 'package:alrefadah/features/services_pages/complaint/show_all/widgets/center_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllComplaintPage extends StatelessWidget {
  const AllComplaintPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const LeadingIcon(),
        title: const TitleAppBar(title: 'البلاغات'),
        actions: const [
          /// Help button
          CustomHelpButton(),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Season dropdown
                ComplaintTravelCentersDropdown(),
              ],
            ),
          ),
        ),
      ),

      body: const AllComplaintBody(),
    );
  }
}
