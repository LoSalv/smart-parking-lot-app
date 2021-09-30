import 'package:flutter/material.dart';
import 'package:smart_parking_lot_app/services/LogEntry.dart';
import 'package:smart_parking_lot_app/services/server.dart';

class GateTab extends StatefulWidget {
  const GateTab({Key? key}) : super(key: key);

  @override
  _GateTabState createState() => _GateTabState();
}

class _GateTabState extends State<GateTab> {
  String dropdownValue = 'Last 24 hours';
  String? filterPlate;
  int? fromWhen = -1;
  bool _waiting = true;
  List<LogEntry>? log;

  void _getLogEntries() async {
    setState(() {
      _waiting = true;
    });
    try {
      log = await Server.getGateLog(fromWhen, filterPlate);

      setState(() {
        _waiting = false;
      });
    } catch (err) {
      print(err);
    }
  }

  Future<void> _plateFilterDialog() async {
    String? plate;

    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filter for plate'),
          content: TextFormField(
            onChanged: (value) {
              plate = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                setState(() {
                  filterPlate = plate;
                  Navigator.of(context).pop();
                  _getLogEntries();
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    _getLogEntries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_waiting)
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
        backgroundColor: Theme.of(context).backgroundColor,
      );

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Text(
            'Gate Log',
            style: Theme.of(context).textTheme.headline1,
          ),
          Row(
            children: [
              SizedBox(
                width: 50,
              ),
              Expanded(
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(
                    Icons.arrow_downward,
                    color: Colors.deepPurpleAccent,
                  ),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.blue[400]),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                      switch (dropdownValue) {
                        case 'Last 24 hours':
                          fromWhen = -1;
                          break;
                        case 'Last 2 weeks':
                          fromWhen = -14;
                          break;
                        case 'Last 30 days':
                          fromWhen = -30;
                          break;
                      }
                      _getLogEntries();
                    });
                  },
                  items: <String>[
                    'Last 24 hours',
                    'Last 2 weeks',
                    'Last 30 days'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                width: 50,
              ),
              Expanded(
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        filterPlate == null
                            ? Colors.transparent
                            : Colors.white),
                  ),
                  onPressed: () {
                    _plateFilterDialog();
                  },
                  child: Text(
                    'Filter plate',
                  ),
                ),
              ),
              SizedBox(
                width: 50,
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
              itemCount: log?.length,
              itemBuilder: (BuildContext context, int index) {
                return ListItem(
                  logEntry: log![index].toString(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({Key? key, required this.logEntry}) : super(key: key);

  final String logEntry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Text(
        logEntry,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
