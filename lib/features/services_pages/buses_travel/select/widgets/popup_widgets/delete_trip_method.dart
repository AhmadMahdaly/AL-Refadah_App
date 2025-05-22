import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/widgets/custom_dialog/error_dialog.dart';
import 'package:alrefadah/core/widgets/custom_dialog/show_success_dialog.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/trip_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_cubit.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<String?> deleteTripMethod(BuildContext context, TripModel trip) {
  return showDialog<String>(
    context: context,
    builder: (context) {
      return BlocBuilder<BusTravelCubit, BusesTravelState>(
        builder: (context, state) {
          return AlertDialog(
            backgroundColor: kScaffoldBackgroundColor,
            title: SizedBox(
              width: 200.w,
              child: Text(
                'هل أنت متأكد من حذف الرحلة؟',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
            actions: [
              if (state.isDeleteTripByStage || state.isLoadingTripsByStage)
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
                            try {
                              await context
                                  .read<BusTravelCubit>()
                                  .deleteTripByStage(
                                    trip.fTripNo,
                                    trip.fSeasonId,
                                    trip.fCenterNo,
                                    trip.fStageNo,
                                  );

                              showSuccessDialog(
                                context,
                                title: 'تم حذف الرحلة بنجاح',
                              );
                              Future.delayed(const Duration(seconds: 2), () {
                                if (context.mounted) {
                                  Navigator.pop(context);
                                }
                              });
                              if (context
                                  .read<BusTravelCubit>()
                                  .state
                                  .isDeleteTripByStageSuccess) {
                                await context
                                    .read<BusTravelCubit>()
                                    .getTripsByStage(
                                      trip.fCenterNo,
                                      trip.fStageNo,
                                    );
                              } else {
                                Navigator.pop(context);
                                showErrorDialog(
                                  isBack: false,
                                  context,
                                  message:
                                      'حدث خطأ أثناء حذف الرحلة!\nحاول مرة أخرى أو تواصل مع الدعم.',
                                  icon: Icons.error_outline_rounded,
                                  color: kErrorColor,
                                );
                              }
                            } catch (e) {
                              showErrorDialog(
                                isBack: true,
                                context,
                                message: 'هناك خطأ في حذف الرحلة',
                                icon: Icons.error_outline_rounded,
                                color: kErrorColor,
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
      );
    },
  );
}
