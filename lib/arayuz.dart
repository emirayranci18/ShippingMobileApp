import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'database.dart';
import 'main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

void main() => runApp(const Admin());

var basiskelelat = 40.7381;
var basiskelelng = 30.0001;

var cayirlat = 40.8253;
var cayirlng = 29.3770;

var daricalat = 40.7747;
var daricalng = 29.4008;

var derincelat = 40.7562;
var derincelng = 29.8309;

var dilovasilat = 40.7851;
var dilovasilng = 29.5413;

var gebzelat = 40.8038;
var gebzelng = 29.4403;

var golcuklat = 40.7177;
var golcuklng = 29.8193;

var izmitlat = 40.7750;
var izmitlng = 29.9480;

var kandiralat = 41.0702;
var kandiralng = 30.1540;

var karamursellat = 40.6920;
var karamursellng = 29.6167;

var kartepelat = 40.7533;
var kartepelng = 30.0224;

var korfezlat = 40.7757;
var korfezlng = 29.7380;

class Admin extends StatelessWidget {
  const Admin({Key? key}) : super(key: key);

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
    _tabController = TabController(length: 4, vsync: this);
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
                icon: Icon(Icons.emoji_people),
                child: Align(
                  alignment: Alignment.center,
                )),
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
            Tab(
                icon: Icon(Icons.do_disturb_on),
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
          ScreenYolcu(),
          ScreenOtobus(),
          ScreenMap(),
          ScreenDurak(),
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

  final Bus1 = List<String>.filled(13, '');
  final Bus2 = List<String>.filled(13, '');
  final Bus3 = List<String>.filled(13, '');

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
              "Otobüs ekle.",
              style: TextStyle(
                fontSize: 35,
                color: Colors.blueGrey[900],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: 10),
                SizedBox(height: 10),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[900],
                      borderRadius: BorderRadius.circular(10)),
                  child: FlatButton(
                    onPressed: () {
                      Ekle25();
                      Eklendi(context);
                    },
                    child: Text(
                      '25 Kişilik\nEkle',
                      style: TextStyle(
                          color: Colors.white, fontSize: 20, height: 1.2),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[900],
                      borderRadius: BorderRadius.circular(10)),
                  child: FlatButton(
                    onPressed: () {
                      Sil25();
                      Silindi(context);
                    },
                    child: Text(
                      '25 Kişilik\nSil',
                      style: TextStyle(
                          color: Colors.white, fontSize: 20, height: 1.2),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Otobüs 1: ' + Bus1[0],
                  style: TextStyle(
                      color: Colors.blueGrey[900], fontSize: 30, height: 1.2),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: 10),
                SizedBox(height: 10),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[900],
                      borderRadius: BorderRadius.circular(10)),
                  child: FlatButton(
                    onPressed: () {
                      Ekle30();
                      Eklendi(context);
                    },
                    child: Text(
                      '30 Kişilik\nEkle',
                      style: TextStyle(
                          color: Colors.white, fontSize: 20, height: 1.2),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[900],
                      borderRadius: BorderRadius.circular(10)),
                  child: FlatButton(
                    onPressed: () {
                      Sil30();
                      Silindi(context);
                    },
                    child: Text(
                      '30 Kişilik\nSil',
                      style: TextStyle(
                          color: Colors.white, fontSize: 20, height: 1.2),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Otobüs 2: ' + Bus2[0],
                  style: TextStyle(
                      color: Colors.blueGrey[900], fontSize: 30, height: 1.2),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: 10),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[900],
                      borderRadius: BorderRadius.circular(10)),
                  child: FlatButton(
                    onPressed: () {
                      Ekle40();
                      Eklendi(context);
                    },
                    child: Text(
                      '40 Kişilik\nEkle',
                      style: TextStyle(
                          color: Colors.white, fontSize: 20, height: 1.2),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[900],
                      borderRadius: BorderRadius.circular(10)),
                  child: FlatButton(
                    onPressed: () {
                      Sil40();
                      Silindi(context);
                    },
                    child: Text(
                      '40 Kişilik\nSil',
                      style: TextStyle(
                          color: Colors.white, fontSize: 20, height: 1.2),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Otobüs 3: ' + Bus3[0],
                  style: TextStyle(
                      color: Colors.blueGrey[900], fontSize: 30, height: 1.2),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: 10),
                Container(
                  height: 100,
                  width: 208,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[900],
                      borderRadius: BorderRadius.circular(10)),
                  child: FlatButton(
                    onPressed: () {
                      DurakGoster();
                      Guncellendi(context);
                    },
                    child: Text(
                      'Göster',
                      style: TextStyle(
                          color: Colors.white, fontSize: 35, height: 1.2),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  height: 100,
                  width: 170,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[900],
                      borderRadius: BorderRadius.circular(10)),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Ekleme()),
                      );
                    },
                    child: Icon(Icons.supervisor_account,color: Colors.white, size: 75,),

                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> DurakGoster() async {
    final allRows = await dbHelper.queryAllRows3();

    Bus1[0] = allRows![0]['bus1'].toString();
    Bus2[0] = allRows[0]['bus2'].toString();
    Bus3[0] = allRows[0]['bus3'].toString();

    print(allRows);
  }

  Future<void> Ekle25() async {
    final allRows = await dbHelper.queryAllRows3();

    Bus1[0] = allRows![0]['bus1'].toString();
    Bus2[0] = allRows[0]['bus2'].toString();
    Bus3[0] = allRows[0]['bus3'].toString();

    int Bus1int = int.parse(Bus1[0]);
    int Bus2int = int.parse(Bus2[0]);
    int Bus3int = int.parse(Bus3[0]);

    print("önce " + Bus1int.toString());
    Bus1int++;
    Map<String, dynamic> row = {
      DatabaseHelper.columnBus1: Bus1int.toString(),
      DatabaseHelper.columnBus2: Bus2int.toString(),
      DatabaseHelper.columnBus3: Bus3int.toString(),
    };
    print("sonra " + Bus1int.toString());
    final rowsAffected = await dbHelper.update3(row);
  }

  Future<void> Sil25() async {
    final allRows = await dbHelper.queryAllRows3();

    Bus1[0] = allRows![0]['bus1'].toString();
    Bus2[0] = allRows[0]['bus2'].toString();
    Bus3[0] = allRows[0]['bus3'].toString();

    int Bus1int = int.parse(Bus1[0]);
    int Bus2int = int.parse(Bus2[0]);
    int Bus3int = int.parse(Bus3[0]);

    print("önce " + Bus1int.toString());
    Bus1int--;
    Map<String, dynamic> row = {
      DatabaseHelper.columnBus1: Bus1int.toString(),
      DatabaseHelper.columnBus2: Bus2int.toString(),
      DatabaseHelper.columnBus3: Bus3int.toString(),
    };
    print("sonra " + Bus1int.toString());
    final rowsAffected = await dbHelper.update3(row);
  }

  Future<void> Ekle30() async {
    final allRows = await dbHelper.queryAllRows3();

    Bus1[0] = allRows![0]['bus1'].toString();
    Bus2[0] = allRows[0]['bus2'].toString();
    Bus3[0] = allRows[0]['bus3'].toString();

    int Bus1int = int.parse(Bus1[0]);
    int Bus2int = int.parse(Bus2[0]);
    int Bus3int = int.parse(Bus3[0]);

    print("önce " + Bus2int.toString());
    Bus2int++;
    Map<String, dynamic> row = {
      DatabaseHelper.columnBus1: Bus1int.toString(),
      DatabaseHelper.columnBus2: Bus2int.toString(),
      DatabaseHelper.columnBus3: Bus3int.toString(),
    };
    print("sonra " + Bus2int.toString());
    final rowsAffected = await dbHelper.update3(row);
  }

  Future<void> Sil30() async {
    final allRows = await dbHelper.queryAllRows3();

    Bus1[0] = allRows![0]['bus1'].toString();
    Bus2[0] = allRows[0]['bus2'].toString();
    Bus3[0] = allRows[0]['bus3'].toString();

    int Bus1int = int.parse(Bus1[0]);
    int Bus2int = int.parse(Bus2[0]);
    int Bus3int = int.parse(Bus3[0]);

    print("önce " + Bus2int.toString());
    Bus2int--;
    Map<String, dynamic> row = {
      DatabaseHelper.columnBus1: Bus1int.toString(),
      DatabaseHelper.columnBus2: Bus2int.toString(),
      DatabaseHelper.columnBus3: Bus3int.toString(),
    };
    print("sonra " + Bus2int.toString());
    final rowsAffected = await dbHelper.update3(row);
  }

  Future<void> Ekle40() async {
    final allRows = await dbHelper.queryAllRows3();

    Bus1[0] = allRows![0]['bus1'].toString();
    Bus2[0] = allRows[0]['bus2'].toString();
    Bus3[0] = allRows[0]['bus3'].toString();

    int Bus1int = int.parse(Bus1[0]);
    int Bus2int = int.parse(Bus2[0]);
    int Bus3int = int.parse(Bus3[0]);

    print("önce " + Bus3int.toString());
    Bus3int++;
    Map<String, dynamic> row = {
      DatabaseHelper.columnBus1: Bus1int.toString(),
      DatabaseHelper.columnBus2: Bus2int.toString(),
      DatabaseHelper.columnBus3: Bus3int.toString(),
    };
    print("sonra " + Bus3int.toString());
    final rowsAffected = await dbHelper.update3(row);
  }

  Future<void> Sil40() async {
    final allRows = await dbHelper.queryAllRows3();

    Bus1[0] = allRows![0]['bus1'].toString();
    Bus2[0] = allRows[0]['bus2'].toString();
    Bus3[0] = allRows[0]['bus3'].toString();

    int Bus1int = int.parse(Bus1[0]);
    int Bus2int = int.parse(Bus2[0]);
    int Bus3int = int.parse(Bus3[0]);

    print("önce " + Bus3int.toString());
    Bus3int--;
    Map<String, dynamic> row = {
      DatabaseHelper.columnBus1: Bus1int.toString(),
      DatabaseHelper.columnBus2: Bus2int.toString(),
      DatabaseHelper.columnBus3: Bus3int.toString(),
    };
    print("sonra " + Bus3int.toString());
    final rowsAffected = await dbHelper.update3(row);
  }

  Silindi(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("Tamam"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Otobüsler"),
      content: Text("Otobüsler Silindi"),
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
      title: Text("Otobüs"),
      content: Text("Otobüs eklendi."),
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

class ScreenDurak extends StatefulWidget {
  const ScreenDurak({Key? key}) : super(key: key);

  @override
  State<ScreenDurak> createState() => _ScreenDurak();
}

class _ScreenDurak extends State<ScreenDurak> {
  final dbHelper = DatabaseHelper.instance;

  final DuraksID = List<String>.filled(13, '');
  final DuraksName = List<String>.filled(13, '');
  final DuraksLat = List<String>.filled(13, '');
  final DuraksLng = List<String>.filled(13, '');
  final DuraksYolcu = List<String>.filled(13, '');

  TextEditingController txtID = TextEditingController();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtLat = TextEditingController();
  TextEditingController txtLng = TextEditingController();
  TextEditingController txtYolcu = TextEditingController();

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 8),
            Text(
              "Durak ekle.",
              style: TextStyle(
                fontSize: 25,
                color: Colors.blueGrey[900],
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: txtID,
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.all(8),
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
                    hintText: "ID"),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: txtName,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(8),
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
                  hintText: 'İsim',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: txtLat,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(8),
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
                  hintText: 'Lat',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: txtLng,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(8),
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
                  hintText: 'Lng',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: txtYolcu,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(8),
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
                  hintText: 'Yolcu Sayısı',
                ),
              ),
            ),
            Container(
              height: 30,
              width: 400,
              decoration: BoxDecoration(
                  color: Colors.blueGrey[900],
                  borderRadius: BorderRadius.circular(10)),
              child: FlatButton(
                onPressed: () {
                  DurakEkle();
                  Eklendi(context);
                },
                child: Text(
                  'Ekle',
                  style:
                      TextStyle(color: Colors.white, fontSize: 25, height: 1.2),
                ),
              ),
            ),
            SizedBox(height: 8),
            Container(
              height: 30,
              width: 400,
              decoration: BoxDecoration(
                  color: Colors.blueGrey[900],
                  borderRadius: BorderRadius.circular(10)),
              child: FlatButton(
                onPressed: () {
                  DurakGuncelle();
                  Guncellendi(context);
                },
                child: Text(
                  'Güncelle',
                  style:
                      TextStyle(color: Colors.white, fontSize: 25, height: 1.2),
                ),
              ),
            ),
            SizedBox(height: 8),
            Container(
              height: 30,
              width: 400,
              decoration: BoxDecoration(
                  color: Colors.blueGrey[900],
                  borderRadius: BorderRadius.circular(10)),
              child: FlatButton(
                onPressed: () {
                  DurakGoster();
                  Goster(context);
                },
                child: Text(
                  'Göster',
                  style:
                      TextStyle(color: Colors.white, fontSize: 25, height: 1.2),
                ),
              ),
            ),
            SizedBox(height: 8),
            Container(
              height: 30,
              width: 400,
              decoration: BoxDecoration(
                  color: Colors.blueGrey[900],
                  borderRadius: BorderRadius.circular(10)),
              child: FlatButton(
                onPressed: () {
                  DurakSil();
                  Silindi(context);
                },
                child: Text(
                  'Sil',
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
                    title: Text('id: ' +
                        DuraksID[index] +
                        '\nDurak İsmi: ' +
                        DuraksName[index] +
                        '\nDurak Lat: ' +
                        DuraksLat[index] +
                        '\nDurak Lng: ' +
                        DuraksLng[index] +
                        '\nDurak Yolcu: ' +
                        DuraksYolcu[index]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
      title: Text("Duraklar"),
      content: Text("Veriler Güncellendi."),
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

  Silindi(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("Tamam"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Duraklar"),
      content: Text("Veriler Silindi"),
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
      title: Text("Duraklar"),
      content: Text("Veriler eklendi."),
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

  Future<void> DurakEkle() async {
    int idd = int.parse(txtID.text);
    Map<String, dynamic> row = {
      DatabaseHelper.columnIdDurak: txtID.text.toString(),
      DatabaseHelper.columnNameDurak: txtName.text,
      DatabaseHelper.columnLatDurak: txtLat.text,
      DatabaseHelper.columnLngDurak: txtLng.text,
      DatabaseHelper.columnYolcuDurak: txtYolcu.text,
    };
    final id = await dbHelper.insert2(row);
    print('Eklendi  row(s)');
  }

  Goster(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("Tamam"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Duraklar"),
      content: Text("Duraklar Gösterildi."),
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

  Future<void> DurakGuncelle() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnIdDurak: txtID.text,
      DatabaseHelper.columnNameDurak: txtName.text,
      DatabaseHelper.columnLatDurak: txtLat.text,
      DatabaseHelper.columnLngDurak: txtLng.text,
      DatabaseHelper.columnYolcuDurak: txtYolcu.text,
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }

  Future<void> DurakGoster() async {
    final allRows = await dbHelper.queryAllRows();

    for (int a = 0; a < 15; a++) {
      DuraksID[a] = allRows![a]['_id'].toString();
      DuraksName[a] = allRows[a]['name'].toString();
      DuraksLat[a] = allRows[a]['lat'].toString();
      DuraksLng[a] = allRows[a]['lng'].toString();
      DuraksYolcu[a] = allRows[a]['yolcu'].toString();
    }
  }

  Future<void> DurakSil() async {
    int idd = int.parse(txtID.text);
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(idd);
    print('deleted $rowsDeleted row(s): row $idd');
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

  static final CameraPosition _kLake =
      CameraPosition(target: LatLng(golcuklat, golcuklng), zoom: 12);

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

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}

class ScreenYolcu extends StatefulWidget {
  const ScreenYolcu({Key? key}) : super(key: key);

  @override
  State<ScreenYolcu> createState() => _ScreenYolcu();
}

class _ScreenYolcu extends State<ScreenYolcu> {
  final dbHelper = DatabaseHelper.instance;

  final DuraksID = List<String>.filled(13, '');
  final DuraksName = List<String>.filled(13, '');
  final DuraksLat = List<String>.filled(13, '');
  final DuraksLng = List<String>.filled(13, '');
  final DuraksYolcu = List<String>.filled(13, '');

  TextEditingController txtYolcu = TextEditingController();
  TextEditingController txtName = TextEditingController();

  @override
  void dispose() {
    txtYolcu.dispose();
    txtName.dispose();
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Text(
              "Durağa yolcu ekle.",
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
                  hintText: 'Yeni Yolcu Sayısını Yaz',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: txtName,
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
                  hintText: 'İlçeyi seçiniz.',
                ),
              ),
            ),
            SizedBox(height: 16), //<----
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
                  Goster(context);
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
                    title: Text('id: ' +
                        DuraksID[index] +
                        '\nDurak İsmi: ' +
                        DuraksName[index] +
                        '\nDurak Lat: ' +
                        DuraksLat[index] +
                        '\nDurak Lng: ' +
                        DuraksLng[index] +
                        '\nDurak Yolcu: ' +
                        DuraksYolcu[index]),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 200,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> DurakGoster() async {
    final allRows = await dbHelper.queryAllRows();

    for (int a = 0; a < 15; a++) {
      DuraksID[a] = allRows![a]['_id'].toString();
      DuraksName[a] = allRows[a]['name'].toString();
      DuraksLat[a] = allRows[a]['lat'].toString();
      DuraksLng[a] = allRows[a]['lng'].toString();
      DuraksYolcu[a] = allRows[a]['yolcu'].toString();
      print(DuraksName[a]);
    }
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
      title: Text("Yolcular"),
      content: Text("Yolcular Güncellendi."),
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

  Goster(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("Tamam"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Yolcular"),
      content: Text("Yolcular Gösterildi."),
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

  Future<void> DurakGuncelle() async {
    final allRows = await dbHelper.queryAllRows();
    Map<String, dynamic> row = {
      DatabaseHelper.columnNameDurak: txtName.text,
      DatabaseHelper.columnYolcuDurak: txtYolcu.text,
    };
    final rowsAffected = await dbHelper.update2(row);
    print('updated $rowsAffected row(s)');
  }
}
