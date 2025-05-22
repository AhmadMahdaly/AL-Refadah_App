import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/features/home_page/cubit/home_cubit.dart';
import 'package:alrefadah/features/home_page/cubit/home_states.dart';
import 'package:alrefadah/features/home_page/widgets/dashboard/analysis_buttons/custom_data_container.dart';
import 'package:alrefadah/features/home_page/widgets/dashboard/pilgrims_reports/pilgrims_chart_analysis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PilgrimsReportsWidget extends StatefulWidget {
  const PilgrimsReportsWidget({required this.padding, super.key});
  final int padding;
  @override
  State<PilgrimsReportsWidget> createState() => _PilgrimsReportsWidgetState();
}

class _PilgrimsReportsWidgetState extends State<PilgrimsReportsWidget>
    with TickerProviderStateMixin {
  /// controllers
  late TabController _tabController2;

  /// init data
  @override
  void initState() {
    super.initState();
    _tabController2 = TabController(length: 2, vsync: this);
  }

  /// dispose
  @override
  void dispose() {
    _tabController2.dispose();
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
                controller: _tabController2,
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
                tabs: const [Tab(text: 'تقرير رقمي'), Tab(text: 'تقرير بياني')],
              ),
            ),
            if (state.allData != null)
              SizedBox(
                height: 355.h,
                child: TabBarView(
                  controller: _tabController2,
                  children: [
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
                                  text: 'إجمالي عدد الحجاج',

                                  number: state.allData!.totalPilgrims ?? 0,
                                ),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 95.h,
                                child: CustomContainer(
                                  left: widget.padding,
                                  text: 'إجمالي حجاج المرحلة',
                                  number:
                                      state.allData!.totalStagePilgrims ?? 0,
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
                                  text: 'إجمالي الذين تم اخلاؤهم',
                                  number:
                                      state.allData!.totalEvacueesPilgrims ?? 0,
                                ),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 95.h,
                                child: CustomContainer(
                                  left: widget.padding,
                                  text: 'إجمالي الواصلين للمشعر',
                                  number:
                                      state.allData!.totalArrivedPilgrims ?? 0,
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
                            text: 'إجمالي الحجاج المتبقين',
                            number: state.allData!.totalRemainingPilgrims ?? 0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 320.h,
                      child: PilgrimsChartAnalysis(allData: state.allData!),
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
