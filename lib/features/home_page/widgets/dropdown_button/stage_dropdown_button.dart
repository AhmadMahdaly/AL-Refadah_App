import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/text_fields/textfield_border_radius.dart';
import 'package:alrefadah/core/widgets/empty_dropdown.dart';
import 'package:alrefadah/features/home_page/cubit/home_cubit.dart';
import 'package:alrefadah/features/home_page/cubit/home_states.dart';
import 'package:alrefadah/features/services_pages/transport_stage/models/stage_model.dart';

class GetStageDropdown extends StatefulWidget {
  const GetStageDropdown({super.key});

  @override
  State<GetStageDropdown> createState() => _GetStageDropdownState();
}

class _GetStageDropdownState extends State<GetStageDropdown> {
  final List<String> stages = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.stages.isNotEmpty) {
          return SizedBox(
            height: 60.h,
            child: DropdownButtonFormField<String>(
              isExpanded: true,

              dropdownColor: kScaffoldBackgroundColor,
              hint: _buildDropdownItem(
                BlocProvider.of<HomeCubit>(context).selectedStage?.toString() ??
                    'لم يتم التحديد',
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
              items: _buildDropdownItems(state.stages),
              value:
                  BlocProvider.of<HomeCubit>(context).selectedStage?.toString(),
              onChanged: _onStageChanged,
            ),
          );
        }

        return const EmptyDropdown(title: 'مرحلة');
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

  List<DropdownMenuItem<String>> _buildDropdownItems(List<StageModel> stages) {
    return stages
        .map(
          (stage) => DropdownMenuItem<String>(
            value: stage.fStageNo.toString(),
            child: _buildDropdownItem(stage.fStageName ?? 'لم يتم التحديد'),
          ),
        )
        .toList();
  }

  void _onStageChanged(String? value) {
    if (value != null) {
      setState(() {
        context.read<HomeCubit>().selectedStage = value;
        context.read<HomeCubit>().getDashboardData();
      });
    }
  }
}
