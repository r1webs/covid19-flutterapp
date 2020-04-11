import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlaceholderWidget extends StatefulWidget {
  @override
  _PlaceholderState createState() => _PlaceholderState();
}

class _PlaceholderState extends State<PlaceholderWidget> {
  var data;
  @override
  initState() {
    super.initState();
    getSummary().then((value){
      setState(() {
        data = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return Container(
        color: Colors.white
      );
    } else {
      return Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              height: 180,
              width: double.maxFinite,
              child: Card(
                color: Colors.grey[50],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)
                ),
                //elevation: 5,
                child: Container(
                  child: Padding(padding: EdgeInsets.all(7),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  cardTitle('GLOBAL SITUATION'),
                                ],
                              ),
                              summaryView(data, 'global')
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              height: 180,
              width: double.maxFinite,
              child: Card(
                color: Colors.grey[50],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)
                ),
                //elevation: 5,
                child: Container(
                  child: Padding(padding: EdgeInsets.all(7),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  cardTitle('INDIA SITUATION'),
                                ],
                              ),
                              summaryView(data, 'india')
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

              ),
            ),
            SizedBox(height: 25),
            Text('ALL COUNTRIES SITUATION (DEATHS)', style: TextStyle(
              fontSize: 18,
              color: Colors.grey[400],
              fontWeight: FontWeight.bold
            ), textAlign: TextAlign.left),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              height: 240,
              color: Colors.grey[100],
              width: double.maxFinite,
              child: new ListView.builder(
                itemCount: data["allDeaths"] == null ? 0 : data["allDeaths"].length,
                itemBuilder: (BuildContext context, int index) {
                  return new Card(
                      child: ListTile(
                        title: Text(data["allDeaths"][index]["country"], style: TextStyle(color: Colors.grey[800], fontSize: 16)),
                        subtitle: Text(data["allDeaths"][index]["deaths"].toString(), style: TextStyle(color: Colors.red[400], fontSize: 17),),
                        onTap: () {

                        },
                      ));
                },
              )
            )
          ],
        ),
      );
    }

  }
  Widget cardIcon() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Align(
          alignment: Alignment.centerLeft,
//          child: Icon(
//            data[‘icon’],
//            color: data[‘iconColor’],
//            size: 40,
//          )
            child: Icon(
                Icons.info_outline,
              color: Colors.blue,
              size: 40
            ),
      ),
    );
  }

  Widget cardTitle(position) {
//    getSummary().then((value){
//      print(value);
//    });
    return Align(
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 20.0, bottom: 15.0),
        child: Row(
          children: <Widget>[
            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                text: position,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                )
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget summaryView(data, position) {
    if(position == 'global') {
      return Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    RichText(
                        text: TextSpan(
                            text: data['totalCases'].toString(),
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: 30,
                            )
                        )
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Column(
                  children: <Widget>[
                    RichText(
                        text: TextSpan(
                            text: 'Confirmed',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            )
                        )
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    RichText(
                        text: TextSpan(
                            text: data['totalDeaths'].toString(),
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 30,
                            )
                        )
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Column(
                  children: <Widget>[
                    RichText(
                        text: TextSpan(
                            text: 'Death',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            )
                        )
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    RichText(
                        text: TextSpan(
                            text: data['indiaTotalCases'].toString(),
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: 30,
                            )
                        )
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Column(
                  children: <Widget>[
                    RichText(
                        text: TextSpan(
                            text: 'Confirmed',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            )
                        )
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    RichText(
                        text: TextSpan(
                            text: data['indiaTotalDeaths'].toString(),
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 30,
                            )
                        )
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Column(
                  children: <Widget>[
                    RichText(
                        text: TextSpan(
                            text: 'Death',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            )
                        )
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      );
    }
  }

}

Future<Map<dynamic, dynamic>>  getSummary() async {
  var url = "https://api.covid19api.com/summary";
  var response = await http.get(url);
  var jsonData = json.decode(response.body);
  var cases = 0; var deaths = 0; var indiaTotalCases; var indiaTotalDeaths; var deathStats = new List();
  for (var word in jsonData['Countries']) {
    cases += word['TotalConfirmed'];
    deaths += word['TotalDeaths'];
    if(word['Slug'] == 'india') {
      indiaTotalCases = word['TotalConfirmed'];
      indiaTotalDeaths = word['TotalDeaths'];
    }
    var obj = new Map();
    obj['country'] = word['Country'];
    obj['deaths'] = word['TotalDeaths'];
    deathStats.add(obj);
  }
  deathStats.sort((m1, m2) {
    var r = m2["deaths"].compareTo(m1["deaths"]);
    if (r != 0) return r;
    return m2["deaths"].compareTo(m1["deaths"]);
  });
  var summaryData = {};
  var listData = {};
  var allData = {};
  summaryData['totalCases'] = cases;
  summaryData['totalDeaths'] = deaths;
  summaryData['indiaTotalCases'] = indiaTotalCases;
  summaryData['indiaTotalDeaths'] = indiaTotalDeaths;
  listData['allDeaths'] = deathStats;
  allData.addAll(summaryData);
  allData.addAll(listData);
  return allData;

}
