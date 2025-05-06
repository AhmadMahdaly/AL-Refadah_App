import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/features/services_pages/transport_stage/cubit/stage_cubit.dart';
import 'package:alrefadah/features/services_pages/transport_stage/repo/stage_repo.dart';
import 'package:alrefadah/features/services_pages/transport_stage/widgets/stage_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StagePage extends StatelessWidget {
  const StagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StageCubit>(
      create: (context) => StageCubit(StageRepo()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'مراحل النقل',
            style: TextStyle(
              color: kMainColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              height: 1.20.h,
            ),
          ),
        ),
        body: const StageBody(),
      ),
    );
  }
}
