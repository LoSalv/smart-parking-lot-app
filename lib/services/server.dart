import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smart_parking_lot_app/services/ParkingInfo.dart';

import 'LogEntry.dart';

class Server {
  static Future<List<ParkingInfo>> getParkingsStatus() async {
    try {
      http.Response response = await http.get(
        Uri.parse('http://10.0.2.2:8124/parklot'),
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

  static Future<List<LogEntry>> getGateLog(
      [int? fromWhen, String? plate]) async {
    try {
      String url = 'http://10.0.2.2:8124/gate';

      if (fromWhen != null && plate != null) {
        print('asking for logs by time and plate');
        url = url + '/multiple/$fromWhen/$plate';
      } else if (fromWhen != null && plate == null) {
        print('asking for logs by time');
        url = url + '/time/$fromWhen';
      } else if (fromWhen == null && plate != null) {
        print('asking for logs by plate');
        url = url + '/plate/$plate';
      } else /*fromWhen == null and plate == null*/ {
        print('asking all logs');
        //change nothing
      }

      print(url);

      http.Response response = await http.get(
        Uri.parse(url),
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
