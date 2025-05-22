import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/features/home_page/cubit/home_cubit.dart';
import 'package:alrefadah/features/home_page/cubit/home_states.dart';
import 'package:alrefadah/features/home_page/widgets/dashboard/analysis_buttons/custom_data_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CentersReportsWidget extends StatelessWidget {
  const CentersReportsWidget({required this.padding, super.key});
  final int padding;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: padding.w),
          child: Column(
            spacing: 12.h,
            children: [
              CustomContainer(
                text: 'إجمالي المراكز التي أكملت المرحلة',
                number: state.allData!.totalFinishedCenters ?? 0,
              ),
              CustomContainer(
                text: 'إجمالي المتبقي من الحجاج',
                number: state.allData!.totalRemainingCenterPilgrims ?? 0,
              ),
              H(h: 4.h),
            ],
          ),
        );
      },
    );
  }
}
