import 'package:flutter/material.dart';
import 'package:smart_parking_lot_app/services/ParkingInfo.dart';
import 'package:smart_parking_lot_app/tabs/gate_tab.dart';
import 'package:smart_parking_lot_app/tabs/parking_tab.dart';
import 'services/LogEntry.dart';
import 'services/server.dart';

void main() {
  runApp(MyApp());
}

List<ParkingInfo>? statuses;
List<LogEntry>? log;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          backgroundColor: const Color(0xFF344055),
          accentColor: const Color(0xFFF0A202),
          primaryColor: const Color(0xFF888098),
          textTheme: const TextTheme(
            headline1: const TextStyle(
              fontSize: 56,
              color: const Color(0xFFDFC2F2),
              fontWeight: FontWeight.w400,
            ),
            bodyText1: const TextStyle(
              fontSize: 18,
              // color: const Color(0xFFCFB3CD),
              color: Colors.white,
            ),
            bodyText2: const TextStyle(
              fontSize: 18,
              color: const Color(0xFF266DD3),
            ),
          )),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  bool _waiting = true;

  TabController? _tabController;

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController?.addListener(_handleTabSelection);
    getInfo();

    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void getInfo() async {
    setState(() {
      _waiting = true;
    });

    try {
      statuses = await Server.getParkingsStatus();

      setState(() {
        _waiting = false;
      });
    } catch (err) {
      print(err);
    }
  }

  int getNumberOfFreeSpaces() {
    int result = 0;
    for (ParkingInfo i in statuses!) {
      if (i.status == 'free') result++;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    if (_waiting)
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
        backgroundColor: Theme.of(context).backgroundColor,
      );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Center(
          child: Container(
            width: 600,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Scaffold(
              bottomNavigationBar: BottomAppBar(
                color: const Color(0xFF266DD3),
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: Theme.of(context).accentColor,
                  tabs: [
                    Tab(
                      text: 'Parks',
                    ),
                    Tab(
                      text: 'Gate',
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  getInfo();
                },
                child: Icon(
                  Icons.cached,
                  size: 40,
                  color: Color(0xFFDFC2F2),
                ),
                backgroundColor: const Color(0xFF266DD3),
              ),
              body: TabBarView(
                controller: _tabController,
                children: [
                  ParkingTab(
                    numberOfFreeSpaces: getNumberOfFreeSpaces(),
                    statuses: statuses,
                  ),
                  GateTab(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
