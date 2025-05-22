import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/delete/widgets/delete_transfer_stage_head_title.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/delete/widgets/delete_transport_stage_card.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/cubit/transfer_stage_shares_cubit.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/cubit/transfer_stage_shares_states.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transfer_stage_get_centers_model.dart';
import 'package:alrefadah/presentation/app/shared_widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeleteTransferStageBody extends StatefulWidget {
  const DeleteTransferStageBody({required this.center, super.key});
  final TransferStageGetCenterModel center;

  @override
  State<DeleteTransferStageBody> createState() =>
      _DeleteTransferStageBodyState();
}

class _DeleteTransferStageBodyState extends State<DeleteTransferStageBody> {
  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    context.read<TransferStageSharesCubit>().getTransportStageByCriteria(
      context.read<TransferStageSharesCubit>().selectedSeasonId.toString(),
      widget.center.fCenterNo.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransferStageSharesCubit, TransferStageSharesState>(
      builder: (context, state) {
        return Column(
          children: [
            /// Head
            const DeleteTransferStageHeadTitle(),

            /// Data body
            /// Loading
            if (state.isLoadingTransportStagesByCriteria ||
                state.isLoadingDeleteTransportStage)
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: const AppIndicator(),
              )
            else
              /// Fetch data
              state.transportStagesByCriteria != null ||
                      state.transportStagesByCriteria.isNotEmpty ||
                      state.error!.isEmpty
                  ? Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(16.sp),
                      itemCount: state.transportStagesByCriteria.length,
                      itemBuilder: (context, index) {
                        final stageData =
                            state.transportStagesByCriteria[index];

                        /// Data card
                        return DeleteTransferStageCard(stageData: stageData);
                      },
                    ),
                  )
                  /// when fetch data failed
                  : NoDataWidget(onPressed: _initializeData),
          ],
        );
      },
    );
  }
}
