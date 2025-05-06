part of 'get_current_location_cubit.dart';

@immutable
sealed class GetCurrentLocationState {}

final class GetCurrentLocationInitial extends GetCurrentLocationState {}

final class GetCurrentLocationLoading extends GetCurrentLocationState {}

final class GetCurrentLocationSuccess extends GetCurrentLocationState {
  GetCurrentLocationSuccess(this.position);
  final Position position;
}

final class GetCurrentLocationError extends GetCurrentLocationState {
  GetCurrentLocationError(this.error);
  final String error;
}
