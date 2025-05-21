import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/cubit/oprating_command_states.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/models/add_transport_operating_model.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/models/get_all_operatings_model.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/repo/operating_command_repo.dart';

class OpratingCommandsCubit extends Cubit<OperatingCommandState> {
  OpratingCommandsCubit() : super(OperatingCommandState());

  final OperatingCommandsRepo repository = OperatingCommandsRepo();

  String? selectedSeasonId;
  String? selectedCenter;
  Future<void> getSeasons() async {
    emit(state.copyWith(isLoadingSeasons: true));
    try {
      final seasons = await repository.getSeasons();
      emit(state.copyWith(isLoadingSeasons: false, seasons: seasons));
    } catch (e) {
      emit(state.copyWith(isLoadingSeasons: false, error: 'حدث خطأ'));
    }
  }

  Future<void> getCenters() async {
    emit(state.copyWith(isLoadingCenters: true));
    try {
      final centers = await repository.getCenters();
      emit(state.copyWith(isLoadingCenters: false, centers: centers));
    } catch (e) {
      emit(state.copyWith(isLoadingCenters: false, error: 'حدث خطأ'));
    }
  }

  Future<void> getAllTransportOperating() async {
    emit(state.copyWith(isLoadingTransportOprating: true));
    try {
      final opratingList = await repository.fetchOperatingList(
        selectedSeasonId!,
      );
      emit(
        state.copyWith(
          isLoadingTransportOprating: false,
          operatingList: opratingList,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoadingTransportOprating: false, error: 'حدث خطأ'));
    }
  }

  Future<void> addOperating(GetAllOperatingsModel model) async {
    emit(state.copyWith(isLoadingAddOperating: true));
    try {
      await repository.addOperating(model);
      emit(
        state.copyWith(
          isLoadingAddOperating: false,
          isSuccessAddTransportOperating: true,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoadingAddOperating: false, error: 'حدث خطأ'));
    }
  }

  Future<void> editOperating(AddTransportOperatingModel model) async {
    emit(state.copyWith(isLoadingEditOperating: true));
    try {
      await repository.editOperating(model);
      emit(
        state.copyWith(
          isLoadingEditOperating: false,
          isSuccessEditTransportOperating: true,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoadingEditOperating: false, error: 'حدث خطأ'));
    }
  }

  Future<void> deleteOperating(String centerNo, String operNo) async {
    emit(
      state.copyWith(
        isLoadingDeleteOperating: true,
        isSuccessDeleteOperating: false,
        showDeleteErrorDialog: false,
      ),
    );
    try {
      final statusCode = await repository.deleteOperating(
        selectedSeasonId!,
        centerNo,
        operNo,
      );

      if (statusCode! >= 200 && statusCode < 300) {
        emit(
          state.copyWith(
            isLoadingDeleteOperating: false,
            isSuccessDeleteOperating: true,
            showDeleteErrorDialog: false,
          ),
        );
      } else {
        emit(
          state.copyWith(
            isLoadingDeleteOperating: false,
            showDeleteErrorDialog: true,
            isSuccessDeleteOperating: false,
          ),
        );
      }
    } catch (e) {
      log('Delete failed: $e');
      emit(
        state.copyWith(
          isLoadingDeleteOperating: false,
          showDeleteErrorDialog: true,
          isSuccessDeleteOperating: false,
        ),
      );
    }
  }
}
