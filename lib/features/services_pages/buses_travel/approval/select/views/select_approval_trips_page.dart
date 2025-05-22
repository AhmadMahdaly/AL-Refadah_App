import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alrefadah/core/services/cache_helper.dart';
import 'package:alrefadah/core/utils/components/custom_search_bar.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/widgets/custom_download_button.dart';
import 'package:alrefadah/core/widgets/custom_help_button.dart';
import 'package:alrefadah/core/widgets/leading_icon.dart';
import 'package:alrefadah/core/widgets/title_appbar.dart';
import 'package:alrefadah/features/services_pages/buses_travel/approval/select/widgets/select_approval_trips_body.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_cubit.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/models/get_buses_travel_trip_model.dart';

class SelectApprovalTripsPage extends StatefulWidget {
  const SelectApprovalTripsPage({required this.trip, super.key});
  final BusesTravelGetTripModel trip;

  @override
  State<SelectApprovalTripsPage> createState() =>
      _SelectApprovalTripsPageState();
}

class _SelectApprovalTripsPageState extends State<SelectApprovalTripsPage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  String searchText = '';

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
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initSearchListener();
    context.read<BusTravelCubit>().getTripArrivingByStage(widget.trip.fStageNo);
    _getUserId();
  }

  Future<void> _getUserId() async {
    userId = await CacheHelper.getUserId();
  }

  int? userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const LeadingIcon(),
        title: TitleAppBar(
          title: context.read<BusTravelCubit>().getStageName(
            widget.trip.fStageNo,
          ),
        ),
        actions: const [CustomHelpButton()],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: SizedBox(
            height: 46,
            child: SizedBox(
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
          ),
        ),
      ),
      body: SelectApprovalTripsBody(searchText: searchText),
    );
  }
}
