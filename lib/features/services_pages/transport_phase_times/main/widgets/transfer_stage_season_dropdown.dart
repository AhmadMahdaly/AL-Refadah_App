import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/cubit/transfer_stage_shares_cubit.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/cubit/transfer_stage_shares_states.dart';
import 'package:alrefadah/presentation/app/shared_widgets/custom_dropdown/custom_dropdown.dart';
import 'package:alrefadah/presentation/app/shared_widgets/empty_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TransferStageSeasonDropdown extends StatefulWidget {
  const TransferStageSeasonDropdown({super.key});

  @override
  State<TransferStageSeasonDropdown> createState() =>
      _TransferStageSeasonDropdownState();
}

class _TransferStageSeasonDropdownState
    extends State<TransferStageSeasonDropdown> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    final cubit = BlocProvider.of<TransferStageSharesCubit>(context)
      ..getSeasons();
    cubit.stream.listen((state) {
      if (state.seasons != null) {
        sessions
          ..clear()
          ..addAll(state.seasons.map((e) => e.fSeasonId.toString()));
        if (sessions.isNotEmpty) {
          cubit.selectedSeasonId = sessions.last;
        }
      }
    });
  }

  final List<String> sessions = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TransferStageSharesCubit, TransferStageSharesState>(
      listener: (context, state) {
        if (state.seasons != null) {
          sessions
            ..clear()
            ..addAll(state.seasons.map((e) => e.fSeasonId.toString()));
          if (sessions.isNotEmpty) {
            BlocProvider.of<TransferStageSharesCubit>(context)
                .selectedSeasonId = sessions.last;
          }
        }
      },
      builder: (context, state) {
        if (state.isLoadingSeasons) {
          return const EmptyDropdown(title: 'موسم حج');
        }

        if (state.seasons != null) {
          return SizedBox(
            height: 60.h,
            child: CustomStringDropdown(
              hint: Row(
                children: [
                  SvgPicture.asset(
                    'assets/svg/kaaba 1.svg',
                    height: 16.h,
                    colorFilter: const ColorFilter.mode(
                      kMainColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    state.seasons.last.fSeasonName,
                    style: TextStyle(
                      color: kMainColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.25.h,
                    ),
                  ),
                ],
              ),
              items:
                  state.seasons
                      .map(
                        (season) => DropdownMenuItem<String>(
                          value: season.fSeasonId.toString(),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/svg/kaaba 1.svg',
                                height: 16.h,
                                colorFilter: const ColorFilter.mode(
                                  kMainColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                season.fSeasonName,
                                style: TextStyle(
                                  color: kMainColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  height: 1.25.h,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
              value:
                  BlocProvider.of<TransferStageSharesCubit>(
                    context,
                  ).selectedSeasonId ??
                  '',
              onChanged: _onSeasonChanged,
            ),
          );
        }
        return const EmptyDropdown(title: 'موسم حج');
      },
    );
  }

  void _onSeasonChanged(String? value) {
    if (value != null) {
      setState(() {
        BlocProvider.of<TransferStageSharesCubit>(context).selectedSeasonId =
            value;
        context.read<TransferStageSharesCubit>().getCenters();
      });
    }
  }
}
