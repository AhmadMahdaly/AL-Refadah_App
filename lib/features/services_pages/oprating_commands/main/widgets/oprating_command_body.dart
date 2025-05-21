import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/custom_search_bar.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/widgets/custom_download_button.dart';
import 'package:alrefadah/data/constants_variable.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/cubit/oprating_command_cubit.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/cubit/oprating_command_states.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/widgets/oprating_commands_card.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/widgets/oprating_commands_table_head_title.dart';
import 'package:alrefadah/presentation/app/shared_widgets/no_data_widget.dart';

class OpratingCommandBody extends StatefulWidget {
  const OpratingCommandBody({super.key});

  @override
  State<OpratingCommandBody> createState() => _OpratingCommandBodyState();
}

class _OpratingCommandBodyState extends State<OpratingCommandBody> {
  @override
  void initState() {
    context.read<OpratingCommandsCubit>().getAllTransportOperating();
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
    return BlocBuilder<OpratingCommandsCubit, OperatingCommandState>(
      builder: (context, state) {
        if (state.isLoadingTransportOprating) {
          return const AppIndicator();
        } else if (state.operatingList != null) {
          final command = state.operatingList;
          final filteredCenters =
              _searchText.isEmpty
                  ? command
                  : command.where((com) {
                    final operatingNo = com.fOperatingNo.toLowerCase();
                    final centerName = com.center?.fCenterName ?? '';
                    final arabicSearch = convertArabicToLatin(_searchText);
                    return operatingNo.contains(_searchText) ||
                        centerName.contains(_searchText) ||
                        operatingNo.contains(arabicSearch);
                  }).toList();
          if (filteredCenters.isEmpty) {
            return const SizedBox(
              height: 370,
              child: Center(child: Text('لا يوجد أوامر تشغيل')),
            );
          }
          if (filteredCenters.isNotEmpty) {
            return Column(
              children: [
                H(h: 10.h),

                /// Search bar
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
                              if (mounted) {
                                setState(() {
                                  _searchText = '';
                                });
                              }
                            },
                          ),
                        ),
                      ),
                      const CustomDownloadButton(),
                      W(w: 4.w),
                    ],
                  ),
                ),
                const OpratingCommandsTableHeadTitle(),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                      bottom: 80.h,
                      top: 16.h,
                    ),
                    itemCount: filteredCenters.length,
                    itemBuilder: (context, index) {
                      final item = filteredCenters[index];
                      return OpratingCommandsCard(item: item);
                    },
                  ),
                ),
              ],
            );
          }
        }
        return NoDataWidget(
          onPressed:
              () =>
                  context
                      .read<OpratingCommandsCubit>()
                      .getAllTransportOperating(),
        );
      },
    );
  }
}
