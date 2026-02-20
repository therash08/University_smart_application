class BusSchedule {
  final int routeId;
  final String location;
  final String time;
  final int busCount;
  final String direction;

  BusSchedule({
    required this.routeId,
    required this.location,
    required this.time,
    required this.busCount,
    required this.direction,
  });

  factory BusSchedule.fromJson(Map<String, dynamic> json, String location) {
    return BusSchedule(
      routeId: json['route_id'],
      location: location,
      time: json['time'],
      busCount: json['bus_count'],
      direction: json['direction'],
    );
  }
}
