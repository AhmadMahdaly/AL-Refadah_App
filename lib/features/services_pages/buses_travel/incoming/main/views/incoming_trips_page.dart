import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/custom_search_bar.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/widgets/custom_download_button.dart';
import 'package:alrefadah/core/widgets/custom_help_button.dart';
import 'package:alrefadah/core/widgets/leading_icon.dart';
import 'package:alrefadah/core/widgets/title_appbar.dart';
import 'package:alrefadah/features/services_pages/buses_travel/incoming/main/widgets/tabs/incoming_trips_buses_tab.dart';
import 'package:alrefadah/features/services_pages/buses_travel/incoming/main/widgets/tabs/incoming_trips_pilgrims_tab.dart';
import 'package:alrefadah/features/services_pages/buses_travel/incoming/main/widgets/tabs/incoming_trips_trips_tab.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_cubit.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_state.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/widgets/buses_moves_head_title.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/widgets/dropdowns/centers_dropdown.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/widgets/dropdowns/seasons_dropdown.dart';
import 'package:alrefadah/presentation/app/shared_widgets/no_data_widget.dart';

class IncomingTripsPage extends StatefulWidget {
  const IncomingTripsPage({super.key});

  @override
  State<IncomingTripsPage> createState() => _IncomingTripsPageState();
}

