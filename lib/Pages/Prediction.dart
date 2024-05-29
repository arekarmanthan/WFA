// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_forcast_app/Widget/Bold_Text.dart';
import 'package:weather_forcast_app/Widget/only_text.dart';

// ignore: must_be_immutable
class Prediction extends StatefulWidget {
  Prediction({required this.forecast, super.key});

  List<Weather> forecast;

  @override
  State<Prediction> createState() => _PredictionState();
}

class _PredictionState extends State<Prediction> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.forecast.length,
          itemBuilder: (context, index) {
            DateTime now = widget.forecast[index].date!;
            if (now.hour == 02 && now.minute == 30) {
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                  width: 130,
                  decoration: BoxDecoration(
                    color: Colors.grey[500],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        BoldText(
                            DateFormat('EEEE').format(now), Colors.white, 15),
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://openweathermap.org/img/wn/${widget.forecast[index].weatherIcon}@4x.png"))),
                        ),
                        onlyText(
                            widget.forecast[index].weatherDescription
                                .toString(),
                            Colors.white,
                            13),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Spacer(),
                            BoldText(
                                '${widget.forecast[index].temperature!.celsius!.toStringAsFixed(0)}°',
                                Colors.white,
                                25),
                            BoldText('C', Colors.yellow, 25),
                            const Spacer(),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
            return const SizedBox(height: 0);
          }),
    );
  }
}
