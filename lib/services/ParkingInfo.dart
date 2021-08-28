class ParkingInfo {
  final int parkNumber;
  final String status;

  ParkingInfo({
    required this.parkNumber,
    required this.status,
  });

  String toString() {
    return 'park number ${this.parkNumber} is ${this.status}';
  }

  factory ParkingInfo.fromJson(Map<String, dynamic> json) {
    return ParkingInfo(
      parkNumber: json['_id'],
      status: json['free'] ? 'free' : 'occupied',
    );
  }
}
