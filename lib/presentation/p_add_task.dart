import 'package:flutter/material.dart';
import 'package:work_timer/core/constants/extentions/w_extention.dart';
import 'package:work_timer/core/constants/my_color.dart';

class PAddTask extends StatefulWidget {
  const PAddTask({super.key});

  @override
  State<PAddTask> createState() => _PAddTaskState();
}

class _PAddTaskState extends State<PAddTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          // Shedule
          Column(
            children: [
              Text("Shedule"),

              // Title field
              TextFormField(
                decoration: InputDecoration(
                  label: Text("Title"),
                  border: OutlineInputBorder(),
                ),
              ).padY(),

              // SubTitle field
              TextFormField(
                maxLines: 4,
                decoration: InputDecoration(hint: Text("Discreptions")),
              ),
            ],
          ),

          // time
          Column(
            children: [
              Row(
                children: [
                  Expanded(child: _getTimeRow("Start Time")),
                  spaceX(),
                  Expanded(child: _getTimeRow("End Time")),
                ],
              ),
              _getTimeRow(null),
            ],
          ),
        ],
      ).padAll(),
    );
  }

  Widget _getTimeRow(String? label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label==null? spaceY(0) : Text(label, style: Theme.of(context).textTheme.titleSmall,),
        spaceY(5),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blue),
            color: MyColor.cardColor,
          ),
          child: Row(
            children: [
              Icon(Icons.access_time_sharp),
              spaceX(),
              Text(
                "06 : 50 PM",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ).padAll(val: 5),
        ),
      ],
    );
  }
}
