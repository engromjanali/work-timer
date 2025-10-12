import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:work_timer/core/constants/extentions/w_extention.dart';
import 'package:work_timer/core/constants/my_color.dart';
import 'package:work_timer/core/constants/my_dimention.dart';

class PAddAlarm extends StatefulWidget {
  const PAddAlarm({super.key});

  @override
  State<PAddAlarm> createState() => _PAddAlarmState();
}

class _PAddAlarmState extends State<PAddAlarm> {
  FixedExtentScrollController hourController = FixedExtentScrollController();
  FixedExtentScrollController minuteController = FixedExtentScrollController();
  FixedExtentScrollController timeStateController =
      FixedExtentScrollController();

  List<String> timeState = ["AM", "PM"];
  int selectedHour = 0;
  int selectedMinute = 0;
  bool isAm = true;

  @override
  Widget build(BuildContext context) {
    // timeStateController.jumpTo(1);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Cancle", style: Theme.of(context).textTheme.titleMedium),
                GestureDetector(
                  onTap: () async {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                  },
                  child: Text(
                    "Save",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),

            _timeChose().padY(),

            Container(
              decoration: BoxDecoration(
                color: MyColor.cardColor,
                borderRadius: BorderRadius.circular(MyDimension.boarderRadius),
              ),
              child: Column(
                children: [
                  _item(leadingLabel: 'Label', trilingLable: 'asdfasd'),
                  _item(
                    leadingLabel: 'Repeat',
                    trilingLable: 'asdfasd',
                    containIcon: true,
                  ),
                  _item(
                    leadingLabel: 'Sound',
                    trilingLable: 'asdfasd',
                    containIcon: true,
                  ),
                  _item(
                    leadingLabel: 'Snooze',
                    trilingLable: '',
                    isSnooze: true,
                    isLast: true,
                  ),
                ],
              ),
            ),
          ],
        ).padAll(),
      ),
    );
  }

  Widget _timeChose() {
    return SizedBox(
      height: 200.h,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Center(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: MyColor.buttonColor,
                  borderRadius: BorderRadius.circular(
                    MyDimension.boarderRadius,
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Hours Picker
              SizedBox(
                width: 100.w,
                height: 200.h,
                child: ListWheelScrollView.useDelegate(
                  controller: hourController,

                  itemExtent: 50.h,
                  perspective: 0.005,
                  physics: const FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (index) {
                    setState(() {
                      if ((index % 24) < 12) {
                        isAm = true;
                        timeStateController.jumpToItem(0);
                      } else {
                        isAm = false;
                        timeStateController.jumpToItem(1);
                      }
                      selectedHour = index;
                    });
                    if (index == 48 - 1) {
                      hourController.jumpToItem(12);
                      return;
                    }
                  },

                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: 48,
                    builder: (context, index) {
                      final isSelected = selectedHour == index;
                      return Center(
                        child: Text(
                          (index % 12 == 0 ? 12 : index % 12)
                              .toString()
                              .padLeft(2, '0'),
                          style: Theme.of(context).textTheme.displaySmall!
                              .copyWith(
                                fontWeight: isSelected ? FontWeight.bold : null,
                              ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Text(":", style: Theme.of(context).textTheme.displaySmall),

              // Minutes Picker
              SizedBox(
                width: 100.w,
                height: 200.h,
                child: ListWheelScrollView.useDelegate(
                  controller: minuteController,
                  itemExtent: 50,

                  perspective: 0.005,
                  physics: const FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (index) {
                    setState(() => selectedMinute = index);
                    if (index == 120 - 1) {
                      minuteController.jumpToItem(60);
                      return;
                    }
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: 120,
                    builder: (context, index) {
                      final isSelected = selectedMinute == index;
                      return Center(
                        child: Text(
                          (index % 60).toString().padLeft(2, '0'),
                          style: Theme.of(context).textTheme.displaySmall!
                              .copyWith(
                                fontWeight: isSelected ? FontWeight.bold : null,
                              ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Text(":", style: Theme.of(context).textTheme.displaySmall),

              // Am/PM
              SizedBox(
                width: 100.w,
                height: 200.h,
                child: ListWheelScrollView.useDelegate(
                  controller: timeStateController,
                  itemExtent: 50,
                  perspective: 0.005,
                  physics: const NeverScrollableScrollPhysics(),
                  onSelectedItemChanged: (index) {},
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: timeState.length,
                    builder: (context, index) {
                      final isSelected =
                          index == 0 && isAm || index == 1 && !isAm;
                      return Center(
                        child: Text(
                          timeState[index],
                          style: Theme.of(context).textTheme.displaySmall!
                              .copyWith(
                                fontWeight: isSelected ? FontWeight.bold : null,
                              ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),

          //
        ],
      ),
    );
  }

  Widget _item({
    required String leadingLabel,
    required String trilingLable,
    bool containIcon = false,
    bool isSnooze = false,
    bool isLast = false,
  }) => Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(leadingLabel, style: Theme.of(context).textTheme.titleSmall),
          Row(
            children: [
              SizedBox(
                width: 100.w,
                child: Text(
                  trilingLable,
                  style: Theme.of(context).textTheme.titleSmall,
                  textAlign: TextAlign.end,
                ),
              ),
              if (containIcon) Icon(Icons.arrow_forward_ios, size: 20.sp),
              isSnooze
                  ? Switch(value: true, onChanged: (val) {})
                  : SizedBox.shrink(),
            ],
          ),
        ],
      ).padAll(val: isLast ? 0 : null).padX(val: isLast ? null : 0),
      if (!isLast) Divider(color: Colors.black, height: 1.h),
    ],
  );
}
