import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/features/home_page/cubit/home_cubit.dart';
import 'package:alrefadah/features/home_page/cubit/home_states.dart';
import 'package:alrefadah/features/home_page/widgets/dashboard/analysis_buttons/custom_data_container.dart';
import 'package:alrefadah/features/home_page/widgets/dashboard/buses_reports/buses_chart_analysis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BusesReportsWidget extends StatefulWidget {
  const BusesReportsWidget({required this.padding, super.key});

  final int padding;

  @override
  State<BusesReportsWidget> createState() => _BusesReportsWidgetState();
}

class _BusesReportsWidgetState extends State<BusesReportsWidget>
    with TickerProviderStateMixin {
  /// controller
  late TabController _tabController1;

  /// init data
  @override
  void initState() {
    super.initState();
    _tabController1 = TabController(length: 2, vsync: this);
  }

  /// dispose
  @override
  void dispose() {
    _tabController1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: widget.padding.w),
              alignment: Alignment.center,
              height: 60.h,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: kMainColorLightColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: TabBar(
                dividerHeight: 0,
                controller: _tabController1,
                labelStyle: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'GE SS Two',
                  color: kMainExtrimeLightColor,
                ),
                unselectedLabelColor: kMainColor,
                unselectedLabelStyle: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: 'GE SS Two',
                  fontWeight: FontWeight.w600,
                  color: kMainColor,
                ),

                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: kMainColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),

                /// Tabs
                tabs: const [Tab(text: 'تقرير رقمي'), Tab(text: 'تقرير بياني')],
              ),
            ),

            /// Tabs view
            SizedBox(
              height: 355.h,
              child: TabBarView(
                controller: _tabController1,
                children: [
                  /// تقرير رقمي
                  Column(
                    spacing: 12.w,
                    children: [
                      const H(h: 0),
                      Row(
                        spacing: 12.w,
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 95.h,
                              child: CustomContainer(
                                right: widget.padding,
                                text: 'إجمالي حافلات المرحلة',
                                number: state.allData!.totalStageBuses ?? 0,
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 95.h,
                              child: CustomContainer(
                                left: widget.padding,
                                text: 'إجمالي ردود المرحلة',

                                number: state.allData!.totalStageTrips ?? 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        spacing: 12.w,

                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 95.h,
                              child: CustomContainer(
                                right: widget.padding,
                                text: 'إجمالي الحافلات المطلقة',

                                number: state.allData!.totalDepartingBuses ?? 0,
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 95.h,
                              child: CustomContainer(
                                left: widget.padding,
                                text: 'إجمالي الردود',

                                number: state.allData!.totalTrips ?? 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 95.h,
                        child: CustomContainer(
                          left: widget.padding,
                          right: widget.padding,
                          text: 'إجمالي الحافلات التي أكملت الردود',

                          number: state.allData!.totalFinishedBuses ?? 0,
                        ),
                      ),
                    ],
                  ),

                  /// تقرير بياني
                  SizedBox(
                    height: 320.h,
                    child: BusesChartAnalysis(allData: state.allData!),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
