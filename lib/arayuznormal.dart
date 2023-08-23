import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

void main() => runApp(const Normal());

class Normal extends StatelessWidget {
  const Normal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BusOto',
      theme: ThemeData(fontFamily: 'Raleway'),
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text('BusOto',
            style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                fontSize: 30)),
        backgroundColor: Colors.blueGrey[900],
        bottom: TabBar(
          labelColor: Colors.blueGrey[900],
          unselectedLabelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.label,
          indicator: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: Colors.white),
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
                icon: Icon(Icons.directions_bus),
                child: Align(
                  alignment: Alignment.center,
                )),
            Tab(
                icon: Icon(Icons.map),
                child: Align(
                  alignment: Alignment.center,
                )),
          ],
        ),
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          ScreenOtobus(),
          ScreenMap(),
        ],
      ),
    );
  }
}

class ScreenOtobus extends StatefulWidget {
  const ScreenOtobus({Key? key}) : super(key: key);

  @override
  State<ScreenOtobus> createState() => _ScreenOtobus();
}

class _ScreenOtobus extends State<ScreenOtobus> {
  final dbHelper = DatabaseHelper.instance;

  TextEditingController txtYolcu = TextEditingController();

  final Yolcu = List<String>.filled(13, '');

  final DuraksID = List<String>.filled(13, '');
  final DuraksName = List<String>.filled(13, '');
  final DuraksLat = List<String>.filled(13, '');
  final DuraksLng = List<String>.filled(13, '');
  final DuraksYolcu = List<String>.filled(13, '');

  @override
  void dispose() {
    txtYolcu.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 10),
            SizedBox(height: 10),
            Text(
              "Konumunuzu Seçin.",
              style: TextStyle(
                fontSize: 25,
                color: Colors.blueGrey[900],
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: txtYolcu,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    borderSide: BorderSide(width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey),
                  ),
                  hintText: 'Bineceğiniz Durağı Seçin',
                ),
              ),
            ),
            Container(
              height: 50,
              width: 170,
              decoration: BoxDecoration(
                  color: Colors.blueGrey[900],
                  borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () {
                  DurakGuncelle();
                  Guncellendi(context);
                },
                child: Text(
                  'Yolcu Ekle',
                  style:
                      TextStyle(color: Colors.white, fontSize: 25, height: 1.2),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: 120,
              decoration: BoxDecoration(
                  color: Colors.blueGrey[900],
                  borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () {
                  DurakGoster();
                  Eklendi(context);
                },
                child: Text(
                  'Göster',
                  style:
                      TextStyle(color: Colors.white, fontSize: 25, height: 1.2),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 0.0),
              height: 200.0,
              child: ListView(
                children: new List.generate(
                  DuraksID.length - 1,
                  (index) => new ListTile(
                    title: Text('\nDurak İsmi: ' + DuraksName[index]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> DurakGoster() async {
    final allRows = await dbHelper.queryAllRows();

    for (int a = 0; a < 15; a++) {
      DuraksName[a] = allRows![a]['name'].toString();
      print(allRows[a]['yolcu']);
    }
  }

  Future<void> DurakGuncelle() async {
    final allRows = await dbHelper.queryAllRows();

    int y1 = 0;

    for (int a = 0; a < 15; a++) {
      DuraksID[a] = allRows![a]['_id'].toString();
      DuraksName[a] = allRows[a]['name'].toString();
      DuraksLat[a] = allRows[a]['lat'].toString();
      DuraksLng[a] = allRows[a]['lng'].toString();
      DuraksYolcu[a] = allRows[a]['yolcu'].toString();

      if (DuraksName[a] == txtYolcu.text) {
        y1 = int.parse(DuraksYolcu[a]);
        y1++;
        print("sonra " + y1.toString());
        Map<String, dynamic> row = {
          DatabaseHelper.columnNameDurak: txtYolcu.text,
          DatabaseHelper.columnYolcuDurak: y1.toString(),
        };
        final rowsAffected = await dbHelper.update2(row);
        print('updated $rowsAffected row(s)');
      }

    }


  }

  Eklendi(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("Tamam"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Durak"),
      content: Text("Konumlar Gösteriliyor."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Guncellendi(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("Tamam"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Otobüs"),
      content: Text("Otobüsler Güncellendi."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class ScreenMap extends StatefulWidget {
  const ScreenMap({Key? key}) : super(key: key);

  @override
  State<ScreenMap> createState() => _ScreenMap();
}

class _ScreenMap extends State<ScreenMap> {
  @override
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    DurakGoster();
    super.initState();
  }

  final dbHelper = DatabaseHelper.instance;

  final Set<Marker> markers = new Set();
  static const LatLng showLocation =
      const LatLng(27.7089427, 85.3086209); //location to show in map

  final DuraksID = List<String>.filled(13, '0');
  final DuraksName = List<String>.filled(13, '0');
  final DuraksLat = List<String>.filled(13, '0');
  final DuraksLng = List<String>.filled(13, '0');
  final DuraksYolcu = List<String>.filled(13, '0');

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(40.7750, 29.9480),
    zoom: 12,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        markers: getmarkers(),
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: DurakGoster,
        label: Text("Gölcük'e git!"),
        icon: Icon(Icons.double_arrow),
      ),
    );
  }

  Future<void> DurakGoster() async {
    final allRows = await dbHelper.queryAllRows();
    print("DurakGoster");
    for (int a = 0; a < 12; a++) {
      DuraksID[a] = '0';
      DuraksName[a] = '0';
      DuraksLat[a] = '0';
      DuraksLng[a] = '0';
      DuraksYolcu[a] = '0';
    }
    for (int a = 0; a < 12; a++) {
      DuraksID[a] = allRows![a]['_id'].toString();
      DuraksName[a] = allRows[a]['name'].toString();
      DuraksLat[a] = allRows[a]['lat'].toString();
      DuraksLng[a] = allRows[a]['lng'].toString();
      DuraksYolcu[a] = allRows[a]['yolcu'].toString();
    }

    getmarkers();
  }

  Set<Marker> getmarkers() {
    setState(() {
      for (int a = 0; a < DuraksID.length; a++) {
        if (DuraksYolcu[a] != '0') {
          print("GetMarkers " + DuraksName[a] + DuraksYolcu[a]);
          markers.add(Marker(
            markerId: MarkerId(DuraksID[a].toString()),
            position:
                LatLng(double.parse(DuraksLat[a]), double.parse(DuraksLng[a])),
            infoWindow: InfoWindow(
              title: DuraksName[a],
              snippet: DuraksYolcu[a],
            ),
            icon: BitmapDescriptor.defaultMarker, //Icon for Marker
          ));
        }
      }
      //add more markers here
    });

    return markers;
  }
}
