import 'package:alrefadah/features/home_page/cubit/home_states.dart';
import 'package:alrefadah/features/home_page/repo/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.repository) : super(HomeState());
  final GetHomePageRepo repository;
  String? selectedSeason;
  String? selectedCenter;
  String? selectedStage;

  Future<void> getHomeSeasons() async {
    emit(state.copyWith(isLoadingSeasons: true));
    try {
      final seasons = await repository.fetchSeasons();
      if (isClosed) return;
      emit(state.copyWith(isLoadingSeasons: false, seasons: seasons));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(isLoadingSeasons: false, error: e.toString()));
    }
  }

  Future<void> getStages() async {
    emit(state.copyWith(isLoadingStages: true));
    try {
      final stages = await repository.getStages();
      if (isClosed) return;
      emit(state.copyWith(isLoadingStages: false, stages: stages));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(isLoadingStages: false, error: e.toString()));
    }
  }

  Future<void> getCenters() async {
    emit(state.copyWith(isLoadingCenters: true));
    try {
      final centers = await repository.getCenters();
      if (isClosed) return;
      emit(state.copyWith(isLoadingCenters: false, centers: centers));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(isLoadingCenters: false, error: e.toString()));
    }
  }

  Future<void> getDashboardData() async {
    emit(state.copyWith(isLoadingAllData: true));
    try {
      final dashboardData = await repository.getDashboardData(
        selectedSeason!,
        selectedCenter!,
        selectedStage!,
      );
      if (isClosed) return;
      emit(state.copyWith(isLoadingAllData: false, allData: dashboardData));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(isLoadingAllData: false, error: e.toString()));
    }
  }
}
