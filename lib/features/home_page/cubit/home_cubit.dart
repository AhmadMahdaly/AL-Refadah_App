import 'package:alrefadah/features/home_page/cubit/home_states.dart';
import 'package:alrefadah/features/home_page/repo/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.repository) : super(HomeState());
  final HomeRepo repository;
  int? selectedSeason;
  int? selectedCenter;
  int? selectedStage;
  int? selectedTrack;
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

  Future<void> getTracks() async {
    emit(state.copyWith(isLoadingTracks: true));
    try {
      final tracks = await repository.getTracks();
      if (isClosed) return;
      emit(state.copyWith(isLoadingTracks: false, tracks: tracks));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(isLoadingTracks: false, error: e.toString()));
    }
  }

  Future<void> getDashboardData() async {
    emit(state.copyWith(isLoadingAllData: true));
    try {
      if (selectedSeason == null &&
          selectedCenter == null &&
          selectedTrack == null &&
          selectedStage == null) {
        emit(
          state.copyWith(
            isLoadingAllData: false,
            allData: null,
            error: 'Missing selection data.',
          ),
        );
      }
      final dashboardData = await repository.getDashboardData(
        selectedSeason!,
        selectedCenter!,
        selectedStage!,
        selectedTrack!,
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
      final tracks = await repository.getTracks();

      selectedSeason = seasons.last.fSeasonId;
      selectedCenter = centers.first.fCenterNo;
      selectedStage = stages.first.fStageNo;
      selectedTrack = tracks.first.fTrackNo;
      fPermNo = permNo;
      userId = user;
      emit(
        state.copyWith(
          isLoadingAllData: false,
          seasons: seasons,
          centers: centers,
          stages: stages,
          tracks: tracks,
        ),
      );

      if (selectedSeason != null &&
          selectedCenter != null &&
          selectedTrack != null &&
          selectedStage != null) {
        final dashboardData = await repository.getDashboardData(
          selectedSeason!,
          selectedCenter!,
          selectedStage!,
          selectedTrack!,
        );
        emit(state.copyWith(isLoadingAllData: false, allData: dashboardData));
      }
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