class _IncomingTripsPageState extends State<IncomingTripsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  String searchText = '';

  @override
  void initState() {
    super.initState();
    _initTabController();
    _initSearchListener();
    context.read<BusTravelCubit>().getTrips();
  }

  void _initTabController() {
    _tabController = TabController(length: 3, vsync: this);
  }

  void _initSearchListener() {
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), _updateSearchText);
  }

  void _updateSearchText() {
    if (mounted) {
      setState(() {
        searchText = _searchController.text.toLowerCase();
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: const Duration(milliseconds: 300),
      length: 3,
      child: Scaffold(appBar: _appBar(context), body: _buildBody()),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 120.h,
      leading: const LeadingIcon(),
      title: const TitleAppBar(title: 'الحافلات القادمة'),
      actions: const [CustomHelpButton()],

      bottom: PreferredSize(
        preferredSize: Size.fromHeight(140.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  const Expanded(child: GetBusTravelSeasonDropdown()),
                  W(w: 10.w),
                  const Expanded(child: GetBusTravelCentersDropdown()),
                ],
              ),
            ),

            /// search bar
            SizedBox(
              height: 46,
              child: Row(
                spacing: 12.w,
                children: [
                  W(w: 4.w),
                  Expanded(
                    child: CustomSearchBar(
                      controller: _searchController,
                      clearIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => searchText = '');
                        },
                      ),
                    ),
                  ),

                  /// Download button
                  const CustomDownloadButton(),
                  W(w: 4.w),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: const ShapeDecoration(
                  color: Color(0xFFF5F5F5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                ),
                child: SizedBox(
                  height: 34.h,
                  child: TabBar(
                    automaticIndicatorColorAdjustment: false,
                    dividerHeight: 0,
                    indicatorColor: kMainColor,
                    labelColor: kMainColor,
                    unselectedLabelColor: kTextColor,
                    labelStyle: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'GE SS Two',
                      fontWeight: FontWeight.w700,
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'GE SS Two',
                      fontWeight: FontWeight.w500,
                    ),
                    indicatorAnimation: TabIndicatorAnimation.elastic,
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(width: 4.w, color: kMainColor),
                      insets: EdgeInsets.symmetric(horizontal: 16.w),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabAlignment: TabAlignment.fill,
                    controller: _tabController,
                    tabs: const [
                      Tab(child: Text('عدد الحجاج')),
                      Tab(child: Text('عدد الحافلات')),
                      Tab(child: Text('عدد الردود')),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      automaticallyImplyLeading: false,
    );
  }

  Widget _buildBody() {
    return Stack(
      fit: StackFit.loose,
      children: [
        TabBarView(
          controller: _tabController,
          children: [
            /// Pilgrims tab
            Tab(
              child: BlocBuilder<BusTravelCubit, BusesTravelState>(
                builder: (context, state) {
                  if (state.isLoadingSeasons ||
                      state.isLoadingCenters ||
                      state.isLoadingTrips) {
                    return const AppIndicator();
                  } else if (state.trips != null) {
                    final trips = state.trips;

                    final filteredTrips =
                        (searchText.isEmpty
                                ? trips
                                : trips.where((trip) {
                                  final fStageNo = trip.fStageNo.toLowerCase();
                                  return fStageNo.contains(searchText);
                                }))
                            .toList();

                    final uniqueFilteredTrips =
                        {
                          for (final trip in filteredTrips) trip.fStageNo: trip,
                        }.values.toList();
                    return ListView.builder(
                      padding: EdgeInsets.only(
                        right: 16.w,
                        left: 16.w,
                        bottom: 16.h,
                        top: 85.h,
                      ),
                      itemCount: uniqueFilteredTrips.length,
                      itemBuilder: (context, index) {
                        final trip = uniqueFilteredTrips[index];
                        final allocatedPilgrimsCount = int.tryParse(
                          trip.allocatedPilgrimsCount,
                        );
                        final totalPilgrimsCount = int.tryParse(
                          trip.totalPilgrimsCount,
                        );
                        final remainingPilgrimsCount =
                            allocatedPilgrimsCount! - totalPilgrimsCount!;
                        return IncomingTripsPilgrimsTab(
                          trip: trip,
                          remainingPilgrimsCount: remainingPilgrimsCount,
                        );
                      },
                    );
                  }
                  return NoDataWidget(
                    onPressed: () {
                      BlocProvider.of<BusTravelCubit>(context).getTrips();
                    },
                  );
                },
              ),
            ),

            /// Buses tab
            Tab(
              child: BlocBuilder<BusTravelCubit, BusesTravelState>(
                builder: (context, state) {
                  if (state.isLoadingSeasons ||
                      state.isLoadingCenters ||
                      state.isLoadingTrips) {
                    return const AppIndicator();
                  } else if (state.trips != null) {
                    final trips = state.trips;
                    final filteredTrips =
                        searchText.isEmpty
                            ? trips
                            : trips.where((trip) {
                              final fStageNo = trip.fStageNo.toLowerCase();
                              // final arabicSearch = convertArabicToLatin(_searchText);
                              return fStageNo.contains(searchText);
                            }).toList();
                    final uniqueFilteredTrips =
                        {
                          for (final trip in filteredTrips) trip.fStageNo: trip,
                        }.values.toList();
                    return ListView.builder(
                      padding: EdgeInsets.only(
                        right: 16.w,
                        left: 16.w,
                        bottom: 16.h,
                        top: 90.h,
                      ),
                      itemCount: uniqueFilteredTrips.length,
                      itemBuilder: (context, index) {
                        final trip = uniqueFilteredTrips[index];
                        final allocatedBusesCount = int.tryParse(
                          trip.allocatedBusesCount,
                        );
                        final totalBusesCount = int.tryParse(
                          trip.totalBusesCount,
                        );
                        final remainingBusesCount =
                            allocatedBusesCount! - totalBusesCount!;
                        return IncomingTripsBusesTab(
                          trip: trip,
                          remainingBusesCount: remainingBusesCount,
                        );
                      },
                    );
                  }
                  return NoDataWidget(
                    onPressed: () {
                      BlocProvider.of<BusTravelCubit>(context).getTrips();
                    },
                  );
                },
              ),
            ),

            /// Trips tab
            Tab(
              child: BlocBuilder<BusTravelCubit, BusesTravelState>(
                builder: (context, state) {
                  if (state.isLoadingSeasons ||
                      state.isLoadingCenters ||
                      state.isLoadingTrips) {
                    return const AppIndicator();
                  } else if (state.trips != null) {
                    final trips = state.trips;
                    final filteredTrips =
                        searchText.isEmpty
                            ? trips
                            : trips.where((trip) {
                              final fStageNo = trip.fStageNo.toLowerCase();
                              // final arabicSearch = convertArabicToLatin(_searchText);
                              return fStageNo.contains(searchText);
                            }).toList();
                    final uniqueFilteredTrips =
                        {
                          for (final trip in filteredTrips) trip.fStageNo: trip,
                        }.values.toList();
                    return ListView.builder(
                      padding: EdgeInsets.only(
                        right: 16.w,
                        left: 16.w,
                        bottom: 16.h,
                        top: 85.h,
                      ),
                      itemCount: uniqueFilteredTrips.length,
                      itemBuilder: (context, index) {
                        final trip = uniqueFilteredTrips[index];
                        final allocatedTripsCount = int.tryParse(
                          trip.allocatedTripsCount,
                        );
                        final totalTripsCount = int.tryParse(
                          trip.totalTripsCount,
                        );
                        final remainingTripsCount =
                            allocatedTripsCount! - totalTripsCount!;
                        return IncomingTripsTripsTab(
                          trip: trip,
                          remainingTripsCount: remainingTripsCount,
                        );
                      },
                    );
                  }
                  return NoDataWidget(
                    onPressed: () {
                      BlocProvider.of<BusTravelCubit>(context).getTrips();
                    },
                  );
                },
              ),
            ),
          ],
        ),

        /// Head title tabs
        const Positioned(child: BusesMovesHeadTitle()),
      ],
    );
  }
}
