import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'get_current_location_state.dart';

class GetCurrentLocationCubit extends Cubit<GetCurrentLocationState> {
  GetCurrentLocationCubit() : super(GetCurrentLocationInitial());

  Future<Position?> getCurrentLocation() async {
    emit(GetCurrentLocationLoading());
    try {
      final status = await Permission.location.request();
      if (status.isGranted) {
        final position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
          ),
        );
        if (state is! GetCurrentLocationSuccess ||
            (state as GetCurrentLocationSuccess).position != position) {
          emit(GetCurrentLocationSuccess(position));
        }
        return position;
      } else {
        emit(GetCurrentLocationError(status.toString()));
        return null;
      }
    } catch (e) {
      emit(GetCurrentLocationError(e.toString()));
      return null;
    }
  }
}
