import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/text_fields/textfield_border_radius.dart';
import 'package:alrefadah/core/widgets/empty_dropdown.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_cubit.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_state.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/models/get_buses_travel_centers_model.dart';

class GetBusTravelCentersDropdown extends StatefulWidget {
  const GetBusTravelCentersDropdown({super.key});

  @override
  State<GetBusTravelCentersDropdown> createState() =>
      _GetBusSeasonDropdownState();
}

class _GetBusSeasonDropdownState extends State<GetBusTravelCentersDropdown> {
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() {
    try {
      final cubit = BlocProvider.of<BusTravelCubit>(context)..getCenters();
      cubit.stream.listen((state) {
        if (state.centers != null) {
          centers
            ..clear()
            ..addAll(state.centers.map((e) => e.fCenterNo.toString()));
          if (centers.isNotEmpty) {
            cubit.selectedCenter = centers.first;
          }
        }
      });
    } catch (e) {
      // Ignored: handle exception if needed
    }
  }

  final List<String> centers = [];
  @override
  Widget build(BuildContext context) {
    return BlocListener<BusTravelCubit, BusesTravelState>(
      listener: (context, state) {
        if (state.centers != null && state.centers.isNotEmpty) {
          centers
            ..clear()
            ..addAll(state.centers.map((e) => e.fCenterNo.toString()));
          if (centers.isNotEmpty) {
            BlocProvider.of<BusTravelCubit>(context).selectedCenter =
                centers.first;
          }
        }
      },
      child: BlocBuilder<BusTravelCubit, BusesTravelState>(
        builder: (context, state) {
          if (state.isLoadingCenters) {
            return const EmptyDropdown(title: 'مركز');
          }
          if (state.centers != null) {
            return SizedBox(
              height: 60.h,
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                dropdownColor: kScaffoldBackgroundColor,
                hint: Text(
                  state.centers.first.fCenterName,
                  style: TextStyle(
                    color: kMainColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.25.h,
                  ),
                ),
                decoration: InputDecoration(
                  border: dropdownBorderRadius(kMainColorLightColor),
                  focusedBorder: dropdownBorderRadius(kMainColorLightColor),
                  enabledBorder: dropdownBorderRadius(kMainColorLightColor),
                  focusedErrorBorder: dropdownBorderRadius(Colors.red),
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
                items: _buildDropdownItems(state.centers),
                value: BlocProvider.of<BusTravelCubit>(context).selectedCenter,
                onChanged: _onCenterChanged,
              ),
            );
          }

          return const EmptyDropdown(title: 'مركز');
        },
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownItems(
    List<BusesTravelGetCenterModel> centers,
  ) {
    return centers
        .map(
          (center) => DropdownMenuItem<String>(
            value: center.fCenterNo.toString(),
            child: Text(
              center.fCenterName,
              style: TextStyle(
                color: kMainColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                height: 1.25.h,
              ),
            ),
          ),
        )
        .toList();
  }

  void _onCenterChanged(String? value) {
    if (value != null) {
      setState(() {
        BlocProvider.of<BusTravelCubit>(context).selectedCenter = value;
        BlocProvider.of<BusTravelCubit>(context).getTrips();
      });
    }
  }
}
