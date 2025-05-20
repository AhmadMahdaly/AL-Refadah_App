import 'package:alrefadah/core/services/permissions_manager.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  /// init data
  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  /// get permissions
  Future<void> _checkPermissions() async {
    fPermNo = context.read<HomeCubit>().fPermNo;
  }

  int? fPermNo = 0;

  /// value of page padding
  final int padding = 25;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.isLoadingAllData) {
          return const AppIndicator();
        } else if (state.allData != null) {
          return SingleChildScrollView(
            child:
                fPermNo == PermNo.transMan ||
                        fPermNo == PermNo.systemMan ||
                        fPermNo == PermNo.centerMember
                    ? Column(
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
                        HeadTitle(title: 'تقارير الحافلات', padding: padding),
                        BusesReportsWidget(padding: padding),

                        /// Pilgrims reports
                        HeadTitle(title: 'تقارير الحجاج', padding: padding),
                        PilgrimsReportsWidget(padding: padding),

                        /// Centers reports
                        HeadTitle(title: 'تقارير المراكز', padding: padding),
                        CentersReportsWidget(padding: padding),

                        /// Trips reports
                        HeadTitle(title: 'تقارير الرحلات', padding: padding),
                        TripsReportsWidget(padding: padding),
                      ],
                    )
                    : Center(
                      child: Column(
                        children: [
                          H(h: MediaQuery.of(context).size.height / 2 - 250),
                          Image.asset(
                            'assets/images/logo.png',
                            color: kMainColor.withAlpha(50),

                            height: 150.w,
                            fit: BoxFit.contain,
                          ),
                          const H(h: 8),
                          Image.asset(
                            'assets/images/text logo.png',
                            color: kMainColor.withAlpha(50),

                            width: 180.w,
                            height: 80.h,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
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
