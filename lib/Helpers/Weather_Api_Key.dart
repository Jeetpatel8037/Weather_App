import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Models/Weather_Model.dart';

class APIHelper {
  APIHelper._();
  static final APIHelper apiHelper = APIHelper._();

  Future<Weather?> fetchAllPostData({required String city}) async {
    String apiKey = "1177b1e3edcc54bc767e02d9b9806249";

    String api =
        "https://api.openweathermap.org/data/2.5/weather?q=$city,IN&appid=$apiKey";
    http.Response res = await http.get(Uri.parse(api));

    if (res.statusCode == 200) {
      Map decodedData = jsonDecode(res.body);

      Weather weather = Weather.fromMap(data: decodedData);

      return weather;
    }
    return null;
  }
}
