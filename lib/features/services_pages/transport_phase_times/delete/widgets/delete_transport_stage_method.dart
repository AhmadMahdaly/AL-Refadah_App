import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/widgets/custom_dialog/error_dialog.dart';
import 'package:alrefadah/core/widgets/custom_dialog/show_success_dialog.dart';
import 'package:alrefadah/features/home_page/cubit/home_cubit.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/cubit/transfer_stage_shares_cubit.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/cubit/transfer_stage_shares_states.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transfer_stage_get_transport_by_criteria_model.dart';

Future<String?> deleteStageMethod(
  BuildContext context,
  TransferStageGetTransportByCriteriaModel stageData,
) {
  return showDialog<String>(
    context: context,
    builder: (context) {
      return BlocListener<TransferStageSharesCubit, TransferStageSharesState>(
        listenWhen:
            (previous, current) =>
                previous.isSuccessDeleteTransportStage !=
                    current.isSuccessDeleteTransportStage ||
                previous.showDeleteErrorDialog != current.showDeleteErrorDialog,

        listener: (context, state) {
          if (state.isSuccessDeleteTransportStage) {
            showSuccessDialog(
              context,
              title: 'تم حذف المرحلة بنجاح',
              seconds: 1,
            );
            context.read<TransferStageSharesCubit>()
              ..getCenters()
              ..getTransportStages()
              ..getTransportStageByCriteria(
                stageData.fSeasonId.toString(),
                stageData.fCenterNo.toString(),
              );
            context.read<HomeCubit>().getDashboardData();
            Future.delayed(const Duration(seconds: 1), () {
              if (context.mounted) {
                Navigator.pop(context);
              }
            });
          } else if (state.showDeleteErrorDialog) {
            if (context.mounted) {
              Navigator.pop(context);
            }
            Navigator.pop(context);
            showErrorDialog(
              isBack: true,
              context,
              message: 'هناك خطأ في حذف المرحلة',
              icon: Icons.error_outline_rounded,
              color: kErrorColor,
            );

            // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
            context.read<TransferStageSharesCubit>().emit(
              state.copyWith(showDeleteErrorDialog: false),
            );
          }
        },
        //     state.error!.contains('No data found for the specified criteria')) {
        child: BlocBuilder<TransferStageSharesCubit, TransferStageSharesState>(
          builder: (context, state) {
            final cubit = context.read<TransferStageSharesCubit>();
            return AlertDialog(
              backgroundColor: kScaffoldBackgroundColor,
              title: SizedBox(
                width: 200.w,
                child: Text(
                  'هل أنت متأكد من حذف المرحلة؟',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
              actions: [
                if (state.isLoadingDeleteTransportStage ||
                    context.read<HomeCubit>().state.isLoadingAllData ||
                    state.isLoadingTransportStagesByCriteria)
                  const AppIndicator()
                else
                  Row(
                    spacing: 12.w,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            if (context.mounted) {
                              await cubit.deleteTransportStage(
                                stageData.fStageNo.toString(),
                                stageData.fCenterNo.toString(),
                              );
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(12.sp),
                            decoration: BoxDecoration(
                              color: kMainColor,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: const Text(
                              'حذف',
                              style: TextStyle(color: kMainExtrimeLightColor),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(12.sp),
                            decoration: BoxDecoration(
                              color: kScaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(width: 1, color: kMainColor),
                            ),
                            child: const Text(
                              'العودة',
                              style: TextStyle(color: kMainColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            );
          },
        ),
      );
    },
  );
}
