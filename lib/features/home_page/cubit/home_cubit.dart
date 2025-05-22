import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:alrefadah/features/home_page/cubit/home_states.dart';
import 'package:alrefadah/features/home_page/repo/home_repo.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.repository) : super(HomeState());
  final HomeRepo repository;
  String? selectedSeason;
  String? selectedCenter;
  String? selectedStage;
  String? fPermNo;
  String? userId;
  static FlutterSecureStorage storage = const FlutterSecureStorage();

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
    if (selectedSeason == null ||
        selectedCenter == null ||
        selectedStage == null) {
      emit(
        state.copyWith(
          isLoadingAllData: false,
          allData: null,
          error: 'Missing selection data.',
        ),
      );
      return;
    }
    try {
      final dashboardData = await repository.getDashboardData(
        selectedSeason!,
        selectedCenter!,
        selectedStage!,
      );
      if (isClosed) return;
      emit(state.copyWith(isLoadingAllData: false, allData: dashboardData));
    } catch (e, stackTrace) {
      if (isClosed) return;

      emit(
        state.copyWith(
          isLoadingAllData: false,
          error: '$stackTrace $e',
          allData: null,
        ),
      );
    }
  }

  Future<void> initHomeData() async {
    emit(state.copyWith(isLoadingAllData: true, allData: null));
    try {
      final permNo = await storage.read(key: 'fPermNo');
      final user = await storage.read(key: 'userId');
      final seasons = await repository.fetchSeasons();
      final centers = await repository.getCenters();
      final stages = await repository.getStages();

      selectedSeason =
          seasons.isNotEmpty ? seasons.last.fSeasonId.toString() : null;
      selectedCenter =
          centers.isNotEmpty ? centers.first.fCenterNo.toString() : null;
      selectedStage =
          stages.isNotEmpty ? stages.first.fStageNo.toString() : null;
      fPermNo = permNo;
      userId = user;
      emit(
        state.copyWith(
          isLoadingAllData: false,
          seasons: seasons,
          centers: centers,
          stages: stages,
        ),
      );

      if (selectedSeason != null &&
          selectedCenter != null &&
          selectedStage != null) {
        final dashboardData = await repository.getDashboardData(
          selectedSeason!,
          selectedCenter!,
          selectedStage!,
        );
        emit(state.copyWith(isLoadingAllData: false, allData: dashboardData));
      }

      emit(state.copyWith(isLoadingAllData: false, allData: null));
    } catch (e, stackTrace) {
      emit(
        state.copyWith(
          isLoadingAllData: false,
          error: '$stackTrace $e',
          allData: null,
        ),
      );
    }
  }
}
