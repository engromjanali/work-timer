import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:work_timer/core/constants/extentions/w_extention.dart';
import 'package:work_timer/core/constants/keys.dart';
import 'package:work_timer/core/constants/my_color.dart';
import 'package:work_timer/core/services/a_menager.dart';
import 'package:work_timer/presentation/p_add_alarm.dart';
import 'package:work_timer/presentation/p_add_task.dart';
import 'package:work_timer/presentation/p_history_screen.dart';
import 'package:work_timer/presentation/p_settings.dart';
import 'package:work_timer/presentation/pages/stopwatch/view/p_stopwatch.dart';
import 'package:work_timer/presentation/p_task.dart';
import 'package:work_timer/presentation/test.dart';

class PHome extends StatefulWidget {
  const PHome({super.key});

  @override
  State<PHome> createState() => _PHomeState();
}

class _PHomeState extends State<PHome> {
  int selectitem = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Stack(
        children: [
          BottomNavigationBar(
            currentIndex: selectitem,
            onTap: (value) {
              if (value == 1) {
                Get.to(() => PHistory());
                return;
              }
              selectitem = value;
              setState(() {});
            },

            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                icon: Icon(Icons.access_time),
                label: "History",
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                // do something here
                Get.to(() => PAddTask());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 28.r,
                  backgroundColor: Colors.black,
                  child: Icon(Icons.add, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.to(() => PHistory());
          },
          child: Image.asset(
            AMenager.defaultProfile,
            height: 20,
            width: 20,
            fit: BoxFit.fitHeight,
          ).padAll(val: 2),
        ),
        title: Text("Daily Task"),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => PSettings());
            },
            child: Container(
              height: 40.r,
              width: 40.r,
              decoration: BoxDecoration(
                color: MyColor.white,
                border: Border.all(color: MyColor.backgroundColor),
                shape: BoxShape.circle,
              ),
              child: Center(child: Icon(Icons.settings, size: 25.r)),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Text(
            "Quick Choice",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          GridView.builder(
            shrinkWrap: true,
            itemCount: itemList.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 0.5.sw,
              mainAxisExtent: 214.h,
            ),
            itemBuilder: (_, index) {
              return _gridItem(
                label: itemList[index][Keys.label],
                onTap: () {
                  switch (index) {
                    case 0:
                      Get.to(() => PAddAlarm());
                    case 1:
                      Get.to(() => PStopwatch());
                    case 2:
                      Get.to(() => PStopwatch());
                    default:
                      Get.to(() => PStopwatch());
                  }
                },
                imagePath: itemList[index][Keys.imagePath],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _gridItem({
    required String label,
    required String imagePath,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Image.asset(imagePath, fit: BoxFit.fill)),
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(fontSize: 20.sp),
            ),
          ],
        ).padAll(),
      ),
    );
  }
}

List<Map<String, dynamic>> itemList = [
  {Keys.label: "Alarm", Keys.imagePath: AMenager.alarm},
  {Keys.label: "Stop Watch", Keys.imagePath: AMenager.stopWatch},
  {Keys.label: "Calender", Keys.imagePath: AMenager.calender},
  {Keys.label: "Timer", Keys.imagePath: AMenager.timer},
];
