import 'package:alrefadah/core/manager/app_states.dart';
import 'package:alrefadah/core/utils/components/custom_button.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/features/services_pages/transport_stage/cubit/stage_cubit.dart';
import 'package:alrefadah/features/services_pages/transport_stage/models/stage_model.dart';
import 'package:alrefadah/features/services_pages/transport_stage/widgets/stage_card.dart';
import 'package:alrefadah/features/services_pages/transport_stage/widgets/stage_table_head_title.dart';
import 'package:alrefadah/presentation/app/shared_widgets/custom_dialog/error_dialog.dart';
import 'package:alrefadah/presentation/app/shared_widgets/custom_dialog/show_success_dialog.dart';
import 'package:alrefadah/presentation/app/shared_widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            );
          }).toList();

      await context.read<StageCubit>().updateStage(updatedStages);
      await context.read<StageCubit>().getStages();
      showSuccessDialog(context);
      // Navigator.pop(context);
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

    return BlocBuilder<StageCubit, AppStates>(
      builder: (context, state) {
        if (state is AppLoadingState) {
          return const AppIndicator();
        }

        if (state is GetStagesLoaded) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Column(
                children: [
                  const StageHeadTitle(),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(16.sp),
                      itemCount: state.stages.length,
                      itemBuilder:
                          (context, index) =>
                              StageCard(stage: state.stages[index]),
                    ),
                  ),
                ],
              ),
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
