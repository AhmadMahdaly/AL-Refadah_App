import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/text_fields/textfield_border_radius.dart';
import 'package:alrefadah/core/widgets/empty_dropdown.dart';
import 'package:alrefadah/features/home_page/cubit/home_cubit.dart';
import 'package:alrefadah/features/home_page/cubit/home_states.dart';
import 'package:alrefadah/features/home_page/models/home_season_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeSeasonDropdown extends StatefulWidget {
  const HomeSeasonDropdown({super.key});

  @override
  State<HomeSeasonDropdown> createState() => _HomeSeasonDropdownState();
}

class _HomeSeasonDropdownState extends State<HomeSeasonDropdown> {
  final List<String> sessions = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.seasons.isNotEmpty) {
          return SizedBox(
            height: 60.h,
            child: DropdownButtonFormField<String>(
              borderRadius: BorderRadius.circular(10.r),
              isExpanded: true,
              dropdownColor: kScaffoldBackgroundColor,
              decoration: InputDecoration(
                border: textfieldBorderRadius(kMainColorLightColor),
                focusedBorder: textfieldBorderRadius(kMainColorLightColor),
                enabledBorder: textfieldBorderRadius(kMainColorLightColor),
                focusedErrorBorder: textfieldBorderRadius(Colors.red),
              ),
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: kMainColor,
              ),
              style: TextStyle(
                color: kMainColor,
                fontSize: 14.sp,
                fontFamily: 'GE SS Two',
                fontWeight: FontWeight.w500,
              ),
              hint: _buildDropdownItem(
                BlocProvider.of<HomeCubit>(
                      context,
                    ).selectedSeason?.toString() ??
                    'لم يتم التحديد',
              ),
              items: _buildDropdownItems(state.seasons),
              value:
                  BlocProvider.of<HomeCubit>(
                    context,
                  ).selectedSeason?.toString(),
              onChanged: _onStageChanged,
            ),
          );
        }
        return const EmptyDropdown(title: 'موسم حج');
      },
    );
  }

  Widget _buildDropdownItem(String text) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/svg/kaaba 1.svg',
          height: 16.h,
          colorFilter: const ColorFilter.mode(kMainColor, BlendMode.srcIn),
        ),
        SizedBox(width: 6.w),
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
    List<HomeSeasonModel> seasons,
  ) {
    return seasons
        .map(
          (season) => DropdownMenuItem<String>(
            value: season.fSeasonId.toString(),
            child: _buildDropdownItem(season.fSeasonName),
            // child: _buildDropdownItem(stage.fStageName + ' - ' + stage.fStageNo.toString()),
          ),
        )
        .toList();
  }

  void _onStageChanged(String? value) {
    if (value != null) {
      setState(() {
        context.read<HomeCubit>().selectedSeason = value;
      });
    }
  }
}
