class LogEntry {
  String plate;
  DateTime datetime;
  String direction;

  LogEntry({
    required this.datetime,
    required this.plate,
    required this.direction,
  });

  String toString() {
    return 'datetime: ${this.datetime}, plate: ${this.plate}, ' +
        'direction: ${this.direction}';
  }

  factory LogEntry.fromJson(Map<String, dynamic> json) {
    return LogEntry(
        datetime: DateTime.parse(json['datetime'].toString()),
        plate: json['plate'],
        direction: json['direction']);
  }
}
