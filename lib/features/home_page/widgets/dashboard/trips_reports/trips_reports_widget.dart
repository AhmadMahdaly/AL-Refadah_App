import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/features/home_page/cubit/home_cubit.dart';
import 'package:alrefadah/features/home_page/cubit/home_states.dart';
import 'package:alrefadah/features/home_page/widgets/dashboard/trips_reports/delayed_trip_head_title.dart';

class TripsReportsWidget extends StatelessWidget {
  const TripsReportsWidget({required this.padding, super.key});
  final int padding;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        // final filter =
        //     state.allData?.delayedTrip!.where((item) {
        //       final actualDuration = item.receiptDate?.difference(
        //         item.additionDate!,
        //       );
        //       final expectedDuration = Duration(
        //         minutes: item.transportStage!.fStageTimeLimit!,
        //       );
        //       return actualDuration != null &&
        //           actualDuration > expectedDuration;
        //     }).toList();

        return Column(
          children: [
            DelayedTripHeadTitle(padding: padding),
            if (state.allData!.delayedTrip!.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(
                  left: 25.w,
                  right: 25.w,
                  bottom: 20.h,
                  top: 16.h,
                ),
                itemCount: state.allData?.delayedTrip!.length,
                itemBuilder: (context, index) {
                  final delayedTrip = state.allData?.delayedTrip![index];

                  final addTime =
                      delayedTrip?.additionDate != null
                          ? DateTime.tryParse(
                            delayedTrip!.additionDate.toString(),
                          )
                          : null;
                  final endTime =
                      delayedTrip?.receiptDate != null
                          ? DateTime.tryParse(
                            delayedTrip!.receiptDate.toString(),
                          )
                          : DateTime.now();

                  // طرح delay من الحد الأقصى
                  final expectedTime =
                      delayedTrip?.transportStage?.fStageTimeLimit;

                  final timeBetweenAddAndEnd = endTime?.difference(addTime!);
                  final rem =
                      (timeBetweenAddAndEnd != null && expectedTime != null)
                          ? (timeBetweenAddAndEnd -
                                  Duration(minutes: expectedTime))
                              .inMinutes
                          // .abs()
                          : null;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          /// رقم الرحلة
                          SizedBox(
                            width: 50.w,
                            child: Text(
                              delayedTrip?.tripNo ?? '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kDartTextColor,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          /// وقت الإنطلاق
                          SizedBox(
                            width: 50.w,
                            child: Text(
                              addTime != null
                                  ? DateFormat.jm()
                                      .format(
                                        DateTime.parse(addTime.toString()),
                                      )
                                      .replaceAll('AM', 'ص')
                                      .replaceAll('PM', 'م')
                                  : 'غير متوفر',

                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kDartTextColor,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          /// وقت الوصول
                          SizedBox(
                            width: 70.w,
                            child: Text(
                              delayedTrip?.receiptDate != null
                                  ? DateFormat.jm()
                                      .format(
                                        DateTime.parse(endTime.toString()),
                                      )
                                      .replaceAll('AM', 'ص')
                                      .replaceAll('PM', 'م')
                                  : 'لم تصل بعد',

                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kDartTextColor,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          /// الوصول المتوقع
                          SizedBox(
                            width: 45.w,
                            child: Text(
                              expectedTime != null
                                  ? expectedTime.toString()
                                  : 'غير متوفر',

                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kDartTextColor,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          /// التأخير
                          SizedBox(
                            width: 50.w,
                            child: Text(
                              rem!.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kDartTextColor,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: kMainColorLightColor),
                    ],
                  );
                },
              )
            else
              SizedBox(
                height: 65.h,
                child: const Center(child: Text('لا يوجد رحلات متأخرة')),
              ),
            const H(h: 20),
          ],
        );
      },
    );
  }
}
