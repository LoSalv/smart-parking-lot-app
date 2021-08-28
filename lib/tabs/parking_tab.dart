import 'package:flutter/material.dart';
import 'package:smart_parking_lot_app/services/ParkingInfo.dart';

class ParkingTab extends StatelessWidget {
  const ParkingTab({
    Key? key,
    required this.numberOfFreeSpaces,
    required this.statuses,
  }) : super(key: key);

  final int numberOfFreeSpaces;
  final List<ParkingInfo>? statuses;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                'Parkings',
                style: Theme.of(context).textTheme.headline1,
              ),
              Text(
                'There $numberOfFreeSpaces free parking spaces.',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                  itemCount: statuses?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListItem(
                      info: statuses![index],
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.info,
  }) : super(key: key);

  final ParkingInfo info;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(info.parkNumber.toString(),
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontSize: 30,
                )),
        SizedBox(
          width: 10,
        ),
        Text(
          info.status,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}
