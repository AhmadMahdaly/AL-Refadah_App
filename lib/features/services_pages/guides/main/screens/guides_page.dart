import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/features/services_pages/guides/main/cubit/guides_cubit.dart';
import 'package:alrefadah/features/services_pages/guides/main/widgets/guides_body.dart';
import 'package:alrefadah/features/services_pages/guides/main/widgets/guides_season_dropdown.dart';
import 'package:alrefadah/presentation/app/shared_widgets/custom_help_button.dart';
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
        surfaceTintColor: kScaffoldBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        toolbarHeight: 100.h,
        title: Text(
          'المرشدين',
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
    );
  }
}
