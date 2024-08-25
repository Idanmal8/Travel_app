import 'dart:convert';

class RouteModel {
  final String? start;
  final String? end;
  final String polyline;
  final int distanceMeters;
  final String duration;
  RouteModel({
    this.start,
    this.end,
    required this.polyline,
    required this.distanceMeters,
    required this.duration,
  });

  RouteModel copyWith({
    String? start,
    String? end,
    String? polyline,
    int? distanceMeters,
    String? duration,
  }) {
    return RouteModel(
      start: start ?? this.start,
      end: end ?? this.end,
      polyline: polyline ?? this.polyline,
      distanceMeters: distanceMeters ?? this.distanceMeters,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'start': start,
      'end': end,
      'polyline': polyline,
      'distanceMeters': distanceMeters,
      'duration': duration,
    };
  }

  factory RouteModel.fromMap(Map<String, dynamic> map) {
    return RouteModel(
      polyline: map['polyline'] as String,
      distanceMeters: map['distanceMeters'] as int,
      duration: map['duration'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RouteModel.fromJson(String source) => RouteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RouteModel(start: $start, end: $end, polyline: $polyline, distanceMeters: $distanceMeters, duration: $duration)';
  }

  @override
  bool operator ==(covariant RouteModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.start == start &&
      other.end == end &&
      other.polyline == polyline &&
      other.distanceMeters == distanceMeters &&
      other.duration == duration;
  }

  @override
  int get hashCode {
    return start.hashCode ^
      end.hashCode ^
      polyline.hashCode ^
      distanceMeters.hashCode ^
      duration.hashCode;
  }
}
