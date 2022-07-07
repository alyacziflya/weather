import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather/ForecastParams.dart';
import 'package:weather/repositories/SuggestCityRepositoryImpl.dart';
import 'package:weather/locator.dart';
import 'package:weather/Models/CurrentCityModel.dart';
import 'package:weather/Models/ForcastDaysModel.dart';
import 'package:weather/Models/SuggestCityModel.dart';
import 'package:weather/apiProvider.dart';
import 'package:weather/bloc/CurrentWeatherBloc/bloc.dart';
import 'package:weather/bloc/ForecastWeatherBloc/bloc.dart';
import 'package:weather/helpers/DateConverter.dart';
import 'package:weather/WeatherView.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>{

  TextEditingController textEditingController = TextEditingController();
  var cityName = "Omsk";

  PageController _pageController = PageController();

  SuggestCityRepositoryImpl suggestCityRepository = SuggestCityRepositoryImpl(locator<ApiProvider>());

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CwBloc>(context).add(LoadCwEvent(cityName));
  }

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: BlocBuilder<CwBloc, CwState>(
            builder: (BuildContext context, state) {
              if(state is CwCompleted){
                // get data from state
                CurrentCityModel cityDataModel = state.currentCityModel;
                // create params for api call
                ForecastParams forecastParams = ForecastParams(cityDataModel.coord!.lat!, cityDataModel.coord!.lon!);
                BlocProvider.of<FwBloc>(context).add(LoadFwEvent(forecastParams));
                final formatter = DateFormat.jm();
                var sunrise = formatter.format(
                    new DateTime.fromMillisecondsSinceEpoch(
                        (cityDataModel.sys!.sunrise! * 1000) + cityDataModel.timezone! * 1000,
                        isUtc: true));
                var sunset = formatter.format(
                    new DateTime.fromMillisecondsSinceEpoch(
                        (cityDataModel.sys!.sunset! * 1000) + cityDataModel.timezone! * 1000,
                        isUtc: true));

                return GestureDetector(
                  onTap: (){
                    FocusScope.of(context).unfocus();
                    new TextEditingController().clear();
                  },
                  child: ListView(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: height * 0.03, left: width * 0.02, right: width * 0.02),
                          child: Row(
                            children: [
                              Expanded(
                                  child: TypeAheadField(
                                    textFieldConfiguration: TextFieldConfiguration(
                                        onSubmitted: (String prefix){
                                          textEditingController.text = prefix;
                                          BlocProvider.of<CwBloc>(context).add(LoadCwEvent(prefix));
                                        },
                                        controller: textEditingController,
                                        style:
                                        DefaultTextStyle.of(context).style.copyWith(
                                          fontSize: 17,
                                          color: Colors.grey,
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding:
                                          const EdgeInsets.fromLTRB(20,0,0,0),
                                          hintText: "enter the city",
                                          hintStyle: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),),
                                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),
                                          ),
                                        )),
                                    suggestionsCallback: (String prefix) async {
                                      return suggestCityRepository.fetchSuggestData(prefix);
                                    },
                                    itemBuilder: (context, Data model) {
                                      return ListTile(
                                        leading: Icon(Icons.location_on),
                                        title: Text(model.name!),
                                        subtitle:
                                        Text(model.region! + ", " + model.country!),
                                      );
                                    },
                                    onSuggestionSelected: (Data model) {
                                      textEditingController.text = model.name!;
                                      BlocProvider.of<CwBloc>(context).add(LoadCwEvent(model.name!));
                                    },
                                  )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: height * 0.02),
                          child: Container(
                            width: double.infinity,
                            height: 400,
                            child: PageView.builder(
                                physics: AlwaysScrollableScrollPhysics(),
                                allowImplicitScrolling: true,
                                controller: _pageController,
                                itemCount: 2,
                                itemBuilder: (context, position) {
                                  if (position == 0) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 50),
                                          child: Text(
                                            cityDataModel.name!,
                                            style: TextStyle(fontSize: 30, color: Colors.black),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10),
                                          child: Image(
                                            image: NetworkImage('http://openweathermap.org/img/wn/${cityDataModel.weather![0].icon}@2x.png', scale: 1),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10),
                                          child: Text(
                                            cityDataModel.main!.temp!.round().toString() +
                                                "\u00B0",
                                            style: TextStyle(fontSize: 50, color: Colors.black),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    "max",
                                                    style: TextStyle(fontSize: 16, color: Colors.grey),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        top: 10.0),
                                                    child: Text(
                                                      cityDataModel.main!.tempMax!
                                                          .round()
                                                          .toString() +
                                                          "\u00B0",
                                                      style: TextStyle(fontSize: 16, color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0, right: 10),
                                                child: Container(color: Colors.grey, width: 2, height: 40,),
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "min",
                                                    style: TextStyle(fontSize: 16, color: Colors.grey),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        top: 10.0),
                                                    child: Text(
                                                      cityDataModel.main!.tempMin!
                                                          .round()
                                                          .toString() +
                                                          "\u00B0",
                                                      style: TextStyle(fontSize: 16, color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Container(
                                      height: 400,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          width: double.infinity,
                                          height: 2500,
                                          child: BlocBuilder<FwBloc, FwState>(
                                            builder: (BuildContext context, state) {
                                              if(state is FwCompleted){
                                                ForcastDaysModel forecastDaysModel = state.forcastDaysModel;
                                                return Column(
                                                  children: [
                                                    Text("Wind speed",style: TextStyle(color: Colors.blueGrey[400],fontSize: 17, fontStyle: FontStyle.italic),),
                                                    Expanded(
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(bottom: 20, right: 40, left: 20),
                                                        child: LineChart(
                                                          sampleData1(forecastDaysModel),
                                                          swapAnimationDuration:
                                                          Duration(milliseconds: 150),
                                                          // Optional
                                                          swapAnimationCurve:
                                                          Curves.linear, // Optional
                                                        ),
                                                      ),
                                                    ),
                                                    Text("Humidity",style: TextStyle(color: Colors.blueGrey[400],fontSize: 17, fontStyle: FontStyle.italic),),
                                                    Expanded(
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(bottom: 20, right: 40, left: 20),
                                                        child: LineChart(
                                                          sampleData2(forecastDaysModel),
                                                          swapAnimationDuration:
                                                          Duration(milliseconds: 150),
                                                          // Optional
                                                          swapAnimationCurve:
                                                          Curves.linear, // Optional
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }else if(state is FwError){
                                                return Center(child: Text(state.message!));
                                              }else{
                                                return Container();
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                }),
                          ),
                        ),
                        Center(
                          child: SmoothPageIndicator(
                              controller: _pageController,
                              count: 2,
                              effect: ExpandingDotsEffect(
                                  dotWidth: 10,
                                  dotHeight: 10,
                                  spacing: 5,
                                  dotColor: Colors.grey,
                                  activeDotColor: Colors.black),
                              onDotClicked: (index) => _pageController.animateToPage(
                                  index,
                                  duration: Duration(microseconds: 500),
                                  curve: Curves.bounceOut)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Container(color: Colors.grey, height: 2, width: double.infinity,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Container(
                            width: double.infinity,
                            height: 100,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Center(
                                child: BlocBuilder<FwBloc, FwState>(
                                  builder: (BuildContext context, state) {
                                    if(state is FwCompleted){
                                      ForcastDaysModel forcastDaysModel = state.forcastDaysModel;
                                      List<Daily> mainDaily = forcastDaysModel.daily!;
                                      return ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: 8,
                                          itemBuilder:
                                              (BuildContext context, int index) {
                                            return DaysWeatherView(daily: mainDaily[index]);
                                          });
                                    }else if(state is FwError){
                                      return Center(child: Text(state.message!),);
                                    }else{
                                      return Container();
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Container(color: Colors.grey, height: 2, width: double.infinity,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0,bottom: 30),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text("wind speed",
                                        style: TextStyle(fontSize: 17, color: Colors.blueGrey[400], fontStyle: FontStyle.italic)),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                          cityDataModel.wind!.speed!.toString() + " m/s",
                                          style: TextStyle(
                                              fontSize: 14)),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Container(height: 30, width: 2,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Column(
                                    children: [
                                      Text("sunrise",
                                          style: TextStyle(fontSize: 17, color: Colors.blueGrey[400], fontStyle: FontStyle.italic)),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
                                        child: Text(sunrise, style: TextStyle(fontSize: 14)),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Container(height: 30, width: 2,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Column(children: [
                                    Text("sunset",
                                        style: TextStyle(fontSize: 17, color: Colors.blueGrey[400], fontStyle: FontStyle.italic)),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(sunset, style: TextStyle(fontSize: 14),
                                      ),),
                                  ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Container(height: 30, width: 2),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Column(children: [
                                    Text("humidity",
                                        style: TextStyle(fontSize: 17, color: Colors.blueGrey[400], fontStyle: FontStyle.italic)),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                          cityDataModel.main!.humidity!.toString() + "%",
                                          style: TextStyle(fontSize: 14)),
                                    ),
                                  ]),
                                ),
                              ]),
                        ),
                      ]),
                );
              }else if(state is CwError){
                return Center(child: Text(state.message!),);
              }else{
                return Container();
              }
            },
          ),
        )
    );
  }

  LineChartData sampleData1(ForcastDaysModel forecastDaysModel) {
    List<Daily> mainDaily = forecastDaysModel.daily!;

    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(show: false,),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value, d) => const TextStyle(
            color: Colors.blueGrey,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          margin: 15,
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return DateConverter.changeDtToDateTime(mainDaily[0].dt);
              case 3:
                return DateConverter.changeDtToDateTime(mainDaily[2].dt);
              case 5:
                return DateConverter.changeDtToDateTime(mainDaily[4].dt);
              case 7:
                return DateConverter.changeDtToDateTime(mainDaily[6].dt);
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value, d) => const TextStyle(
            color: Colors.blueGrey,
         //   fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0 m/s';
              case 2:
                return '2 m/s';
              case 4:
                return '4 m/s';
              case 6:
                return '6 m/s';
              case 8:
                return '8 m/s';
              case 10:
                return '10 m/s';
            }
            return '';
          },
          margin: 15,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Colors.blueGrey,
            width: 4,),
          left: BorderSide(
            color: Colors.blueGrey,
          ),
          right: BorderSide(
            color: Colors.white,
          ),
          top: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      minX: 0,
      maxX: 7,
      maxY: 10,
      minY: 0,
      lineBarsData: linesBarData1(mainDaily),
    );
  }

  List<LineChartBarData> linesBarData1(List<Daily> model) {
    final lineChartBarData1 = LineChartBarData(
      spots: [
        FlSpot(0, double.parse(model[0].windSpeed.toString())),
        FlSpot(1, double.parse(model[1].windSpeed.toString())),
        FlSpot(2, double.parse(model[2].windSpeed.toString())),
        FlSpot(3, double.parse(model[3].windSpeed.toString())),
        FlSpot(4, double.parse(model[4].windSpeed.toString())),
        FlSpot(5, double.parse(model[5].windSpeed.toString())),
        FlSpot(7, double.parse(model[6].windSpeed.toString())),
      ],
      isCurved: true,
      colors: [
        Colors.cyan,
        Colors.greenAccent,
      ],
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false,),
      belowBarData: BarAreaData(
        colors: [
          Colors.cyan,
          Colors.greenAccent,
        ],
        show: true,
      ),
    );
    return [
      lineChartBarData1,
    ];
  }

  LineChartData sampleData2(ForcastDaysModel forecastDaysModel) {
    List<Daily> mainDaily = forecastDaysModel.daily!;

    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(show: false,),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value, d) => const TextStyle(
            color: Colors.blueGrey,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          margin: 15,
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return DateConverter.changeDtToDateTime(mainDaily[0].dt);
              case 3:
                return DateConverter.changeDtToDateTime(mainDaily[2].dt);
              case 5:
                return DateConverter.changeDtToDateTime(mainDaily[4].dt);
              case 7:
                return DateConverter.changeDtToDateTime(mainDaily[6].dt);
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value, d) => const TextStyle(
            color: Colors.blueGrey,
            fontSize: 12,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0%';
              case 25:
                return '25%';
              case 50:
                return '50%';
              case 75:
                return '75%';
              case 100:
                return '100%';
            }
            return '';
          },
          margin: 15,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Colors.blueGrey,
            width: 4,),
          left: BorderSide(
            color: Colors.blueGrey,
          ),
          right: BorderSide(
            color: Colors.white,
          ),
          top: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      minX: 0,
      maxX: 7,
      maxY: 100,
      minY: 0,
      lineBarsData: linesBarData2(mainDaily),
    );
  }

  List<LineChartBarData> linesBarData2(List<Daily> model) {
    final lineChartBarData2 = LineChartBarData(
      spots: [
        FlSpot(0, double.parse(model[0].humidity.toString())),
        FlSpot(1, double.parse(model[1].humidity.toString())),
        FlSpot(2, double.parse(model[2].humidity.toString())),
        FlSpot(3, double.parse(model[3].humidity.toString())),
        FlSpot(4, double.parse(model[4].humidity.toString())),
        FlSpot(5, double.parse(model[5].humidity.toString())),
        FlSpot(7, double.parse(model[6].humidity.toString())),
      ],
      isCurved: true,
      colors: [
        Colors.cyan,
        Colors.greenAccent,
      ],
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false,),
      belowBarData: BarAreaData(
        colors: [
          Colors.cyan,
          Colors.greenAccent,
        ],
        show: true,
      ),
    );
    return [
      lineChartBarData2,
    ];
  }

}