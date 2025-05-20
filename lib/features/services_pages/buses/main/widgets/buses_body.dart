import 'dart:async';

import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/custom_search_bar.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/widgets/custom_download_button.dart';
import 'package:alrefadah/data/constants_variable.dart';
import 'package:alrefadah/features/services_pages/buses/main/cubit/buses_cubit.dart';
import 'package:alrefadah/features/services_pages/buses/main/cubit/buses_states.dart';
import 'package:alrefadah/features/services_pages/buses/main/widgets/bus_card.dart';
import 'package:alrefadah/features/services_pages/buses/main/widgets/buses_head_title.dart';
import 'package:alrefadah/presentation/app/shared_widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BusesBody extends StatefulWidget {
  const BusesBody({super.key});
  @override
  State<BusesBody> createState() => _BusesBodyState();
}

class _BusesBodyState extends State<BusesBody> {
  @override
  void initState() {
    context.read<BusesCubit>().getAllBuses();
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

  final List<String> sessions = [];
  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _searchText = _searchController.text.toLowerCase();
        });
      }
    });
  }

  @override
  void dispose() {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _searchController.dispose();
    super.dispose();
  }

  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        H(h: 10.h),
        SizedBox(
          height: 46,
          child: Row(
            spacing: 12.w,
            children: [
              W(w: 4.w),

              /// Search bar
              Expanded(
                child: CustomSearchBar(
                  controller: _searchController,
                  clearIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      setState(() => _searchText = '');
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

        /// Head
        const GetBusTableHeadTitle(),

        /// Body Data
        BlocBuilder<BusesCubit, BusesState>(
          builder: (context, state) {
            if (state.isLoadingSeasons || state.isLoadingAllBuses) {
              return SizedBox(height: 350.h, child: const AppIndicator());
            } else if (state.allBuses != null) {
              final buses = state.allBuses;
              final filteredCenters =
                  _searchText.isEmpty
                      ? buses
                      : buses.where((bus) {
                        final operatingNo = bus.fOperatingNo.toLowerCase();
                        final busNo = bus.fBusNo;
                        final stageName = bus.fStageName;
                        final centerName = bus.fCenterName;
                        final arabicSearch = convertArabicToLatin(_searchText);
                        return operatingNo.contains(_searchText) ||
                            stageName.contains(_searchText) ||
                            centerName.contains(_searchText) ||
                            busNo.contains(_searchText) ||
                            operatingNo.contains(arabicSearch);
                      }).toList();
              if (filteredCenters.isEmpty) {
                return const SizedBox(
                  height: 350,
                  child: Center(child: Text('لا يوجد حافلات')),
                );
              }
              if (filteredCenters.isNotEmpty) {
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                      bottom: 80.h,
                      top: 10.h,
                    ),
                    itemCount: filteredCenters.length,
                    itemBuilder: (context, index) {
                      final bus = filteredCenters[index];
                      return BusCard(bus: bus);
                    },
                  ),
                );
              }
            }
            return NoDataWidget(
              onPressed: () => context.read<BusesCubit>().getAllBuses(),
            );
          },
        ),
      ],
    );
  }
}
