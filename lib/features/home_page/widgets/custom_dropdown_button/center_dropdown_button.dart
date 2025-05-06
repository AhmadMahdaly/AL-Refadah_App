import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/text_fields/textfield_border_radius.dart';
import 'package:alrefadah/features/home_page/cubit/home_cubit.dart';
import 'package:alrefadah/features/home_page/cubit/home_states.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/models/get_buses_travel_centers_model.dart';
import 'package:alrefadah/presentation/app/shared_widgets/empty_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetCenterDropdown extends StatefulWidget {
  const GetCenterDropdown({super.key});

  @override
  State<GetCenterDropdown> createState() => _GetCenterDropdownState();
}

class _GetCenterDropdownState extends State<GetCenterDropdown> {
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() {
    final cubit = BlocProvider.of<HomeCubit>(context)..getCenters();
    cubit.stream.listen((state) {
      if (state.centers.isNotEmpty) {
        centers
          ..clear()
          ..addAll(state.centers.map((e) => e.fCenterNo.toString()));
        if (centers.isNotEmpty) {
          cubit.selectedCenter = centers.first;
        }
      }
    });
  }

  final List<String> centers = [];
  String? selectedCenter;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.centers.isNotEmpty) {
          return SizedBox(
            height: 60.h,
            child: DropdownButtonFormField<String>(
              isExpanded: true,
              dropdownColor: kScaffoldBackgroundColor,
              hint: Text(
                BlocProvider.of<HomeCubit>(
                      context,
                    ).selectedCenter?.toString() ??
                    'لم يتم التحديد',
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
              items: _buildDropdownItems(state.centers),
              value:
                  BlocProvider.of<HomeCubit>(
                    context,
                  ).selectedCenter?.toString(),
              onChanged: _onCenterChanged,
            ),
          );
        }

        return const EmptyDropdown(title: 'موسم حج');
      },
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
              selectedCenter!,
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
        selectedCenter = value;
        BlocProvider.of<HomeCubit>(context).selectedCenter = value;
        BlocProvider.of<HomeCubit>(context).getDashboardData();
      });
    }
  }
}
