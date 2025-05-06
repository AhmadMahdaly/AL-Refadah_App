import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/text_fields/textfield_border_radius.dart';
import 'package:alrefadah/features/home_page/cubit/home_cubit.dart';
import 'package:alrefadah/features/home_page/cubit/home_states.dart';
import 'package:alrefadah/features/services_pages/transport_stage/models/stage_model.dart';
import 'package:alrefadah/presentation/app/shared_widgets/empty_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetStageDropdown extends StatefulWidget {
  const GetStageDropdown({super.key});

  @override
  State<GetStageDropdown> createState() => _GetStageDropdownState();
}

class _GetStageDropdownState extends State<GetStageDropdown> {
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() {
    final busesCubit = BlocProvider.of<HomeCubit>(context)..getStages();
    busesCubit.stream.listen((state) {
      if (state.stages.isNotEmpty) {
        stages
          ..clear()
          ..addAll(state.stages.map((e) => e.fStageNo.toString()));
        if (stages.isNotEmpty) {
          busesCubit.selectedStage = stages.first;
        }
      }
    });
  }

  final List<String> stages = [];
  String? selectedStage;
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
              items: _buildDropdownItems(state.stages),
              value:
                  selectedStage ??
                  BlocProvider.of<HomeCubit>(context).selectedStage?.toString(),
              onChanged: _onStageChanged,
            ),
          );
        }

        return const EmptyDropdown(title: 'مرحلة حج');
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
            child: _buildDropdownItem(stage.fStageName),
            // child: _buildDropdownItem(stage.fStageName + ' - ' + stage.fStageNo.toString()),
          ),
        )
        .toList();
  }

  void _onStageChanged(String? value) {
    if (value != null) {
      setState(() {
        selectedStage = value;
        BlocProvider.of<HomeCubit>(context).selectedStage = value;
        BlocProvider.of<HomeCubit>(context).getDashboardData();
      });
    }
  }
}
