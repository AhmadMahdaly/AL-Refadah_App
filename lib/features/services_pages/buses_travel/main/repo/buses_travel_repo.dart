import 'package:alrefadah/core/services/dio_helper.dart';
import 'package:alrefadah/data/constants_variable.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/add_trip_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/track_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/trip_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/models/get_buses_travel_centers_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/models/get_buses_travel_seasons_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/models/get_buses_travel_trip_model.dart';
import 'package:alrefadah/features/services_pages/complaint/models/add_complaint_model.dart';
import 'package:alrefadah/features/services_pages/complaint/models/complaint_model.dart';
import 'package:alrefadah/features/services_pages/complaint/models/complaint_type_model.dart';
import 'package:dio/dio.dart';

class BusesTravelRepo {
  Future<List<BusesTravelGetSeasonModel>> getSeasons() async {
    try {
      final response = await DioHelper.dio.get<List<dynamic>>(
        '/BusesTravel/GetSeasons',
      );
      final data = response.data!;

      return data
          .map(
            (json) => BusesTravelGetSeasonModel.fromJson(
              json as Map<String, dynamic>,
            ),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<List<BusesTravelGetCenterModel>> getCenters() async {
    try {
      final response = await DioHelper.dio.get<List<dynamic>>(
        '/BusesTravel/GetCenters',
      );
      final data = response.data!;
      return data
          .map(
            (item) => BusesTravelGetCenterModel.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<List<BusesTravelGetTripModel>> getTrips(
    String seasonId,
    String centerNo,
  ) async {
    try {
      final response = await DioHelper.dio.get<List<dynamic>>(
        '/BusesTravel/GetHajTransportTrip/Trip?SeasonId=$seasonId&CenterNo=$centerNo&CompanyId=$companyId',
      );
      final data = response.data!;
      return data
          .map(
            (item) =>
                BusesTravelGetTripModel.fromJson(item as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<List<TripModel>> getTripsByStage(
    String seasonId,
    String centerNo,
    String stageNo,
  ) async {
    try {
      final response = await DioHelper.dio.get<List<dynamic>>(
        '/BusesTravel/GetHajTransportTripsByStage/TripsByStage?SeasonId=$seasonId&CenterNo=$centerNo&StageNo=$stageNo&CompanyId=$companyId',
      );
      final data = response.data!;
      // log(data.toString());
      return data
          .map((item) => TripModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<void> addTripByStage(AddTripModel inputs) async {
    try {
      await DioHelper.dio.post<Map<String, dynamic>>(
        '/BusesTravel/AddHajTransportTrip/Trip',
        data: inputs.toJson(),
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data);
    }
  }

  Future<void> editTripByStage(AddTripModel inputs) async {
    try {
      await DioHelper.dio.put<Map<String, dynamic>>(
        '/BusesTravel/UpdateHajTransportTrip/Trip',
        data: inputs.toJson(),
      );
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<void> deleteTripByStage(
    String tripNo,
    String seasonId,
    String centerNo,
    String stageNo,
  ) async {
    try {
      await DioHelper.dio.delete<Map<String, dynamic>>(
        '/BusesTravel/DeleteHajTransportTrip/Trip?tripNo=$tripNo&companyId=$companyId&seasonId=$seasonId&centerNo=$centerNo&stageNo=$stageNo',
      );
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<List<TripModel>> getIncomingTrips(
    String seasonId,
    String centerNo,
    String stageNo,
  ) async {
    try {
      final response = await DioHelper.dio.get<List<dynamic>>(
        '/BusesTravel/GetHajTransportTripIncomingByStage/TripIncomingByStage?SeasonId=$seasonId&CenterNo=$centerNo&StageNo=$stageNo&CompanyId=$companyId',
      );
      final data = response.data!;
      return data
          .map((json) => TripModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<List<TripModel>> getTripArrivingByStage(
    String seasonId,
    String centerNo,
    String stageNo,
  ) async {
    try {
      final response = await DioHelper.dio.get<List<dynamic>>(
        '/BusesTravel/GetHajTransportTripArrivingByStage/TripArrivingByStage?SeasonId=$seasonId&CenterNo=$centerNo&StageNo=$stageNo&CompanyId=$companyId',
      );
      final data = response.data!;
      return data
          .map((json) => TripModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<List<TrackModel>> getTrackTrip() async {
    try {
      final response = await DioHelper.dio.get<List<dynamic>>(
        '/BusesTravel/GetTrack',
      );
      final data = response.data!;
      return data
          .map((json) => TrackModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<List<ComplaintTypeModel>> getComplaintType() async {
    try {
      final response = await DioHelper.dio.get<List<dynamic>>(
        '/HajComplaints/GetComplaintsType',
      );
      final data = response.data!;
      return data
          .map(
            (json) => ComplaintTypeModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<void> addComplaint(AddComplaintModel inputs) async {
    try {
      await DioHelper.dio.post<Map<String, dynamic>>(
        '/HajComplaints/AddComplaint',
        data: inputs.toJson(),
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data);
    }
  }

  Future<List<ComplaintModel>> getComplaint(
    String centerNo,
    String complaintStatus,
  ) async {
    try {
      final response = await DioHelper.dio.get<List<dynamic>>(
        '/HajComplaints/GetComplaints?centerNo=$centerNo&complaintStatus=$complaintStatus',
      );
      final data = response.data!;
      return data
          .map((json) => ComplaintModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }
}
