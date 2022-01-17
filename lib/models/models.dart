class Weather {
  int? weatherId;
  String? weatherMain;
  String? weatherDescription;
  String? weatherIcon;
  String? temp;
  String? feelsLike;
  String? wind;
  String? humidity;
  String? visibility;

  Weather.fromJson(Map<String, dynamic> json) {
    weatherId = json['weather'][0]['id'];
    weatherMain = json['weather'][0]['main'];
    weatherDescription = json['weather'][0]['description'];
    weatherIcon = getImageById(weatherId!);
    temp = "${json['main']['temp']}";
    feelsLike = "${json['main']['feels_like']}";
    wind = "${json['wind']['speed']}";
    humidity = "${json['main']['humidity']}";
    visibility = "${json['visibility']}";
  }

  String getImageById(int id) {
    final idFirstDigit = "$id".substring(0, 1);
    switch (idFirstDigit) {
      case "2":
        return "assets/thunderstrom.svg";
      case "3":
        return "assets/drizzle.svg";
      case "5":
        return "assets/showers.svg";
      case "6":
        return "assets/snow.svg";
      case "7":
        return "assets/windy.svg";
      case "8":
        return "assets/clear-cloudy.svg";
    }
    return "assets/clear-cloudy.svg";
  }
}
