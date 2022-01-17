import 'package:dio/dio.dart';
import 'package:weatherapp_flutter/models/models.dart';

class ApiProvider {
  final String apiUrl =
      "https://api.openweathermap.org/data/2.5/weather?lat=37.2682&lon=49.5891&appid=5963b44dc023100a2270dac5c0a9ae1e&units=metric";
  Dio dioClient = Dio();

  Future<Weather> getWeather() async {
    try {
      Response response = await dioClient.post(apiUrl);

      print((response.data));
      return Weather.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      rethrow;
    }
  }
}
