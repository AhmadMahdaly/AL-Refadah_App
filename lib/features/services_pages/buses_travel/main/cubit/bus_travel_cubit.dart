import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/add_trip_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_state.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/repo/buses_travel_repo.dart';
import 'package:alrefadah/features/services_pages/complaint/models/add_complaint_model.dart';

class BusTravelCubit extends Cubit<BusesTravelState> {
  BusTravelCubit(this.repository) : super(BusesTravelState());

  final BusesTravelRepo repository;
  String? selectedSeason;
  String? selectedCenter;

  Future<void> getSeasons() async {
    emit(state.copyWith(isLoadingSeasons: true));
    try {
      final seasons = await repository.getSeasons();
      emit(state.copyWith(isLoadingSeasons: false, seasons: seasons));
    } catch (e) {
      emit(state.copyWith(isLoadingSeasons: false, error: e.toString()));
    }
  }

  Future<void> getCenters() async {
    emit(state.copyWith(isLoadingCenters: true));
    try {
      final centers = await repository.getCenters();
      emit(state.copyWith(isLoadingCenters: false, centers: centers));
    } catch (e) {
      emit(state.copyWith(isLoadingCenters: false, error: e.toString()));
    }
  }

  Future<void> getTrips() async {
    emit(state.copyWith(isLoadingTrips: true));
    try {
      if (selectedSeason == null || selectedCenter == null) {
        emit(
          state.copyWith(
            isLoadingTrips: false,
            error: 'Please select season and center',
          ),
        );
        return;
      }
      final trips = await repository.getTrips(selectedSeason!, selectedCenter!);
      emit(state.copyWith(isLoadingTrips: false, trips: trips));
    } catch (e) {
      emit(state.copyWith(isLoadingTrips: false, error: e.toString()));
    }
  }

  Future<void> getTripsByStage(String centerNo, String stageNo) async {
    emit(state.copyWith(isLoadingTripsByStage: true));
    try {
      final trips = await repository.getTripsByStage(
        selectedSeason!,
        centerNo,
        stageNo,
      );
      emit(state.copyWith(isLoadingTripsByStage: false, tripsByStage: trips));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(isLoadingTripsByStage: false, error: e.toString()));
    }
  }

  String getStageName(String stageNo) {
    switch (stageNo) {
      case '1':
        return 'مرحلة التروية - مكة - منى';
      case '2':
        return 'مرحلة التصعيد - مكة - عرفة';
      case '3':
        return 'مرحلة التصعيد - منى - عرفات';
      case '4':
        return 'مرحلة الإفاضة - عرفات - مزدلفة';
      case '5':
        return 'مرحلة الإفاضة - مزدلفة - منى';
      case '6':
        return 'مرحلة النفرة - منى - مكة - 12';
      case '7':
        return 'مرحلة النفرة - منى - مكة - 13';

      default:
        return '';
    }
  }

  Future<void> editTripByStage(AddTripModel trip) async {
    emit(
      state.copyWith(
        isEditingTripByStage: true,
        isEditingTripByStageSuccess: false,
        showEditErrorDialog: false,
      ),
    );
    try {
      await repository.editTripByStage(trip);
      emit(
        state.copyWith(
          isEditingTripByStage: false,
          isEditingTripByStageSuccess: true,
          showEditErrorDialog: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isEditingTripByStage: false,
          isEditingTripByStageSuccess: false,
          showEditErrorDialog: true,
        ),
      );
    }
  }

  Future<void> addTripByStage(AddTripModel trip) async {
    emit(
      state.copyWith(
        isAddingTripByStage: true,
        isAddingTripByStageSuccess: false,
      ),
    );
    try {
      await repository.addTripByStage(trip);
      emit(
        state.copyWith(
          isAddingTripByStage: false,
          isAddingTripByStageSuccess: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isAddingTripByStage: false,
          isAddingTripByStageSuccess: false,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> deleteTripByStage(
    String tripNo,
    String seasonId,
    String centerNo,
    String stageNo,
  ) async {
    emit(
      state.copyWith(
        isDeleteTripByStage: true,
        isDeleteTripByStageSuccess: false,
      ),
    );
    try {
      await repository.deleteTripByStage(tripNo, seasonId, centerNo, stageNo);
      emit(
        state.copyWith(
          isDeleteTripByStage: false,
          isDeleteTripByStageSuccess: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isDeleteTripByStage: false,
          isDeleteTripByStageSuccess: false,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> getIncomingTripsByStage(String selectedStageId) async {
    emit(state.copyWith(isLoadingIncomingTripByStage: true));
    try {
      if (selectedSeason != null || selectedCenter != null) {
        final trips = await repository.getIncomingTrips(
          selectedSeason!,
          selectedCenter!,
          selectedStageId,
        );
        emit(
          state.copyWith(
            isLoadingIncomingTripByStage: false,
            incomingTripsByStage: trips,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingIncomingTripByStage: false,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> getTripArrivingByStage(String selectedStageId) async {
    emit(state.copyWith(isLoadingArrivingTripByStage: true));
    try {
      if (selectedSeason != null || selectedCenter != null) {
        final trips = await repository.getTripArrivingByStage(
          selectedSeason!,
          selectedCenter!,
          selectedStageId,
        );
        emit(
          state.copyWith(
            isLoadingArrivingTripByStage: false,
            arrivingTripsByStage: trips,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingArrivingTripByStage: false,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> getTrackTrip() async {
    emit(state.copyWith(isLoadingTrackTrip: true));
    try {
      final trips = await repository.getTrackTrip();
      emit(state.copyWith(isLoadingTrackTrip: false, track: trips));
    } catch (e) {
      emit(state.copyWith(isLoadingTrackTrip: false, error: e.toString()));
    }
  }

  Future<void> getComplaintType() async {
    emit(state.copyWith(isLoadingcomplaintType: true));
    try {
      final complaint = await repository.getComplaintType();
      emit(
        state.copyWith(isLoadingcomplaintType: false, complaintType: complaint),
      );
    } catch (e) {
      emit(state.copyWith(isLoadingcomplaintType: false, error: e.toString()));
    }
  }

  Future<void> addComplaint(AddComplaintModel complaint) async {
    emit(
      state.copyWith(isLoadingAddcomplaint: true, isSuccessAddcomplaint: false),
    );
    try {
      await repository.addComplaint(complaint);
      emit(
        state.copyWith(
          isLoadingAddcomplaint: false,
          isSuccessAddcomplaint: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingAddcomplaint: false,
          isSuccessAddcomplaint: false,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> getComplaint(String centerNo, String complaintStatus) async {
    emit(state.copyWith(isLoadingcomplaint: true, complaint: null));
    try {
      final complaint = await repository.getComplaint(
        centerNo,
        complaintStatus,
      );
      emit(state.copyWith(isLoadingcomplaint: false, complaint: complaint));
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingcomplaint: false,
          error: e.toString(),
          complaint: null,
        ),
      );
    }
  }
}
