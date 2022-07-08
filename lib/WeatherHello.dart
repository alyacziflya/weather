import 'package:flutter/material.dart';
import 'package:weather/Models/ForcastDaysModel.dart';
import 'package:weather/helpers/DateConverter.dart';

class DaysWeatherView1 extends StatefulWidget {
  Daily daily;
  DaysWeatherView1({Key? key, required this.daily}) : super(key: key);

  @override
  State<DaysWeatherView1> createState() => _DaysWeatherViewState();
}

class _DaysWeatherViewState extends State<DaysWeatherView1> with SingleTickerProviderStateMixin{

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
    ).animate(CurvedAnimation(parent: animationController, curve: Interval(1, 0.5,curve: Curves.decelerate)));
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {

    final double width = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: animationController,
      builder: (context,child){
              return Center(
                  child: Container(
                    child:
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: Row(
                            children: [
                              Container(
                                alignment: Alignment.bottomRight,
                                height: 30,
                                width: widget.daily.humidity!.toDouble() * 1.5,
                                color: Colors.blueGrey[400],
                                child: Center(
                                  child: Text('${widget.daily.humidity!.toString()}%',
                                    style: const TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                    ),),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Image(image: NetworkImage('http://openweathermap.org/img/wn/${widget.daily.weather![0].icon}@2x.png', scale: 1.5),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child:  Text(DateConverter.changeDtToDateTime(widget.daily.dt).toString(),
                                    style: TextStyle(fontSize: 14, color: Colors.black)),
                                ),
                              const SizedBox(width: 10),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 30,
                                width: 50,
                                color: Colors.orangeAccent,
                                child: Center(
                                  child: Text('${widget.daily.temp!.min!.round().toString()}\u00B0',
                                    style: const TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                    ),),
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomRight,
                                height: 30,
                                width: widget.daily.temp!.day!.round().toDouble() * 3,
                                color: Colors.blueGrey[400],
                                child: Center(
                                  child: Text('${widget.daily.temp!.max!.round().toString()}\u00B0',
                                    style: const TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                    ),),
                                ),
                              ),
                            ],
                          ),

                        )
                    ),
                  ));
            },
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}