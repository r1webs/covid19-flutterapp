import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MapViewState();
  }
}

class MapViewState extends State<MapView> {
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  var data;
  int generateIds() {
    var rng = new Random();
    var randomInt;
    randomInt = rng.nextInt(100);
    return randomInt;
  }
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(40.712776, -74.005974),
    zoom: 1,
  );

  @override
  void initState() {
    super.initState();
    getStats().then((value){
      setState(() {
        data = value['mapData'];
    for (var i = 0; i < data.length; i++) {
      var markerIdVal = generateIds();
      final MarkerId markerId = MarkerId(markerIdVal.toString());
      final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(
          data[i]['latitude'],
          data[i]['longitude'],
        ),
        //infoWindow: InfoWindow(title: data[i]['country'], snippet: data[i]['totalConfirmed'].toString()),
        onTap: () {
          _settingModalBottomSheet(data[i]);
        }
      );
      markers[markerId] = marker;
    }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GoogleMap(initialCameraPosition: _kGooglePlex,
      onTap: (_){
      },
      mapType: MapType.normal,
      onMapCreated: (GoogleMapController controller){
        _controller.complete(controller);
      },
          markers: Set<Marker>.of(markers.values)
      )
    );
  }

  void _settingModalBottomSheet(data) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Image.network(data['flag'], width: 20, height: 25),
                    title: new Text(data['country'], style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                    onTap: () => {}
                ),
                new ListTile(
                    leading: new Icon(Icons.people),
                    title: new Text('Total Cases',style: TextStyle(color: Colors.amber[900])),
                    subtitle: new Text(data['totalConfirmed'].toString(), style: TextStyle(fontSize: 16)),
                    onTap: () => {}
                ),
                new ListTile(
                    leading: new Icon(Icons.directions_run),
                    title: new Text('Total Recovered', style: TextStyle(color: Colors.green[800])),
                    subtitle: new Text(data['totalRecovered'].toString(), style: TextStyle(fontSize: 16)),
                    onTap: () => {}
                ),
                new ListTile(
                    leading: new Icon(Icons.sentiment_dissatisfied),
                    title: new Text('Total Deaths', style: TextStyle(color: Colors.red[800])),
                    subtitle: new Text(data['totalDeaths'].toString(), style: TextStyle(fontSize: 16)),
                    onTap: () => {}
                ),
              ],
            ),
          );
        }
    );
  }

}

Future<Map<dynamic, dynamic>>  getStats() async {
  var url = "https://corona.lmao.ninja/countries?sort=deaths";
  var response = await http.get(url);
  var jsonData = json.decode(response.body);
  var stats = new List();
  var listData = {};
  for (var word in jsonData) {
    try {
      double lat = word['countryInfo']['lat'].toDouble();
      double long = word['countryInfo']['long'].toDouble();
      var obj = new Map();
      obj['country'] = word['country'];
      obj['flag'] = word['countryInfo']['flag'];
      obj['latitude'] =  lat;
      obj['longitude'] = long;
      obj['totalConfirmed'] = word['cases'];
      obj['totalRecovered'] = word['recovered'];
      obj['totalDeaths'] = word['deaths'];
      stats.add(obj);
    } on Exception catch (_) {
      print('Error on getStats()');
    }
  }
  listData['mapData'] = stats;
  return listData;
}