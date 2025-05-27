import 'package:flutter/foundation.dart';

@immutable
class TrackModel {
  const TrackModel({ this.fTrackNo, this.fTrackName, this.fTrackNameE});

  factory TrackModel.fromJson(Map<String, dynamic> json) {
    return TrackModel(
      fTrackNo:
          json['fTrackNo']as int,
      fTrackName: json['fTrackName'].toString(),
      fTrackNameE: json['fTrackNameE'].toString(),
    );
  }

  final int? fTrackNo;
  final String? fTrackName;
  final String? fTrackNameE;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrackModel &&
          runtimeType == other.runtimeType &&
          fTrackNo == other.fTrackNo;

  @override
  int get hashCode => fTrackNo.hashCode;
}
