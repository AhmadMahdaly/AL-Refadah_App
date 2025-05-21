import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alrefadah/core/utils/components/custom_button.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/widgets/custom_dialog/error_dialog.dart';
import 'package:alrefadah/core/widgets/custom_dialog/show_success_dialog.dart';
import 'package:alrefadah/features/home_page/cubit/home_cubit.dart';
import 'package:alrefadah/features/services_pages/transport_stage/cubit/stage_cubit.dart';
import 'package:alrefadah/features/services_pages/transport_stage/cubit/stage_states.dart';
import 'package:alrefadah/features/services_pages/transport_stage/models/stage_model.dart';
import 'package:alrefadah/features/services_pages/transport_stage/widgets/stage_card.dart';
import 'package:alrefadah/features/services_pages/transport_stage/widgets/stage_table_head_title.dart';
import 'package:alrefadah/presentation/app/shared_widgets/no_data_widget.dart';

class StageBody extends StatefulWidget {
  const StageBody({super.key});
  @override
  State<StageBody> createState() => _StageBodyState();
}

class _StageBodyState extends State<StageBody> {
  @override
  void initState() {
    super.initState();
    context.read<StageCubit>().getStages();
  }

  /// handle save botton
  Future<void> _handleSave(BuildContext context) async {
    try {
      final state = context.read<StageCubit>().state;
      if (state is! GetStagesLoaded) return;
      final updatedStages =
          state.stages.map((stage) {
            return StageModel(
              fLastUpdate: DateTime.now(),
              fLastUpdateUser: 1,
              fLastUpdateSum: 0,
              fLastUpdateOper: 0,
              fStageNo: stage.fStageNo,
              fStageName: stage.fStageName,
              fStageNameFrom: stage.fStageNameFrom,
              fStageNameTo: stage.fStageNameTo,
              fStageDayNo: stage.fStageDayNo,
              fStageStatus: stage.fStageStatus,
              fStageTimeLimit: stage.fStageTimeLimit,
            );
          }).toList();
      await context.read<StageCubit>().updateStage(updatedStages);
      await context.read<StageCubit>().getStages();
      await context.read<HomeCubit>().getDashboardData();
      showSuccessDialog(context, seconds: 1);
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          Navigator.pop(context);
        }
      });
    } catch (e) {
      showErrorDialog(
        context,
        message: 'هناك خطأ في حفظ البيانات',
        isBack: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 16;
    return BlocBuilder<StageCubit, StageStates>(
      builder: (context, state) {
        if (state is StagesLoadingState ||
            context.read<HomeCubit>().state.isLoadingAllData) {
          return const AppIndicator();
        }
        if (state is GetStagesLoaded) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Column(
                children: [
                  /// Head
                  const StageHeadTitle(),

                  /// Data
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(16.sp),
                      itemCount: state.stages.length,
                      itemBuilder:
                          (context, index) =>
                              StageCard(stage: state.stages[index]),
                    ),
                  ),
                  const H(h: 65),
                ],
              ),

              /// Save
              Positioned(
                bottom: isKeyboardVisible ? -260 : 16,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: CustomButton(
                    text: 'حفظ',
                    padding: 16,
                    onTap: () => _handleSave(context),
                  ),
                ),
              ),
            ],
          );
        }
        return NoDataWidget(
          onPressed: () => context.read<StageCubit>().getStages(),
        );
      },
    );
  }
}
