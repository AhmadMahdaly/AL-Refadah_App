import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/text_fields/textfield_border_radius.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_cubit.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_state.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/models/get_buses_travel_seasons_model.dart';
import 'package:alrefadah/presentation/app/shared_widgets/empty_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class GetBusTravelSeasonDropdown extends StatefulWidget {
  const GetBusTravelSeasonDropdown({super.key});

  @override
  State<GetBusTravelSeasonDropdown> createState() =>
      _GetBusSeasonDropdownState();
}

class _GetBusSeasonDropdownState extends State<GetBusTravelSeasonDropdown> {
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() {
    final cubit = BlocProvider.of<BusTravelCubit>(context)..getSeasons();
    cubit.stream.listen((state) {
      if (state.seasons != null) {
        sessions
          ..clear()
          ..addAll(state.seasons.map((e) => e.fSeasonId.toString()));
        if (sessions.isNotEmpty) {
          cubit.selectedSeason = sessions.last;
        }
      }
    });
  }

  final List<String> sessions = [];
  @override
  Widget build(BuildContext context) {
    return BlocListener<BusTravelCubit, BusesTravelState>(
      listener: (context, state) {
        if (state.seasons != null) {
          sessions
            ..clear()
            ..addAll(state.seasons.map((e) => e.fSeasonId.toString()));
          if (sessions.isNotEmpty) {
            BlocProvider.of<BusTravelCubit>(context).selectedSeason =
                sessions.last;
          }
        }
      },
      child: BlocBuilder<BusTravelCubit, BusesTravelState>(
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
                value: BlocProvider.of<BusTravelCubit>(context).selectedSeason,
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
    List<BusesTravelGetSeasonModel> seasons,
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
        BlocProvider.of<BusTravelCubit>(context).selectedSeason = value;
        BlocProvider.of<BusTravelCubit>(context).getTrips();
      });
    }
  }
}
