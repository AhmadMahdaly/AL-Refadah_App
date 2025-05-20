import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/widgets/custom_dialog/error_dialog.dart';
import 'package:alrefadah/core/widgets/custom_dialog/show_success_dialog.dart';
import 'package:alrefadah/data/constants_variable.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/add_trip_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/trip_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_cubit.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_state.dart';
import 'package:alrefadah/presentation/app/shared_cubit/get_current_location_cubit/get_current_location_cubit.dart';
import 'package:alrefadah/presentation/app/shared_widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<String?> confirmArrTripMethod(
  BuildContext context,
  TripModel trip,
  int userId,
) {
  return showDialog<String>(
    context: context,
    builder: (context) {
      return BlocBuilder<BusTravelCubit, BusesTravelState>(
        builder: (context, state) {
          return AlertDialog(
            backgroundColor: kScaffoldBackgroundColor,
            title: SizedBox(
              height: 50.h,
              width: 200.w,
              child: Text(
                'تأكيد وصول الحافلة؟',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
            actions: [
              BlocBuilder<GetCurrentLocationCubit, GetCurrentLocationState>(
                builder: (context, state) {
                  if (state is GetCurrentLocationLoading) {
                    return const AppIndicator();
                  }
                  if (state is GetCurrentLocationSuccess) {
                    final approvalLatitude = state.position.latitude.toString();
                    final approvalLongitude =
                        state.position.longitude.toString();
                    return BlocBuilder<BusTravelCubit, BusesTravelState>(
                      builder: (context, state) {
                        if (state.isLoadingArrivingTripByStage ||
                            state.isEditingTripByStage) {
                          return const AppIndicator();
                        } else {
                          return Row(
                            spacing: 12.w,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    if (context.mounted) {
                                      final inputs = AddTripModel(
                                        /// أخر تحديث
                                        fLastUpdate:
                                            DateTime.now().toIso8601String(),

                                        /// أخر تحديث
                                        fLastUpdateUser: 1,

                                        /// أخر تحديث
                                        fLastUpdateSum: 2,

                                        /// أخر تحديث
                                        fLastUpdateOper: 0,

                                        /// الشركة الناقلة
                                        fCompanyId: companyId,

                                        /// الموسم
                                        fSeasonId: int.parse(trip.fSeasonId),

                                        /// حالة الرحلة
                                        fTripStstus: 2,

                                        /// المركز
                                        fCenterNo: int.parse(trip.fCenterNo),

                                        /// المرحلة
                                        fStageNo: int.parse(trip.fStageNo),

                                        /// رقم الرحلة
                                        fTripNo: int.parse(trip.fTripNo),

                                        /// تاريخ الرحلة
                                        fTripDate: trip.fTripDate,

                                        /// وقت الرحلة
                                        fTripTime: trip.fTripTime,

                                        /// رقم الحافلة
                                        fBusId: trip.fBusId,

                                        /// عدد الحجاج
                                        fPilgrimsAco: int.parse(
                                          trip.fPilgrimsAco,
                                        ),

                                        /// تاريخ الإضافة
                                        fAdditionDate:
                                            trip.fAdditionDate
                                                .toIso8601String(),

                                        /// المستخدم
                                        fAdditionUser:
                                            trip.additionUser.fUserId,

                                        /// خط العرض
                                        fAdditionLatitude:
                                            trip.fAdditionLatitude,

                                        /// خط الطول
                                        fAdditionLongitude:
                                            trip.fAdditionLongitude,

                                        /// تاريخ الوصول
                                        fReceiptDate:
                                            DateTime.now().toIso8601String(),

                                        /// المستلم
                                        fReceiptUser: userId,

                                        /// خط العرض
                                        fReceiptLatitude: trip.fReceiptLatitude,

                                        /// خط الطول
                                        fReceiptLongitude:
                                            trip.fReceiptLongitude,
                                        fApprovalDate:
                                            DateTime.now().toIso8601String(),
                                        fApprovalUser: int.parse(
                                          trip.fAdditionUser,
                                        ),
                                        fApprovalLatitude: approvalLatitude,
                                        fApprovalLongitude: approvalLongitude,
                                        fEmpNo: trip.fEmpNo ?? 0,
                                        fTrackNo: trip.fTrackNo ?? 0,
                                      );
                                      try {
                                        await context
                                            .read<BusTravelCubit>()
                                            .editTripByStage(inputs);

                                        if (context
                                            .read<BusTravelCubit>()
                                            .state
                                            .isEditingTripByStageSuccess) {
                                          await context
                                              .read<BusTravelCubit>()
                                              .getTripArrivingByStage(
                                                trip.fStageNo,
                                              );
                                          showSuccessDialog(context);

                                          Future.delayed(
                                            const Duration(seconds: 2),
                                            () {
                                              if (context.mounted) {
                                                Navigator.pop(context);
                                              }
                                            },
                                          );
                                        } else {
                                          Navigator.pop(context);
                                          showErrorDialog(
                                            isBack: true,
                                            context,
                                            message:
                                                'حدث خطأ أثناء تأكيد الرحلة!\nحاول مرة أخرى أو تواصل مع الدعم.',
                                            icon: Icons.error_outline_rounded,
                                            color: kErrorColor,
                                          );
                                        }
                                      } catch (e) {
                                        Navigator.pop(context);
                                        showErrorDialog(
                                          isBack: true,
                                          context,
                                          message: 'هناك خطأ في تأكيد الرحلة',
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
                                      'تأكيد',
                                      style: TextStyle(
                                        color: kMainExtrimeLightColor,
                                      ),
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
                                      border: Border.all(
                                        width: 1,
                                        color: kMainColor,
                                      ),
                                    ),
                                    child: const Text(
                                      'العودة',
                                      style: TextStyle(color: kMainColor),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    );
                  }
                  return NoDataWidget(
                    onPressed: () {
                      context
                          .read<GetCurrentLocationCubit>()
                          .getCurrentLocation();
                    },
                  );
                },
              ),
            ],
          );
        },
      );
    },
  );
}
