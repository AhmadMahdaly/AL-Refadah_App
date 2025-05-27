import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/text_fields/textfield_border_radius.dart';
import 'package:alrefadah/core/widgets/empty_dropdown.dart';
import 'package:alrefadah/features/home_page/cubit/home_cubit.dart';
import 'package:alrefadah/features/home_page/cubit/home_states.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/models/get_buses_travel_centers_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetCenterDropdown extends StatefulWidget {
  const GetCenterDropdown({super.key});

  @override
  State<GetCenterDropdown> createState() => _GetCenterDropdownState();
}

class _GetCenterDropdownState extends State<GetCenterDropdown> {
  final List<String> centers = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.centers != null && state.centers.isNotEmpty) {
          return SizedBox(
            height: 60.h,
            child: DropdownButtonFormField<int>(
              isExpanded: true,
              dropdownColor: kScaffoldBackgroundColor,

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
              hint: _buildDropdownItem(
                BlocProvider.of<HomeCubit>(
                      context,
                    ).selectedCenter?.toString() ??
                    'لم يتم التحديد',
              ),
              items: _buildDropdownItems(state.centers),
              value: BlocProvider.of<HomeCubit>(context).selectedCenter,
              onChanged: _onStageChanged,
            ),
          );
        }

        return const EmptyDropdown(title: 'مركز');
      },
    );
  }

  Widget _buildDropdownItem(String text) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: kMainColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        height: 1.25.h,
      ),
    );
  }

  List<DropdownMenuItem<int>> _buildDropdownItems(
    List<BusesTravelGetCenterModel> centers,
  ) {
    return centers
        .map(
          (center) => DropdownMenuItem<int>(
            value: center.fCenterNo,
            child: _buildDropdownItem(center.fCenterName),
          ),
        )
        .toList();
  }

  void _onStageChanged(int? value) {
    if (value != null) {
      setState(() {
        context.read<HomeCubit>().selectedCenter = value;
        context.read<HomeCubit>().getDashboardData();
      });
    }
  }
}
