import 'package:flutter/material.dart';
import 'package:smart_parking_lot_app/services/ParkingInfo.dart';

class ParkingTab extends StatefulWidget {
  ParkingTab({
    Key? key,
    required this.numberOfFreeSpaces,
    required this.statuses,
  }) : super(key: key);

  final int numberOfFreeSpaces;
  final List<ParkingInfo>? statuses;
  bool _viewOnlyFree = false;

  @override
  _ParkingTabState createState() => _ParkingTabState();
}

class _ParkingTabState extends State<ParkingTab> {
  @override
  Widget build(BuildContext context) {
    List<ParkingInfo>? freeParkInfoList = [];

    for (ParkingInfo info in widget.statuses!) {
      if (info.status == 'free') freeParkInfoList.add(info);
    }

    List<Widget> getListGrid() {
      List<ParkingInfo>? list;

      list = widget._viewOnlyFree ? freeParkInfoList : widget.statuses;

      return List.generate(
        list!.length,
        (index) => ListItem(info: list![index]),
      );
    }

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
                'There ${widget.numberOfFreeSpaces} free parking spaces.',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    widget._viewOnlyFree = !widget._viewOnlyFree;
                  });
                },
                child: Text(
                    widget._viewOnlyFree ? 'Show all' : 'Show only free parks'),
              ),
              Expanded(
                // child: ListView.builder(
                //   padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                //   itemCount: statuses?.length,
                //   itemBuilder: (BuildContext context, int index) {
                //     return ListItem(
                //       info: statuses![index],
                //     );
                //   },
                // ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.count(
                    // Create a grid with 2 columns. If you change the scrollDirection to
                    // horizontal, this produces 2 rows.
                    crossAxisCount: 8,
                    // Generate 100 widgets that display their index in the List.
                    children: getListGrid(),
                  ),
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
    // return Row(
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: [
    //     Text(info.parkNumber.toString(),
    //         style: Theme.of(context).textTheme.bodyText2?.copyWith(
    //               fontSize: 30,
    //             )),
    //     SizedBox(
    //       width: 10,
    //     ),
    //     Text(
    //       info.status,
    //       style: Theme.of(context).textTheme.bodyText1,
    //     ),
    //   ],
    // );
    return Card(
      color: info.status == 'free' ? Colors.green : Colors.red,
      child: Center(
        child: Text(
          info.parkNumber.toString(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
