import 'dart:async';

import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/custom_search_bar.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/widgets/custom_download_button.dart';
import 'package:alrefadah/data/constants_variable.dart';
import 'package:alrefadah/features/services_pages/guides/main/cubit/guides_cubit.dart';
import 'package:alrefadah/features/services_pages/guides/main/cubit/guides_states.dart';
import 'package:alrefadah/features/services_pages/guides/main/models/get_centers_model.dart';
import 'package:alrefadah/features/services_pages/guides/show_all/widgets/show_all_guides_card.dart';
import 'package:alrefadah/features/services_pages/guides/show_all/widgets/show_all_guides_table_head_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowAllGuidesBody extends StatefulWidget {
  const ShowAllGuidesBody({required this.center, super.key});
  final GetGuidesCenterModel center;

  @override
  State<ShowAllGuidesBody> createState() => _ShowAllGuidesBodyState();
}

class _ShowAllGuidesBodyState extends State<ShowAllGuidesBody> {
  @override
  void initState() {
    context.read<GuidesCubit>().getGuideByCriteria(
      widget.center.fCenterNo.toString(),
    );
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
        if (state.isLoadingGetByCriteria) {
          return const Center(child: AppIndicator());
        } else if (state.guidesByCriteria != null &&
            state.guidesByCriteria.isNotEmpty) {
          final filteredCenters =
              state.guidesByCriteria.where((emp) {
                final name = emp.employee?.fEmpName.toLowerCase() ?? '';
                final nameLatin = convertArabicToLatin(name);
                final searchLatin = convertArabicToLatin(_searchText);
                return name.contains(_searchText) ||
                    nameLatin.contains(searchLatin);
              }).toList();
          return Column(
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
              const ShowAllGuidesTableHeadTitle(),

              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(16.sp),
                  itemCount: filteredCenters.length,
                  itemBuilder: (context, index) {
                    final employe = filteredCenters[index];
                    return ShowAllGuidesCard(
                      employe: employe,
                      center: widget.center,
                    );
                  },
                ),
              ),
            ],
          );
        } else if (state.error != null) {
          return Center(child: Text(state.error!));
        }
        return const SizedBox();
      },
    );
  }
}
