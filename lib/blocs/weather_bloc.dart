import 'package:flutter/cupertino.dart';
import 'package:weatherapp_flutter/models/models.dart';
import 'package:weatherapp_flutter/repositories/api_provider.dart';

class WeatherBloc extends ChangeNotifier {
  Weather? weather;

  Future getWeather() async {
    try {
      weather = await ApiProvider().getWeather();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
