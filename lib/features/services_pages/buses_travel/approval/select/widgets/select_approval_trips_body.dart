import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/data/constants_variable.dart';
import 'package:alrefadah/features/services_pages/buses_travel/approval/select/widgets/select_approval_trips_card.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_cubit.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_state.dart';
import 'package:alrefadah/features/services_pages/buses_travel/select/widgets/select_buses_travel_title_head.dart';

class SelectApprovalTripsBody extends StatelessWidget {
  const SelectApprovalTripsBody({required this.searchText, super.key});
  final String searchText;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusTravelCubit, BusesTravelState>(
      builder: (context, state) {
        final trips = state.arrivingTripsByStage;
        final filteredArrivingTripsByStage =
            searchText.isEmpty
                ? (trips.toList()
                  ..sort((a, b) => b.fTripNo.compareTo(a.fTripNo)))
                : trips.where((trip) {
                  final fBusNo = trip.fBus.fBusNo.toLowerCase();
                  final fTripNo = trip.fTripNo;
                  final arabicSearch = convertArabicToLatin(searchText);
                  return fTripNo.contains(searchText) ||
                      fTripNo.contains(arabicSearch) ||
                      fBusNo.contains(arabicSearch) ||
                      fBusNo.contains(searchText);
                }).toList();
        if (state.isLoadingArrivingTripByStage) {
          return const AppIndicator();
        } else if (filteredArrivingTripsByStage == null ||
            filteredArrivingTripsByStage.isEmpty) {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Center(child: Text('لا يوجد رحلات'))],
          );
        } else {
          return Column(
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
                  itemCount: filteredArrivingTripsByStage.length,
                  itemBuilder: (context, index) {
                    final trip = filteredArrivingTripsByStage[index];
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
                    return SelectApprovalTripsCard(
                      remainingTripsCount: remainingTripsCount,
                      additionTrip: additionTrip,
                      trip: trip,
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
