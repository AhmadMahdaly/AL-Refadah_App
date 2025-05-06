import 'dart:async';

import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/custom_search_bar.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/data/constants_variable.dart';
import 'package:alrefadah/features/services_pages/guides/main/cubit/guides_cubit.dart';
import 'package:alrefadah/features/services_pages/guides/main/cubit/guides_states.dart';
import 'package:alrefadah/features/services_pages/guides/main/widgets/guides_card.dart';
import 'package:alrefadah/features/services_pages/guides/main/widgets/guides_table_head_title.dart';
import 'package:alrefadah/presentation/app/shared_widgets/custom_download_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuidesBody extends StatefulWidget {
  const GuidesBody({super.key});

  @override
  State<GuidesBody> createState() => _GuidesBodyState();
}

class _GuidesBodyState extends State<GuidesBody> {
  @override
  void initState() {
    context.read<GuidesCubit>().fetchCenters();
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

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
    return BlocBuilder<GuidesCubit, GuidesState>(
      builder: (context, state) {
        final centers = state.centers;
        final filteredCenters =
            _searchText.isEmpty
                ? centers
                : centers.where((com) {
                  final centerNo = com.fCenterNo.toString().toLowerCase();
                  final centerName = com.fCenterName;
                  final arabicSearch = convertArabicToLatin(_searchText);
                  return centerNo.contains(_searchText) ||
                      centerName.contains(_searchText) ||
                      centerNo.contains(arabicSearch);
                }).toList();
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
                const GuidesTableHeadTitle(),
                if (state.isLoadingCenters)
                  SizedBox(height: 250.h, child: const AppIndicator())
                else
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(16.sp),
                      itemCount: filteredCenters.length,
                      itemBuilder: (context, index) {
                        final center = filteredCenters[index];
                        return GuidesCard(center: center);
                      },
                    ),
                  ),
              ],
            ),
            // _buildBottomButtons(context),
          ],
        );
      },
    );
  }
}
