import 'package:flutter/material.dart';
import 'package:work_timer/core/constants/extentions/w_extention.dart';
import 'package:work_timer/core/constants/my_color.dart';
import 'package:work_timer/core/constants/my_dimention.dart';

class PStopwatch extends StatefulWidget {
  const PStopwatch({super.key});

  @override
  State<PStopwatch> createState() => _PStopwatchState();
}

class _PStopwatchState extends State<PStopwatch> {
  List<Text> list = [
    Text("#1 00 : 01 : 55"),
    Text("#1 00 : 31 : 55"),
    Text("#1 00 : 21 : 55"),
    Text("#1 00 : 11 : 55"),
    Text("#1 00 : 71 : 55"),
    Text("#1 00 : 21 : 55"),
    Text("#1 00 : 25 : 55"),
    Text("#1 00 : 12 : 55"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stopwatch")),
      body: Column(
        children: [
          SizedBox(
            height: 200,
            child: ListWheelScrollView(
              itemExtent: 20,
              children: List.generate(list.length, (index){
                return Container(
                  color: Colors.red[index*100],
                  height: 20,
                  child: Center(child: list[index]),
                );
              }),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Rest
              Container(
                decoration: BoxDecoration(
                  color: MyColor.buttonColor,
                  borderRadius: BorderRadius.circular(MyDimension.borderRadius),
                ),
                child: Text(
                  "Rest",
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(color: MyColor.white),
                ).padX().padY(val: 5),
              ),

              // pose
              Container(
                decoration: BoxDecoration(
                  color: MyColor.buttonColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.play_arrow,
                  color: MyColor.white,
                  size: 25,
                ).padAll(),
              ),

              // share
              Container(
                decoration: BoxDecoration(
                  color: MyColor.buttonColor,
                  borderRadius: BorderRadius.circular(MyDimension.borderRadius),
                ),
                child: Text(
                  "Share",
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(color: MyColor.white),
                ).padX().padY(val: 5),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
