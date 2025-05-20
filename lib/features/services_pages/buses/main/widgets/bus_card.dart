import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/get_all_buses_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/widgets/buses_popup_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BusCard extends StatelessWidget {
  const BusCard({required this.bus, super.key});
  final GetAllBusesModel bus;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExpansionTile(
          shape: Border.all(color: kScaffoldBackgroundColor),
          minTileHeight: 20.h,
          collapsedIconColor: kMainColor,
          iconColor: kMainColor,
          collapsedBackgroundColor: kScaffoldBackgroundColor,
          childrenPadding: EdgeInsets.zero,
          tilePadding: EdgeInsets.zero,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// center name
              SizedBox(
                width: 50.w,
                child: Text(
                  bus.fCenterName,
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kDartTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              /// stage name
              SizedBox(
                width: 100.w,
                child: Text(
                  bus.fStageName,
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kDartTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              /// bus no
              SizedBox(
                width: 75.w,
                child: Text(
                  bus.fBusNo,
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kDartTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              /// transport name
              SizedBox(
                width: 60.w,
                child: Text(
                  bus.fTransportName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kDartTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const W(w: 2),
            ],
          ),
          children: [
            const Divider(color: kMainExtrimeLightColor),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 80.w,
                          child: Text(
                            'أمر التشغيل',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: kAnalysisMediumColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 70.w,
                          child: Text(
                            'عدد الحجاج',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: kAnalysisMediumColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 70.w,
                          child: Text(
                            'عدد الردود',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: kAnalysisMediumColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 70.w,
                          child: Text(
                            'الحالة',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: kAnalysisMediumColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        /// operating no
                        SizedBox(
                          width: 80.w,
                          child: Text(
                            bus.fOperatingNo,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kDartTextColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        /// pilgrims count
                        SizedBox(
                          width: 70.w,
                          child: Text(
                            bus.fPilgrimsAco.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kDartTextColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        /// trip count
                        SizedBox(
                          width: 70.w,
                          child: Text(
                            bus.fTripAco.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kDartTextColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        /// bus status
                        SizedBox(
                          width: 90.w,
                          child: Row(
                            spacing: 8.w,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(getStatusIcon(bus.fBusStatus)),
                              Text(
                                getStatusText(bus.fBusStatus),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  color: getStatusColor(bus.fBusStatus),
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: ShapeDecoration(
                    color: kMainExtrimeLightColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                  ),
                  child: showBusPopupMenuButton(context, bus),
                ),
              ],
            ),
          ],
        ),
        const Divider(color: kAnalysisMediumColor),
      ],
    );
  }
}

String getStatusText(int status) {
  switch (status) {
    case 2:
      return 'مستلمة';
    case 3:
      return 'مستبدلة';
    default:
      return 'لدى التسليم';
  }
}

Color getStatusColor(int status) {
  switch (status) {
    case 2:
      return const Color(0xFF46C469);
    case 3:
      return Colors.purple;
    default:
      return Colors.orangeAccent;
  }
}

String getStatusIcon(int status) {
  switch (status) {
    case 2:
      return 'assets/svg/bus_status/done.svg';
    case 3:
      return 'assets/svg/bus_status/swap.svg';
    default:
      return 'assets/svg/bus_status/waiting.svg';
  }
}
