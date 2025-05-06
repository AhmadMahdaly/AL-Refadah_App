import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/cubit/transfer_stage_shares_cubit.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/cubit/transfer_stage_shares_states.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transfer_get_centers_model.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/show/widgets/show_transfer_stage_card.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/show/widgets/show_transfer_stage_head_title.dart';
import 'package:alrefadah/presentation/app/shared_widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowTransferStageBody extends StatefulWidget {
  const ShowTransferStageBody({required this.center, super.key});
  final TransferStageSharesGetCenterModel center;

  @override
  State<ShowTransferStageBody> createState() => _ShowTransferStageBodyState();
}

class _ShowTransferStageBodyState extends State<ShowTransferStageBody> {
  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    context.read<TransferStageSharesCubit>()
      ..getTransportStages()
      ..getTransportStageByCriteria(
        context.read<TransferStageSharesCubit>().selectedSeasonId.toString(),
        widget.center.fCenterNo.toString(),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransferStageSharesCubit, TransferStageSharesState>(
      builder: (context, state) {
        if (state.isLoadingTransportStagesByCriteria) {
          return const AppIndicator();
        } else if (state.transportStagesByCriteria != null) {
          final stages = state.transportStagesByCriteria;
          return Column(
            children: [
              const ShowTransferStageHeadTitle(),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(16.sp),
                  itemCount: stages.length,
                  itemBuilder: (context, index) {
                    final stageData = stages[index];
                    final stageName =
                        state.transportStages
                            .where(
                              (element) =>
                                  element.fStageNo == stageData.fStageNo,
                            )
                            .toList();

                    return ShowTransferStageCard(
                      stageName: stageName.first,
                      stageData: stageData,
                    );
                  },
                ),
              ),
            ],
          );
        }
        return NoDataWidget(onPressed: _initializeData);
      },
    );
  }
}
