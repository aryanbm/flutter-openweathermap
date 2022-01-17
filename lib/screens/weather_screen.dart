import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_flutter/blocs/weather_bloc.dart';
import 'package:weatherapp_flutter/ui-kits/progress_dialog.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late WeatherBloc weatherBloc;
  ProgressDialog progressDialog = ProgressDialog();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) async {
      await loadData();
    });
  }

  loadData() async {
    progressDialog.showCustomDialog(context, 'Loading...');
    await weatherBloc
        .getWeather()
        .then((value) => progressDialog.dismiss())
        .catchError((error) {
      progressDialog.dismiss();
      _showSnackBar(context, "Somthing went wrong, please refresh");
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeatherBloc>(
        create: (context) => WeatherBloc(),
        builder: (context, child) {
          weatherBloc = Provider.of<WeatherBloc>(context, listen: true);
          return Scaffold(
            backgroundColor: Color(0xFF272727),
            appBar: AppBar(
              backgroundColor: Color(0xFF121212),
              leading: Icon(Icons.location_on),
              title: const Text("Rasht, Guilan"),
            ),
            body: (weatherBloc.weather == null)
                ? SizedBox()
                : RefreshIndicator(
                    onRefresh: () => loadData(),
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                          padding: EdgeInsets.all(24),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            color: const Color(0xFF3B3B3B),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    '${weatherBloc.weather!.weatherIcon}',
                                    height: 100,
                                    width: 100,
                                    semanticsLabel: 'Weather',
                                  ),
                                  const Spacer(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${weatherBloc.weather!.temp}°",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 64),
                                      ),
                                      Text(
                                        "Feels like ${weatherBloc.weather!.feelsLike}°",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 24),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${weatherBloc.weather!.weatherMain}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                  ),
                                  Text(
                                    "${weatherBloc.weather!.weatherDescription}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(16),
                          padding: EdgeInsets.all(24),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            color: const Color(0xFF3B3B3B),
                          ),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Wind",
                                    style: TextStyle(
                                        color: Color(0xFF8F8F8F), fontSize: 14),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "${weatherBloc.weather!.wind} m/h",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Humedity",
                                    style: TextStyle(
                                        color: Color(0xFF8F8F8F), fontSize: 14),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "${weatherBloc.weather!.humidity}%",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Visibility",
                                    style: TextStyle(
                                        color: Color(0xFF8F8F8F), fontSize: 14),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "${weatherBloc.weather!.visibility}m",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        });
  }
}
