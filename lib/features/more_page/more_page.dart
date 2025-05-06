import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/features/more_page/widgets/more_page_body.dart';
import 'package:alrefadah/features/more_page/widgets/user_name_and_number_and_log_out_button_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        flexibleSpace: Image.asset(
          'assets/images/Frame 427319836.png',
          color: kMainColor.withAlpha(1),
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        toolbarHeight: 90.h,
        title: const UserNameAndNumberAndLogOutButtonHeader(),
      ),
      body: const MorePageBody(),
    );
  }
}
