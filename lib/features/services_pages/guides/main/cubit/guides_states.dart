import 'package:alrefadah/features/services_pages/guides/main/models/get_centers_model.dart';
import 'package:alrefadah/features/services_pages/guides/main/models/get_guide_model.dart';
import 'package:alrefadah/features/services_pages/guides/main/models/get_seasons_model.dart';

class GuidesState {
  GuidesState({
    this.isLoadingCenters = false,
    this.isLoadingSeasons = false,
    this.isLoadingGuides = false,
    this.isLoadingAddGuides = false,
    this.isAddGuidesSuccess = false,
    this.isEditGuidesSuccess = false,
    this.isLoadingEditGuides = false,
    this.isLoadingGetByCriteria = false,
    this.centers = const [],
    this.seasons = const [],
    this.guides = const [],
    this.guidesByCriteria = const [],
    this.error,
  });
  final bool isLoadingCenters;
  final bool isLoadingSeasons;
  final bool isLoadingGuides;
  final bool isLoadingAddGuides;
  final bool isLoadingEditGuides;
  final bool isLoadingGetByCriteria;
  final bool isAddGuidesSuccess;
  final bool isEditGuidesSuccess;
  final List<GetGuidesCenterModel> centers;
  final List<GetGuidesSeasonsModel> seasons;
  final List<GetGuidesModel> guides;
  final List<GetGuidesModel> guidesByCriteria;
  final String? error;
  GuidesState copyWith({
    bool? isLoadingCenters,
    bool? isLoadingSeasons,
    bool? isLoadingGuides,
    bool? isLoadingAddGuides,
    bool? isLoadingEditGuides,
    bool? isLoadingGetByCriteria,
    bool? isAddGuidesSuccess,
    bool? isEditGuidesSuccess,
    List<GetGuidesCenterModel>? centers,
    List<GetGuidesSeasonsModel>? seasons,
    List<GetGuidesModel>? guides,
    List<GetGuidesModel>? guidesByCriteria,
    String? error,
  }) {
    return GuidesState(
      isLoadingCenters: isLoadingCenters ?? this.isLoadingCenters,
      isLoadingSeasons: isLoadingSeasons ?? this.isLoadingSeasons,
      isLoadingGuides: isLoadingGuides ?? this.isLoadingGuides,
      isLoadingAddGuides: isLoadingAddGuides ?? this.isLoadingAddGuides,
      isLoadingEditGuides: isLoadingEditGuides ?? this.isLoadingEditGuides,
      isLoadingGetByCriteria:
          isLoadingGetByCriteria ?? this.isLoadingGetByCriteria,
      isAddGuidesSuccess: isAddGuidesSuccess ?? this.isAddGuidesSuccess,
      isEditGuidesSuccess: isEditGuidesSuccess ?? this.isEditGuidesSuccess,
      centers: centers ?? this.centers,
      seasons: seasons ?? this.seasons,
      guides: guides ?? this.guides,
      guidesByCriteria: guidesByCriteria ?? this.guidesByCriteria,
      error: error ?? this.error,
    );
  }
}
