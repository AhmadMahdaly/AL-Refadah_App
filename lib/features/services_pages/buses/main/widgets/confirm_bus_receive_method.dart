import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/widgets/custom_dialog/error_dialog.dart';
import 'package:alrefadah/core/widgets/custom_dialog/show_success_dialog.dart';
import 'package:alrefadah/features/services_pages/buses/edit/models/edit_bus_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/cubit/buses_cubit.dart';
import 'package:alrefadah/features/services_pages/buses/main/cubit/buses_states.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/get_all_buses_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<String?> confirmReceiveBusMethod(
  BuildContext context,
  GetAllBusesModel bus,
) {
  return showDialog<String>(
    context: context,
    builder: (context) {
      return BlocBuilder<BusesCubit, BusesState>(
        builder: (context, state) {
          return AlertDialog(
            backgroundColor: kScaffoldBackgroundColor,
            title: SizedBox(
              height: 50.h,
              width: 200.w,
              child: Text(
                'تأكيد استلام الحافلة؟',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
            actions: [
              if (state.isLoadingEditTransportBus || state.isLoadingAllBuses)
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
                            final model = EditBusModel(
                              fBusAco: bus.fBusAco,
                              fTransportName: bus.fTransportName,
                              fStageName: bus.fStageName,
                              fCenterName: bus.fCenterName,
                              fBusId: bus.fBusId,
                              fCompanyId: bus.fCompanyId,
                              fSeasonId: bus.fSeasonId,
                              fCenterNo: bus.fCenterNo,
                              fStageNo: bus.fStageNo,
                              fTransportNo: bus.fTransportNo,
                              fOperatingNo: bus.fOperatingNo,
                              fBusStatus: 2,
                              fBusIdTrip: bus.fBusIdTrip,
                              fBusNo: bus.fBusNo,
                              fPilgrimsAco: bus.fPilgrimsAco,
                              fTripAco: bus.fTripAco,
                              fBusNote: bus.fBusNote,
                            );
                            try {
                              await context.read<BusesCubit>().editTransportBus(
                                [model],
                              );
                              if (context.read<BusesCubit>().state.isEditDone) {
                                await context.read<BusesCubit>().getAllBuses();

                                showSuccessDialog(context, seconds: 1);
                                Future.delayed(const Duration(seconds: 1), () {
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                  }
                                });
                              } else {
                                Navigator.pop(context);
                                showErrorDialog(
                                  isBack: true,
                                  context,
                                  message:
                                      'حدث خطأ أثناء تأكيد الإستلام!\nحاول مرة أخرى أو تواصل مع الدعم.',
                                  icon: Icons.error_outline_rounded,
                                  color: kErrorColor,
                                );
                              }
                            } catch (e) {
                              showErrorDialog(
                                isBack: true,
                                context,
                                message: 'هناك خطأ في تحديث البيانات',
                              );
                            }
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
                            'تأكيد',
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
      );
    },
  );
}
