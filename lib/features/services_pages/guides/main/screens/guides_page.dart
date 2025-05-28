import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/widgets/custom_help_button.dart';
import 'package:alrefadah/core/widgets/leading_icon.dart';
import 'package:alrefadah/core/widgets/title_appbar.dart';
import 'package:alrefadah/features/services_pages/guides/add_emplyee/views/add_employee_page.dart';
import 'package:alrefadah/features/services_pages/guides/main/cubit/guides_cubit.dart';
import 'package:alrefadah/features/services_pages/guides/main/widgets/guides_body.dart';
import 'package:alrefadah/features/services_pages/guides/main/widgets/guides_season_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuidesPage extends StatefulWidget {
  const GuidesPage({super.key});

  @override
  State<GuidesPage> createState() => _GuidesPageState();
}

class _GuidesPageState extends State<GuidesPage> {
  @override
  void initState() {
    context
      ..read<GuidesCubit>().fetchCenters()
      ..read<GuidesCubit>().fetchSeasons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.h,
        surfaceTintColor: kScaffoldBackgroundColor,
        leading: const LeadingIcon(),
        title: const TitleAppBar(title: 'المرشدين'),
        actions: const [CustomHelpButton()],

        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12.h,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: const GuidesSeasonDropdown(),
              ),
            ],
          ),
        ),
      ),
      body: const GuidesBody(),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(320.r),
        ),
        backgroundColor: kMainColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEmployeePage()),
          );
        },
        child: const Icon(Icons.add, color: kMainColorLightColor),
      ),
    );
  }
}
