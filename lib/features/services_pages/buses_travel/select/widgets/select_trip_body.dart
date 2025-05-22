import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/data/constants_variable.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/screens/add_trip_page.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_cubit.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_state.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/models/get_buses_travel_trip_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/select/widgets/select_buses_travel_title_head.dart';
import 'package:alrefadah/features/services_pages/buses_travel/select/widgets/select_trip_card.dart';
import 'package:alrefadah/presentation/app/shared_widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectTripBody extends StatelessWidget {
  const SelectTripBody({
    required this.trip,
    required this.searchText,
    super.key,
  });
  final BusesTravelGetTripModel trip;
  final String searchText;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusTravelCubit, BusesTravelState>(
      builder: (context, state) {
        if (state.isLoadingTripsByStage) {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Center(child: AppIndicator())],
          );
        } else if (state.tripsByStage == null || state.tripsByStage.isEmpty) {
          return Stack(
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
        } else if (state.tripsByStage != null) {
          final tripsByStage = state.tripsByStage;
          final filteredTripsByStage =
              searchText.isEmpty
                  ? (tripsByStage.toList()
                    ..sort((a, b) => b.fTripNo.compareTo(a.fTripNo)))
                  : tripsByStage.where((trip) {
                    final fBusNo = trip.fBus.fBusNo.toLowerCase();
                    final fTripNo = trip.fTripNo;
                    final arabicSearch = convertArabicToLatin(searchText);
                    return fTripNo.contains(searchText) ||
                        fTripNo.contains(arabicSearch) ||
                        fBusNo.contains(arabicSearch) ||
                        fBusNo.contains(searchText);
                  }).toList();
          return Stack(
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
                        final tripAco = trip.fBus.fTripAco;

                        final accuTrip = int.tryParse(trip.busOccurrencesCount);
                        final remainingTripsCount =
                            tripAco - (accuTrip ?? 0) < 0
                                ? 0
                                : tripAco - (accuTrip ?? 0);
                        final additionTrip =
                            (accuTrip ?? 0) - tripAco < 0
                                ? 0
                                : (accuTrip ?? 0) - tripAco;
                        return SelectTripCard(
                          remainingTripsCount: remainingTripsCount,
                          additionTrip: additionTrip,
                          trip: trip,
                          tripsByStage: state.tripsByStage,
                        );
                      },
                    ),
                  ),
                ],
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
        } else {
          return NoDataWidget(
            onPressed:
                () => context.read<BusTravelCubit>().getTripsByStage(
                  trip.fCenterNo,
                  trip.fStageNo,
                ),
          );
        }
      },
    );
  }
}
