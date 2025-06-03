import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/data/constants_variable.dart';
import 'package:alrefadah/features/home_page/cubit/home_cubit.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/screens/add_trip_page.dart';
import 'package:alrefadah/features/services_pages/buses_travel/launch/select/widgets/head_title_in_card.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_cubit.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_state.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/models/get_buses_travel_trip_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/select/widgets/get_trip_status_style.dart';
import 'package:alrefadah/features/services_pages/buses_travel/select/widgets/select_buses_travel_title_head.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SelectLaunchTripsBody extends StatelessWidget {
  const SelectLaunchTripsBody({
    required this.searchText,
    required this.trip,
    super.key,
  });
  final BusesTravelGetTripModel trip;
  final String searchText;
  String formatText(String input) {
    if (input.length < 8) return input;

    final part1 = input.substring(0, 4); // rrrr
    final part2 = input.substring(4, 6); // tt
    final part3 = input.substring(6); // yy

    return '$part1-$part2-$part3';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusTravelCubit, BusTravelState>(
      builder: (context, state) {
        final userTrips =
            state.tripsByStage
                .where(
                  (trip) =>
                      trip.fAdditionUser == context.read<HomeCubit>().userId &&
                      trip.fTripStstus == '1',
                )
                .toList();

        final filteredTripsByStage =
            searchText.isEmpty
                ? (userTrips.toList()
                  ..sort((a, b) => b.fTripNo.compareTo(a.fTripNo)))
                : userTrips.where((trip) {
                  final fBusNo = trip.fBus.fBusNo.toLowerCase();
                  final fTripNo = trip.fTripNo;
                  final arabicSearch = convertArabicToLatin(searchText);
                  return fTripNo.contains(searchText) ||
                      fTripNo.contains(arabicSearch) ||
                      fBusNo.contains(arabicSearch) ||
                      fBusNo.contains(searchText);
                }).toList();
        return state.isLoadingTripsByStage
            ? const AppIndicator()
            : filteredTripsByStage.isEmpty
            ? Stack(
              children: [
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Center(child: Text('لا يوجد رحلات'))],
                ),

                Positioned(
                  bottom: 20,
                  left: 20,
                  child: FloatingActionButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(320.r),
                    ),
                    backgroundColor: kMainColor,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => AddTripPage(
                                trip: trip,
                                tripsByStage: userTrips,
                              ),
                        ),
                      );
                    },
                    child: const Icon(Icons.add, color: kMainColorLightColor),
                  ),
                ),
              ],
            )
            : Stack(
              children: [
                Column(
                  children: [
                    const SelectBusesHeadTitle(),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.only(
                          left: 16.w,
                          right: 16.w,
                          bottom: 80.h,
                          top: 16.h,
                        ),
                        itemCount: filteredTripsByStage.length,
                        itemBuilder: (context, index) {
                          final trip = filteredTripsByStage[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ExpansionTile(
                                shape: Border.all(
                                  color: kScaffoldBackgroundColor,
                                ),
                                minTileHeight: 20.h,
                                collapsedIconColor: kMainColor,
                                iconColor: kMainColor,
                                collapsedBackgroundColor:
                                    kScaffoldBackgroundColor,
                                childrenPadding: EdgeInsets.zero,
                                tilePadding: EdgeInsets.zero,
                                title: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    /// Trip No
                                    SizedBox(
                                      width: 50.w,
                                      child: Text(
                                        trip.fTripNo,
                                        overflow: TextOverflow.fade,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          color: kDartTextColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),

                                    /// Trip date
                                    SizedBox(
                                      width: 80.w,
                                      child: Text(
                                        formatText(trip.fTripDate),
                                        overflow: TextOverflow.fade,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          color: kDartTextColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),

                                    /// Transport name
                                    SizedBox(
                                      width: 75.w,
                                      child: Text(
                                        trip
                                                    .fBus
                                                    .transport!
                                                    .fTransportName
                                                    .length >
                                                12
                                            ? '${trip.fBus.transport!.fTransportName}...'
                                                .replaceAll('الشركة', '')
                                                .replaceAll('شركة', '')
                                                .replaceAll('الشركه', '')
                                                .replaceAll('شركه', '')
                                            : trip
                                                .fBus
                                                .transport!
                                                .fTransportName
                                                .replaceAll('الشركة', '')
                                                .replaceAll('شركة', '')
                                                .replaceAll('الشركه', '')
                                                .replaceAll('شركه', ''),
                                        overflow: TextOverflow.fade,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: kDartTextColor,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),

                                    /// Bus No
                                    SizedBox(
                                      width: 65.w,
                                      child: Text(
                                        trip.fBus.fBusNo,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: kDartTextColor,
                                          fontFamily: 'Cairo',
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const H(h: 8),
                                      const HeadInsideCard(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const W(w: 12),

                                          /// Poligrams count
                                          SizedBox(
                                            width: 60.w,
                                            child: Text(
                                              trip.fPilgrimsAco,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'Cairo',
                                                color: kDartTextColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),

                                          /// Addition User
                                          SizedBox(
                                            width: 75.w,
                                            child: Text(
                                              trip
                                                          .additionUser
                                                          .fUserName
                                                          .length >
                                                      12
                                                  ? '${trip.additionUser.fUserName.substring(0, 12)}...'
                                                  : trip.additionUser.fUserName,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: kDartTextColor,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),

                                          /// Trip status
                                          SizedBox(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              spacing: 5.w,
                                              children: [
                                                SvgPicture.asset(
                                                  getTripStatusIcon(
                                                    trip.fTripStstus,
                                                  ),
                                                ),
                                                Text(
                                                  getTripStatusText(
                                                    trip.fTripStstus,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  overflow: TextOverflow.fade,
                                                  style: TextStyle(
                                                    color: getTripStatusColor(
                                                      trip.fTripStstus,
                                                    ),
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                const W(w: 12),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Divider(color: kTextColor),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),

                /// add button
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: FloatingActionButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(320.r),
                    ),
                    backgroundColor: kMainColor,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => AddTripPage(
                                trip: trip,
                                tripsByStage: state.tripsByStage,
                              ),
                        ),
                      );
                    },
                    child: const Icon(Icons.add, color: kMainColorLightColor),
                  ),
                ),
              ],
            );
      },
    );
  }
}
