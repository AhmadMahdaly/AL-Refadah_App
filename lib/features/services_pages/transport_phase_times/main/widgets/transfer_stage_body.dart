import 'dart:async';

import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/custom_search_bar.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/data/constants_variable.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/cubit/transfer_stage_shares_cubit.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/cubit/transfer_stage_shares_states.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transfer_get_centers_model.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/widgets/transfer_stage_card.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/widgets/transfer_stage_head_title.dart';
import 'package:alrefadah/presentation/app/shared_widgets/custom_download_button.dart';
import 'package:alrefadah/presentation/app/shared_widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransferStageBody extends StatefulWidget {
  const TransferStageBody({super.key});

  @override
  State<TransferStageBody> createState() => _TransferStageBodyState();
}

class _TransferStageBodyState extends State<TransferStageBody> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    context.read<TransferStageSharesCubit>().getCenters();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _searchText = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransferStageSharesCubit, TransferStageSharesState>(
      builder: (context, state) {
        final allCenters = state.centers;
        final filteredCenters = _filterCenters(allCenters);
        return Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                H(h: 10.h),
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
                              setState(() => _searchText = '');
                            },
                          ),
                        ),
                      ),
                      const CustomDownloadButton(),
                      W(w: 4.w),
                    ],
                  ),
                ),
                const TransferStageHeadTitle(),
                if (state.isLoadingCenters)
                  SizedBox(height: 250.h, child: const AppIndicator())
                else
                  state.centers != null
                      ? Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.all(16.sp),
                          itemCount: filteredCenters.length,
                          itemBuilder:
                              (context, index) => TransferStageCard(
                                center: filteredCenters[index],
                              ),
                        ),
                      )
                      : NoDataWidget(onPressed: _initializeData),
              ],
            ),
          ],
        );
      },
    );
  }

  List<TransferStageSharesGetCenterModel> _filterCenters(
    List<TransferStageSharesGetCenterModel> allCenters,
  ) {
    if (_searchText.isEmpty) return allCenters;

    final arabicSearch = convertArabicToLatin(_searchText);
    return allCenters.where((center) {
      return center.fCenterName.toLowerCase().contains(arabicSearch);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}
