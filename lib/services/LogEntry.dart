class LogEntry {
  String plate;
  DateTime datetime;

  LogEntry({
    required this.datetime,
    required this.plate,
  });

  String toString() {
    return 'datetime: ${this.datetime}, plate: ${this.plate}';
  }

  factory LogEntry.fromJson(Map<String, dynamic> json) {
    return LogEntry(
      datetime: DateTime.parse(json['datetime'].toString()),
      plate: json['plate'],
    );
  }
}
