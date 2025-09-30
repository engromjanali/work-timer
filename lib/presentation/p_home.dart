import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:work_timer/core/constants/keys.dart';
import 'package:work_timer/core/constants/my_color.dart';
import 'package:work_timer/core/services/a_menager.dart';

class PHome extends StatefulWidget {
  const PHome({super.key});

  @override
  State<PHome> createState() => _PHomeState();
}

class _PHomeState extends State<PHome> {
  int selectitem = 0;
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> itemList = [
      {Keys.label: "Alarm", Keys.imagePath: AMenager.alarm},
      {Keys.label: "Stop Watch", Keys.imagePath: AMenager.stopWatch},
      {Keys.label: "Calender", Keys.imagePath: AMenager.calender},
      {Keys.label: "Timer", Keys.imagePath: AMenager.timer},
    ];

    return Scaffold(
      bottomNavigationBar: Stack(
        children: [
          BottomNavigationBar(
            currentIndex: selectitem,
            onTap: (value) {
              selectitem = value;
              setState(() {});
            },

            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              // BottomNavigationBarItem(icon: Icon(Icons.add, size: 30,), label: ""),
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
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.black,
                  child: Icon(Icons.add, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        leading: Image.asset(AMenager.defaultProfile),
        title: Text("Daily Task"),
      ),
      body: Column(
        children: [
          Text(
            "Quick Choice",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          GridView.builder(
            shrinkWrap: true,
            itemCount: 4,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (_, index) {
              return _gridItem(
                label: itemList[index][Keys.label],
                imagePath: itemList[index][Keys.imagePath],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _gridItem({required String label, required String imagePath}) {
    return SizedBox(
      width: 190,
      height: 214,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Image.asset(imagePath, fit: BoxFit.fill,)),
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(fontSize: 20.sp),
          ),
        ],
      ).paddingAll(),
    );
  }
}
