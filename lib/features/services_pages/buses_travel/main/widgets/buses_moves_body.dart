import 'dart:async';

import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/utils/components/text_fields/textfield_border_radius.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_cubit.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/widgets/buses_moves_head_title.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/widgets/dropdowns/centers_dropdown.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/widgets/dropdowns/seasons_dropdown.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/widgets/tabs_and_cards/buses/buses_tab.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/widgets/tabs_and_cards/pilgrims/pilgrims_tab.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/widgets/tabs_and_cards/trips/trips_tab.dart';
import 'package:alrefadah/presentation/app/shared_widgets/custom_download_button.dart';
import 'package:alrefadah/presentation/app/shared_widgets/custom_help_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BusesMovesBody extends StatefulWidget {
  const BusesMovesBody({super.key});

  @override
  State<BusesMovesBody> createState() => _BusesMovesBodyState();
}

class _BusesMovesBodyState extends State<BusesMovesBody>
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

  void _clearSearch() {
    if (mounted) {
      setState(() {
        searchText = '';
      });
    }
    _searchController.clear();
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
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'حركة الحافلات',
        style: TextStyle(
          color: kMainColor,
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          height: 1.20.h,
        ),
      ),
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
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: const Color(0xFF494949),
                        fontWeight: FontWeight.w300,
                        fontFamily: 'FF Shamel Family',
                      ),
                      cursorWidth: 1.sp,
                      cursorColor: kMainColor,
                      minLines: 1,
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'ابحث هنا',
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xFFA2A2A2),
                          fontWeight: FontWeight.w300,
                        ),
                        suffixIcon:
                            _searchController.text.isNotEmpty
                                ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: _clearSearch,
                                )
                                : null,
                        border: textfieldBorderRadius(const Color(0xFFD6D6D6)),
                        focusedBorder: textfieldBorderRadius(kMainColor),
                        enabledBorder: textfieldBorderRadius(
                          const Color(0xFFD6D6D6),
                        ),
                        focusedErrorBorder: textfieldBorderRadius(Colors.red),
                        prefixIcon: SvgPicture.asset(
                          'assets/svg/search.svg',
                          fit: BoxFit.none,
                          colorFilter: const ColorFilter.mode(
                            kMainColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
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
            BusesMovesPilgrimsTab(searchText: searchText),
            BusesMovesBusesTab(searchText: searchText),
            BusesMovesTripsTab(searchText: searchText),
          ],
        ),
        const Positioned(child: BusesMovesHeadTitle()),
      ],
    );
  }
}
