import 'package:flutter/material.dart';
import 'package:smart_parking_lot_app/services/LogEntry.dart';

class GateTab extends StatelessWidget {
  const GateTab({Key? key, this.log}) : super(key: key);

  final List<LogEntry>? log;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Text(
            'Gate Log',
            style: Theme.of(context).textTheme.headline1,
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
    return Text(
      logEntry,
      style: Theme.of(context).textTheme.bodyText1,
    );
  }
}
