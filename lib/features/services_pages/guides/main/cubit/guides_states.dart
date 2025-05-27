import 'package:alrefadah/features/services_pages/guides/add_emplyee/models/employee_response_model.dart';
import 'package:alrefadah/features/services_pages/guides/main/models/by_criteria/assignment_model.dart';
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
    this.isLoadingdeleteGuide = false,
    this.isdeleteGuidesSuccess = false,
    this.isLoadingAddEmpoloyee = false,
    this.isAddEmpoloyeeSuccess = false,
    this.isLoadingEmpData = false,
    this.centers = const [],
    this.seasons = const [],
    this.guides = const [],
    this.guidesByCriteria = const [],
    this.cities = const [],
    this.majors = const [],
    this.certificates = const [],
    this.banks = const [],
    this.nationalities = const [],
    this.error,
  });
  final bool isLoadingAddEmpoloyee;
  final bool isAddEmpoloyeeSuccess;
  final bool isLoadingCenters;
  final bool isLoadingSeasons;
  final bool isLoadingGuides;
  final bool isLoadingAddGuides;
  final bool isLoadingEditGuides;
  final bool isLoadingGetByCriteria;
  final bool isAddGuidesSuccess;
  final bool isEditGuidesSuccess;
  final bool isLoadingdeleteGuide;
  final bool isdeleteGuidesSuccess;
  final bool isLoadingEmpData;
  final List<EmpDataModel> cities;
  final List<EmpDataModel> majors;
  final List<EmpDataModel> certificates;
  final List<EmpDataModel> banks;
  final List<EmpDataModel> nationalities;
  final List<GetGuidesCenterModel> centers;
  final List<GetGuidesSeasonsModel> seasons;
  final List<GetGuidesModel> guides;
  final List<AssignmentModel> guidesByCriteria;
  final String? error;

  GuidesState copyWith({
    bool? isLoadingAddEmpoloyee,
    bool? isAddEmpoloyeeSuccess,
    bool? isLoadingCenters,
    bool? isLoadingSeasons,
    bool? isLoadingGuides,
    bool? isLoadingAddGuides,
    bool? isLoadingEditGuides,
    bool? isLoadingGetByCriteria,
    bool? isAddGuidesSuccess,
    bool? isEditGuidesSuccess,
    bool? isLoadingdeleteGuide,
    bool? isdeleteGuidesSuccess,
    bool? isLoadingEmpData,
    List<GetGuidesCenterModel>? centers,
    List<GetGuidesSeasonsModel>? seasons,
    List<GetGuidesModel>? guides,
    List<AssignmentModel>? guidesByCriteria,
    List<EmpDataModel>? cities,
    List<EmpDataModel>? majors,
    List<EmpDataModel>? certificates,
    List<EmpDataModel>? banks,
    List<EmpDataModel>? nationalities,
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
      isLoadingdeleteGuide: isLoadingdeleteGuide ?? this.isLoadingdeleteGuide,
      isdeleteGuidesSuccess:
          isdeleteGuidesSuccess ?? this.isdeleteGuidesSuccess,
      isLoadingAddEmpoloyee:
          isLoadingAddEmpoloyee ?? this.isLoadingAddEmpoloyee,
      isAddEmpoloyeeSuccess:
          isAddEmpoloyeeSuccess ?? this.isAddEmpoloyeeSuccess,
      cities: cities ?? this.cities,
      majors: majors ?? this.majors,
      certificates: certificates ?? this.certificates,
      banks: banks ?? this.banks,
      nationalities: nationalities ?? this.nationalities,
      isLoadingEmpData: isLoadingEmpData ?? this.isLoadingEmpData,
    );
  }
}
