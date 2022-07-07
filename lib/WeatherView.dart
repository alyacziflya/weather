import 'package:flutter/material.dart';
import 'package:weather/Models/ForcastDaysModel.dart';
import 'package:weather/helpers/DateConverter.dart';

class DaysWeatherView extends StatefulWidget {
  Daily daily;
  DaysWeatherView({Key? key, required this.daily}) : super(key: key);

  @override
  State<DaysWeatherView> createState() => _DaysWeatherViewState();
}

class _DaysWeatherViewState extends State<DaysWeatherView> with SingleTickerProviderStateMixin{

  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = Tween(
      begin: -1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: animationController, curve: Interval(0.5, 1,curve: Curves.decelerate)));
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {

    final double width = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: animationController,
      builder: (context,child){
        return Transform(
          transform: Matrix4.translationValues(animation.value * width, 0.0, 0.0),
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Card(
              color: Colors.blueGrey[400],
              elevation: 0,
              child: Container(
                  width: 50,
                  height: 50,
                  child: Column(
                    children: [
                      Text(DateConverter.changeDtToDateTime(widget.daily.dt).toString(),
                          style: TextStyle(fontSize: 12, color: Colors.black)),
                      Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Image(image: NetworkImage('http://openweathermap.org/img/wn/${widget.daily.weather![0].icon}@2x.png', scale: 1),
                          ),
                      ),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                                widget.daily.temp!.day!.round().toString() + "\u00B0",
                                style: TextStyle(fontSize: 12, color: Colors.black)),
                          )),
                    ],
                  )),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}