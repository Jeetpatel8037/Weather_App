import 'package:flutter/material.dart';

import '../Helpers/Weather_Api_Key.dart';
import '../Models/Weather_Model.dart';

class weather extends StatefulWidget {
  @override
  _weatherState createState() => _weatherState();
}

class _weatherState extends State<weather> {
  TextEditingController searchController = TextEditingController();

  late Future<Weather?> getWeather;

  @override
  void initState() {
    getWeather = APIHelper.apiHelper.fetchAllPostData(city: "surat");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: APIHelper.apiHelper.fetchAllPostData(city: ''),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              Weather weather = snapshot.data;
              return Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(45.0),
                        bottomRight: Radius.circular(45.0)),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.green,
                      child: Column(
                        children: [
                          //const Padding(
                          //   padding: EdgeInsets.only(top: 40.0),
                          //    child: Text(
                          //      "Current Weather in Lahore, PK",
                          //      style: TextStyle(
                          //          fontSize: 20.0,
                          //          color: Colors.white,
                          //          fontWeight: FontWeight.w400),
                          //    ),
                          // ),
                          Row(
                            children: [
                              Expanded(
                                child: Stack(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: TextField(
                                      controller: searchController,
                                      decoration: const InputDecoration(
                                        hintText: "Search by city name",
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                              IconButton(
                                  onPressed: () {
                                    String searchCity = searchController.text;
                                    print(searchCity);

                                    setState(() {
                                      getWeather = APIHelper.apiHelper
                                          .fetchAllPostData(city: searchCity);
                                    });
                                  },
                                  icon: Icon(Icons.search)),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: Text(
                              "${weather.temp}\u00b0 C",
                              style: const TextStyle(
                                  fontSize: 50.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 28.0),
                            child: Column(
                              children: [
                                Text(
                                  "Humidity: ${weather.humidity}" + "%",
                                  style: const TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  "Description: ${weather.description}",
                                  style: const TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(Icons.thermostat_rounded,
                              color: Colors.red, size: 40.0),
                          title: const Text(
                            "Temperature ",
                            style: TextStyle(fontSize: 25.0),
                          ),
                          trailing: Text(
                            "${weather.temp}\u00B0 C",
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.red[500]),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.waves,
                              color: Colors.blue, size: 40.0),
                          title: const Text(
                            "Wind Speed ",
                            style: const TextStyle(fontSize: 25.0),
                          ),
                          trailing: Text(
                            "${weather.speed} m/s",
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.red[500]),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.invert_colors,
                              color: Colors.red, size: 40.0),
                          title: const Text(
                            "Humidity ",
                            style: const TextStyle(fontSize: 25.0),
                          ),
                          trailing: Text(
                            "${weather.humidity} %",
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.red[500]),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.clear_all,
                              color: Colors.red, size: 40.0),
                          title: const Text(
                            "Visibility ",
                            style: TextStyle(fontSize: 25.0),
                          ),
                          trailing: Text(
                            "${weather.main} m",
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.red[500]),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.cloud,
                              color: Colors.blue, size: 40.0),
                          title: const Text(
                            "Rain ",
                            style: const TextStyle(fontSize: 25.0),
                          ),
                          trailing: Text(
                            "${weather.temp}",
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.red[500]),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.remove_circle,
                              color: Colors.green, size: 40.0),
                          title: const Text(
                            "Current Status ",
                            style: const TextStyle(fontSize: 25.0),
                          ),
                          trailing: Text(
                            "${weather.description}",
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.red[500]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: const CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
