import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/features/home_page/cubit/date_and_time_cubit/date_cubit.dart';
import 'package:alrefadah/features/home_page/cubit/date_and_time_cubit/time_cubit.dart';
import 'package:alrefadah/features/home_page/cubit/home_cubit.dart';
import 'package:alrefadah/features/home_page/cubit/home_states.dart';
import 'package:alrefadah/features/home_page/widgets/analysis_buttons/custom_data_container.dart';
import 'package:alrefadah/features/home_page/widgets/analysis_circular_percent.dart';
import 'package:alrefadah/features/home_page/widgets/custom_dropdown_button/session_dropdown_button.dart';
import 'package:alrefadah/features/home_page/widgets/custom_dropdown_button/stage_dropdown_button.dart';
import 'package:alrefadah/features/home_page/widgets/date_and_time.dart';
import 'package:alrefadah/features/home_page/widgets/head_text_title.dart';
import 'package:alrefadah/features/home_page/widgets/welcome_to_user.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/widgets/dropdowns/centers_dropdown.dart';
import 'package:alrefadah/presentation/app/shared_widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController1;
  late TabController _tabController2;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCubit>(context).getDashboardData();
    _tabController1 = TabController(length: 2, vsync: this);
    _tabController2 = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController1.dispose();
    _tabController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TimeCubit>(create: (context) => TimeCubit()),
        BlocProvider<DateCubit>(create: (context) => DateCubit()),
      ],
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return RefreshIndicator(
            strokeWidth: 0.9,
            color: kMainColor,
            onRefresh:
                () => BlocProvider.of<HomeCubit>(context).getDashboardData(),
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: 40.h,
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 14.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const WelcomeToUser(),
                      const DateAndTime(),
                      const H(h: 2),
                      const HomeSeasonDropdown(),
                      Row(
                        spacing: 12.w,
                        children: const [
                          Expanded(child: GetBusTravelCentersDropdown()),
                          Expanded(child: GetStageDropdown()),
                        ],
                      ),
                      const H(h: 4),

                      const HeadTitle(title: 'تقارير الحافلات'),
                      Column(
                        children: [
                          Container(
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

                              tabs: const [
                                Tab(text: 'تقرير رقمي'),
                                Tab(text: 'تقرير بياني'),
                              ],
                            ),
                          ),
                          if (state.isLoadingAllData)
                            SizedBox(height: 360.h, child: const AppIndicator())
                          else
                            state.allData != null
                                ? SizedBox(
                                  height: 355.h,
                                  child: TabBarView(
                                    controller: _tabController1,
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
                                                  height: 90,
                                                  child: CustomContainer(
                                                    text:
                                                        'إجمالي حافلات المرحلة',
                                                    number:
                                                        state
                                                            .allData!
                                                            .totalStageBuses,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: SizedBox(
                                                  height: 90,
                                                  child: CustomContainer(
                                                    text: 'إجمالي ردود المرحلة',

                                                    number:
                                                        state
                                                            .allData!
                                                            .totalStageTrips,
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
                                                  height: 90,
                                                  child: CustomContainer(
                                                    text:
                                                        'إجمالي الحافلات المطلقة',

                                                    number:
                                                        state
                                                            .allData!
                                                            .totalDepartingBuses,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: SizedBox(
                                                  height: 90,
                                                  child: CustomContainer(
                                                    text: 'إجمالي الردود',

                                                    number:
                                                        state
                                                            .allData!
                                                            .totalTrips,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 90,
                                            child: CustomContainer(
                                              text:
                                                  'إجمالي الحافلات التي أكملت الردود',

                                              number:
                                                  state
                                                      .allData!
                                                      .totalFinishedBuses,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 320,
                                        child: TripsChartExample(
                                          allData: state.allData!,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                : SizedBox(
                                  height: 355.h,
                                  child: NoDataWidget(
                                    onPressed:
                                        () =>
                                            BlocProvider.of<HomeCubit>(
                                              context,
                                            ).getDashboardData(),
                                  ),
                                ),
                        ],
                      ),

                      const HeadTitle(title: 'تقارير الحجاج'),

                      Column(
                        children: [
                          Container(
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

                              tabs: const [
                                Tab(text: 'تقرير رقمي'),
                                Tab(text: 'تقرير بياني'),
                              ],
                            ),
                          ),
                          if (state.isLoadingAllData)
                            SizedBox(height: 360.h, child: const AppIndicator())
                          else
                            state.allData != null
                                ? SizedBox(
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
                                                  height: 90,
                                                  child: CustomContainer(
                                                    text: 'إجمالي عدد الحجاج',

                                                    number:
                                                        state
                                                            .allData!
                                                            .totalPilgrims,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: SizedBox(
                                                  height: 90,
                                                  child: CustomContainer(
                                                    text: 'إجمالي حجاج المرحلة',

                                                    number:
                                                        state
                                                            .allData!
                                                            .totalStagePilgrims,
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
                                                  height: 90,
                                                  child: CustomContainer(
                                                    text:
                                                        'إجمالي الذين تم اخلاؤهم',

                                                    number:
                                                        state
                                                            .allData!
                                                            .totalEvacueesPilgrims,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: SizedBox(
                                                  height: 90,
                                                  child: CustomContainer(
                                                    text:
                                                        'إجمالي الواصلين للمشعر',

                                                    number:
                                                        state
                                                            .allData!
                                                            .totalArrivedPilgrims,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 90,
                                            child: CustomContainer(
                                              text: 'إجمالي الحجاج المتبقين',

                                              number:
                                                  state
                                                      .allData!
                                                      .totalRemainingPilgrims,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 320,
                                        child: PilgrimsChartAnalysis(
                                          allData: state.allData!,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                : SizedBox(
                                  height: 355.h,
                                  child: NoDataWidget(
                                    onPressed:
                                        () =>
                                            BlocProvider.of<HomeCubit>(
                                              context,
                                            ).getDashboardData(),
                                  ),
                                ),
                        ],
                      ),

                      const HeadTitle(title: 'تقارير المراكز'),
                      const H(h: 4),
                      if (state.isLoadingAllData)
                        SizedBox(height: 360.h, child: const AppIndicator())
                      else
                        state.allData != null
                            ? Column(
                              spacing: 12.h,
                              children: [
                                CustomContainer(
                                  text: 'إجمالي المراكز التي أكملت المرحلة',
                                  number: state.allData!.totalFinishedCenters,
                                ),
                                CustomContainer(
                                  text: 'إجمالي المتبقي من الحجاج',
                                  number:
                                      state
                                          .allData!
                                          .totalRemainingCenterPilgrims,
                                ),
                                H(h: 16.h),
                              ],
                            )
                            : NoDataWidget(
                              onPressed:
                                  () =>
                                      BlocProvider.of<HomeCubit>(
                                        context,
                                      ).getDashboardData(),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
