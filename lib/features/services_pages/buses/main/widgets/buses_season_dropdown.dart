import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/text_fields/textfield_border_radius.dart';
import 'package:alrefadah/features/services_pages/buses/main/cubit/buses_cubit.dart';
import 'package:alrefadah/features/services_pages/buses/main/cubit/buses_states.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_season_model.dart';
import 'package:alrefadah/presentation/app/shared_widgets/empty_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class GetBusSeasonDropdown extends StatefulWidget {
  const GetBusSeasonDropdown({super.key});

  @override
  State<GetBusSeasonDropdown> createState() => _GetBusSeasonDropdownState();
}

class _GetBusSeasonDropdownState extends State<GetBusSeasonDropdown> {
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() {
    final busesCubit = BlocProvider.of<BusesCubit>(context)..getSeasons();
    busesCubit.stream.listen((state) {
      if (state.seasons != null) {
        sessions
          ..clear()
          ..addAll(state.seasons.map((e) => e.fSeasonId.toString()));
        if (sessions.isNotEmpty) {
          busesCubit.selectedSeason = sessions.last;
        }
      }
    });
  }

  final List<String> sessions = [];
  @override
  Widget build(BuildContext context) {
    return BlocListener<BusesCubit, BusesState>(
      listener: (context, state) {
        if (state.seasons != null) {
          sessions
            ..clear()
            ..addAll(state.seasons.map((e) => e.fSeasonId.toString()));
          if (sessions.isNotEmpty) {
            BlocProvider.of<BusesCubit>(context).selectedSeason = sessions.last;
          }
        }
      },
      child: BlocBuilder<BusesCubit, BusesState>(
        builder: (context, state) {
          if (state.isLoadingSeasons) {
            return const EmptyDropdown(title: 'موسم حج');
          }

          if (state.seasons != null) {
            return SizedBox(
              height: 60.h,
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                dropdownColor: kScaffoldBackgroundColor,
                hint: _buildDropdownItem(state.seasons.last.fSeasonName),
                decoration: InputDecoration(
                  border: dropdownBorderRadius(kMainColorLightColor),
                  focusedBorder: dropdownBorderRadius(kMainColorLightColor),
                  enabledBorder: dropdownBorderRadius(kMainColorLightColor),
                  focusedErrorBorder: dropdownBorderRadius(kErrorColor),
                ),
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: kMainColor,
                ),
                style: TextStyle(
                  color: kMainColor,
                  fontSize: 15.sp,
                  fontFamily: 'GE SS Two',
                  fontWeight: FontWeight.w300,
                  height: 1.43.h,
                ),
                items: _buildDropdownItems(state.seasons),
                value: BlocProvider.of<BusesCubit>(context).selectedSeason,
                onChanged: _onSeasonChanged,
              ),
            );
          }

          return const EmptyDropdown(title: 'موسم حج');
        },
      ),
    );
  }

  Widget _buildDropdownItem(String text) {
    return Row(
      spacing: 6.w,
      children: [
        SvgPicture.asset(
          'assets/svg/kaaba 1.svg',
          height: 16.h,
          colorFilter: const ColorFilter.mode(kMainColor, BlendMode.srcIn),
        ),
        Text(
          text,
          style: TextStyle(
            color: kMainColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            height: 1.25.h,
          ),
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownItems(
    List<BusesGetSeasonModel> seasons,
  ) {
    return seasons
        .map(
          (season) => DropdownMenuItem<String>(
            value: season.fSeasonId.toString(),
            child: _buildDropdownItem(season.fSeasonName),
          ),
        )
        .toList();
  }

  void _onSeasonChanged(String? value) {
    if (value != null) {
      setState(() {
        BlocProvider.of<BusesCubit>(context).selectedSeason = value;
        context.read<BusesCubit>().getAllBuses();
      });
    }
  }
}
