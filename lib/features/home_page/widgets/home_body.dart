import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/features/home_page/cubit/home_cubit.dart';
import 'package:alrefadah/features/home_page/cubit/home_states.dart';
import 'package:alrefadah/features/home_page/widgets/dashboard/buses_reports/buses_reports_widget.dart';
import 'package:alrefadah/features/home_page/widgets/dashboard/centers_reports/centers_reports_widget.dart';
import 'package:alrefadah/features/home_page/widgets/dashboard/pilgrims_reports/pilgrims_reports_widget.dart';
import 'package:alrefadah/features/home_page/widgets/dashboard/trips_reports/trips_reports_widget.dart';
import 'package:alrefadah/features/home_page/widgets/dropdown_button/center_dropdown_button.dart';
import 'package:alrefadah/features/home_page/widgets/dropdown_button/session_dropdown_button.dart';
import 'package:alrefadah/features/home_page/widgets/dropdown_button/stage_dropdown_button.dart';
import 'package:alrefadah/features/home_page/widgets/head_text_title.dart';
import 'package:alrefadah/presentation/app/shared_widgets/no_data_widget.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    /// value of page padding
    const padding = 25;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.isLoadingAllData) {
          return const AppIndicator();
        } else if (state.allData != null) {
          return SingleChildScrollView(
            child: Column(
              spacing: 14.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Dropdowns
                /// season dropdown
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding.w),
                  child: const HomeSeasonDropdown(),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding.w),
                  child: Row(
                    spacing: 12.w,
                    children: const [
                      /// center dropdown
                      Expanded(child: GetCenterDropdown()),

                      /// stage dropdown
                      Expanded(child: GetStageDropdown()),
                    ],
                  ),
                ),
                const H(h: 4),

                /// Dashboard
                /// Buses reports
                const HeadTitle(title: 'تقارير الحافلات', padding: padding),
                const BusesReportsWidget(padding: padding),

                /// Pilgrims reports
                const HeadTitle(title: 'تقارير الحجاج', padding: padding),
                const PilgrimsReportsWidget(padding: padding),

                /// Centers reports
                const HeadTitle(title: 'تقارير المراكز', padding: padding),
                const CentersReportsWidget(padding: padding),

                /// Trips reports
                const HeadTitle(title: 'تقارير الرحلات', padding: padding),
                const TripsReportsWidget(padding: padding),
              ],
            ),
          );
        }
        return SizedBox(
          height: 355.h,
          child: NoDataWidget(
            onPressed:
                () => BlocProvider.of<HomeCubit>(context).getDashboardData(),
          ),
        );
      },
    );
  }
}
