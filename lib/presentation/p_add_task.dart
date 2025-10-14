import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:work_timer/core/constants/extentions/w_extention.dart';
import 'package:work_timer/core/constants/my_color.dart';
import 'package:work_timer/core/constants/my_dimention.dart';
import 'package:work_timer/core/widgets/w_button.dart';

class PAddTask extends StatefulWidget {
  const PAddTask({super.key});

  @override
  State<PAddTask> createState() => _PAddTaskState();
}

class _PAddTaskState extends State<PAddTask> {
  int selectedButton = 0;
  bool getAlert = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task"),
      ),
      body: Column(
        children: [
          // Shedule
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Shedule", style: Theme.of(context).textTheme.titleMedium),

              // Title field
              TextFormField(
                style: Theme.of(context).textTheme.titleSmall,
                decoration: InputDecoration(label: Text("Title")),
              ).padY(),

              // SubTitle field
              TextFormField(
                maxLines: 4,
                style: Theme.of(context).textTheme.labelLarge,
                decoration: InputDecoration(label: Text("Details")),
              ),
            ],
          ).padY(),

          // time
          Column(
            children: [
              Row(
                children: [
                  Expanded(child: _getTimeRow(label: "Start Time")),
                  spaceX(),
                  Expanded(child: _getTimeRow(label: "End Time")),
                ],
              ),
              _getTimeRow(isDuration: true),
            ],
          ).padY(),

          // priority
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("priority", style: Theme.of(context).textTheme.titleSmall),
              Row(
                spacing: 10.w,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _getPriorityButton(
                    label: "High",
                    isSelected: selectedButton == 0,
                    ontap: () {
                      selectedButton = 0;
                      setState(() {});
                    },
                  ),
                  _getPriorityButton(
                    label: "Medium",
                    isSelected: selectedButton == 1,
                    ontap: () {
                      selectedButton = 1;
                      setState(() {});
                    },
                  ),
                  _getPriorityButton(
                    label: "Low",
                    isSelected: selectedButton == 2,
                    ontap: () {
                      selectedButton = 2;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ],
          ).padY(),

          // get alert
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Text("Get alert for this task", style: Theme.of(context).textTheme.bodyLarge,)),
              Transform.scale(
                scaleX: 1.w,
                scaleY: 0.8.h,
                child: Switch.adaptive(
                  activeThumbColor: MyColor.buttonColor,
                  value: getAlert, onChanged: (val) {
                    getAlert = val;
                    setState(() {});
                  },)),
            ],
          ),

          Spacer(),

          // create Task
          WButton(),
        ],
      ).padAll(),
    );
  }

  Widget _getPriorityButton({
    required String label,
    required bool isSelected,
    required Function() ontap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? MyColor.buttonColor : null,
            borderRadius: BorderRadius.circular(MyDimension.borderRadius),
            border: Border.all(color: MyColor.cardBorderColor),
          ),
          child: Center(
            child: Text(label, style: Theme.of(context).textTheme.titleMedium),
          ).padAll(),
        ).padY(val: 5.r),
      ),
    );
  }

  Widget _getTimeRow({String? label, bool isDuration = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label == null
            ? spaceY(val: 0)
            : Text(label, style: Theme.of(context).textTheme.titleSmall),
        spaceY(val: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(MyDimension.boarderRadius),
            border: Border.all(color: Color(0xFF0088FF)),
            color: MyColor.cardColor,
          ),
          child: Row(
            children: [
              if (!isDuration) Icon(Icons.access_time_sharp),
              if (!isDuration) spaceX(),
              Expanded(
                child: Text(
                  isDuration ? "Duration : 06 Hour 00 Minute " : "06 : 50 PM",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: isDuration ? TextAlign.center : TextAlign.start,
                ),
              ),
            ],
          ).padAll(val: 5.r),
        ),
      ],
    );
  }
}
