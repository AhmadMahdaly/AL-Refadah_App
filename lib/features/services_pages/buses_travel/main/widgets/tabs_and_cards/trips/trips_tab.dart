import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_cubit.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_state.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/widgets/tabs_and_cards/trips/trips_card.dart';
import 'package:alrefadah/presentation/app/shared_widgets/no_data_widget.dart';

class BusesMovesTripsTab extends StatelessWidget {
  const BusesMovesTripsTab({required this.searchText, super.key});
  final String searchText;
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: BlocBuilder<BusTravelCubit, BusesTravelState>(
        builder: (context, state) {
          if (state.isLoadingSeasons ||
              state.isLoadingCenters ||
              state.isLoadingTrips) {
            return const AppIndicator();
          } else if (state.trips != null) {
            final trips = state.trips;
            final filteredTrips =
                searchText.isEmpty
                    ? trips
                    : trips.where((trip) {
                      final fStageNo = trip.fStageNo.toLowerCase();
                      // final arabicSearch = convertArabicToLatin(_searchText);
                      return fStageNo.contains(searchText);
                    }).toList();
            final uniqueFilteredTrips =
                {
                  for (final trip in filteredTrips) trip.fStageNo: trip,
                }.values.toList();
            return ListView.builder(
              padding: EdgeInsets.only(
                right: 16.w,
                left: 16.w,
                bottom: 16.h,
                top: 85.h,
              ),
              itemCount: uniqueFilteredTrips.length,
              itemBuilder: (context, index) {
                final trip = uniqueFilteredTrips[index];
                return TripsCard(trip: trip);
              },
            );
          }
          return NoDataWidget(
            onPressed: () {
              BlocProvider.of<BusTravelCubit>(context).getTrips();
            },
          );
        },
      ),
    );
  }
}
