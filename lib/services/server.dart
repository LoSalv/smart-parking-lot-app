import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smart_parking_lot_app/services/ParkingInfo.dart';

import 'LogEntry.dart';

class Server {
  static Future<List<ParkingInfo>> getParkingsStatus() async {
    try {
      http.Response response = await http.get(
        Uri.parse('http://lordip.ddns.net:8124/parklot'),
      );
      final List resultList = jsonDecode(response.body.toString());
      List<ParkingInfo> statuses =
          resultList.map<ParkingInfo>((x) => ParkingInfo.fromJson(x)).toList();
      statuses.sort((a, b) => a.parkNumber.compareTo(b.parkNumber));
      return statuses;
    } catch (err) {
      print(err);
      throw err;
    }
  }

  static Future<List<LogEntry>> getGateLog() async {
    try {
      http.Response response = await http.get(
        Uri.parse('http://lordip.ddns.net:8124/gate'),
      );
      final List resultList = jsonDecode(response.body.toString());
      List<LogEntry> log =
          resultList.map<LogEntry>((x) => LogEntry.fromJson(x)).toList();
      log.sort((a, b) => a.datetime.compareTo(b.datetime));
      return log;
    } catch (err) {
      print(err);
      throw err;
    }
  }
}
