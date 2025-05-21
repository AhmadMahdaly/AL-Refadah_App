import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alrefadah/features/services_pages/guides/add/models/add_guide_model.dart';
import 'package:alrefadah/features/services_pages/guides/main/cubit/guides_states.dart';
import 'package:alrefadah/features/services_pages/guides/main/repo/guides_repo.dart';
import 'package:alrefadah/features/services_pages/guides/update/models/update_guide_model.dart';

class GuidesCubit extends Cubit<GuidesState> {
  GuidesCubit() : super(GuidesState());
  final GuidesRepo repository = GuidesRepo();

  String? selectedSeason;
  String? selectedCenter;
  Future<void> fetchSeasons() async {
    emit(state.copyWith(isLoadingSeasons: true));
    try {
      final seasons = await repository.getSeasons();
      emit(state.copyWith(isLoadingSeasons: false, seasons: seasons));
    } catch (e) {
      emit(state.copyWith(isLoadingSeasons: false, error: 'حدث خطأ'));
    }
  }

  Future<void> fetchCenters() async {
    emit(state.copyWith(isLoadingCenters: true));
    try {
      final centers = await repository.getCenters();
      emit(state.copyWith(isLoadingCenters: false, centers: centers));
    } catch (e) {
      emit(state.copyWith(isLoadingCenters: false, error: 'حدث خطأ'));
    }
  }

  Future<void> fetchGuides() async {
    emit(state.copyWith(isLoadingGuides: true));
    try {
      final guides = await repository.fetchGuides();
      emit(state.copyWith(isLoadingGuides: false, guides: guides));
    } catch (e) {
      emit(state.copyWith(isLoadingGuides: false, error: 'حدث خطأ'));
    }
  }

  Future<void> addHajTransGuide(List<AddGuideModel> model) async {
    emit(state.copyWith(isLoadingAddGuides: true));
    try {
      await repository.addHajTransGuide(model);
      emit(state.copyWith(isLoadingAddGuides: false, isAddGuidesSuccess: true));
    } catch (e) {
      emit(state.copyWith(isLoadingAddGuides: false, error: 'حدث خطأ'));
    }
  }

  Future<void> updateHajTransGuide(UpateGuideModel model) async {
    emit(state.copyWith(isLoadingEditGuides: true));
    try {
      await repository.updateHajTransGuide(model);
      emit(
        state.copyWith(isLoadingEditGuides: false, isEditGuidesSuccess: true),
      );
    } catch (e) {
      emit(state.copyWith(isLoadingEditGuides: false, error: 'حدث خطأ'));
    }
  }

  Future<void> getGuideByCriteria(String selectedCenter) async {
    emit(
      state.copyWith(
        isLoadingGetByCriteria: true,
        guidesByCriteria: [],
        error: null,
      ),
    );
    try {
      final guides = await repository.getGuideByCriteria(
        selectedSeason!,
        selectedCenter,
      );
      emit(
        state.copyWith(
          isLoadingGetByCriteria: false,
          guidesByCriteria: guides,
          error: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingGetByCriteria: false,
          guidesByCriteria: [],
          error: e.toString().replaceAll('Exception: ', ''),
        ),
      );
    }
  }

  Future<void> deleteGuide(String selectedCenterId, String empNo) async {
    emit(
      state.copyWith(isLoadingdeleteGuide: true, isdeleteGuidesSuccess: false),
    );
    try {
      await repository.deleteGuideByCriteria(
        selectedSeason!,
        selectedCenterId,
        empNo,
      );
      emit(
        state.copyWith(
          isLoadingdeleteGuide: false,
          isdeleteGuidesSuccess: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingdeleteGuide: false,
          error: 'حدث خطأ',
          isdeleteGuidesSuccess: false,
        ),
      );
    }
  }
}
