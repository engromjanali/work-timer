import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:work_timer/core/blocs/b_stopwatch.dart';
import 'package:work_timer/core/constants/extentions/w_extention.dart';
import 'package:work_timer/core/constants/my_color.dart';
import 'package:work_timer/core/constants/my_dimention.dart';
import 'package:work_timer/core/widgets/w_button.dart';
import 'package:work_timer/presentation/m_stopwatch.dart';

class PStopwatch extends StatefulWidget {
  const PStopwatch({super.key});

  @override
  State<PStopwatch> createState() => _PStopwatchState();
}

class _PStopwatchState extends State<PStopwatch> {
  Timer? timer;
  FixedExtentScrollController listWheelController =
      FixedExtentScrollController();
  int selectedIndex = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final cbloc = context.read<CounterBloc>();
      await cbloc.initializeFromSharedPreferences();
      await Future.delayed(
        Duration(milliseconds: 100),
      ); //after adding a event it's take few mili/micro moment to emit then bloc response setstate/changeState
      if (cbloc.state.mStopwatch.isRunning && timer == null) {
        _startTimer();
        setState(() {
          
        });
      } else {
        debugPrint(
          context.read<CounterBloc>().state.mStopwatch.toJson().toString(),
        );
      }
    });
  }

  void _startTimer() {
    debugPrint("timer start called");
    if (timer != null) {
      _stopTimer();
      return;
    }
    timer = Timer.periodic(Duration(milliseconds: 100), (val) {
      final cbloc = context.read<CounterBloc>();
      MStopwatch mStopwatch = cbloc.state.mStopwatch;
      DateTime currentTime = DateTime.now();
      cbloc.add(
        IncrementEvent(
          mStopwatch: MStopwatch(
            isRunning: true,
            duration:
                // Duration.zero,
                mStopwatch.duration +
                currentTime.difference(mStopwatch.startTime ?? currentTime),
            lapList: mStopwatch.lapList,
            startTime: currentTime,
          ),
        ),
      );
    });
  }

  void _stopTimer() {
    final cbloc = context.read<CounterBloc>();
    MStopwatch mStopwatch = cbloc.state.mStopwatch;

    cbloc.add(
      IncrementEvent(
        mStopwatch: MStopwatch(
          isRunning: false,
          duration:
              mStopwatch.duration +
              DateTime.now().difference(mStopwatch.startTime ?? DateTime.now()),
          lapList: mStopwatch.lapList,
        ),
      ),
    );
    timer?.cancel();
    timer = null;
  }

  void restStopwatch() {
    final cbloc = context.read<CounterBloc>();
    cbloc.add(
      IncrementEvent(
        mStopwatch: MStopwatch(
          isRunning: false,
          duration: Duration.zero,
          lapList: [],
        ),
      ),
    );
    timer?.cancel();
    timer = null;
    setState(() {});
  }

  void addLap() {
    final cbloc = context.read<CounterBloc>();

    MStopwatch mStopwatch = cbloc.state.mStopwatch;
    if (!mStopwatch.isRunning) return;
    DateTime currentTime = DateTime.now();

    List<Duration> list = [];
    list.addAll(mStopwatch.lapList);
    list.add(mStopwatch.duration);
    mStopwatch.lapList = list;
    mStopwatch.duration =
        mStopwatch.duration +
        DateTime.now().difference(mStopwatch.startTime ?? DateTime.now());
    mStopwatch.startTime = currentTime;

    cbloc.add(IncrementEvent(mStopwatch: mStopwatch));
    debugPrint("s");
    listWheelController.jumpToItem(mStopwatch.lapList.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    print("main ui rebuild");
    CounterBloc cBloc = context.read<CounterBloc>();
    return Scaffold(
      bottomNavigationBar: false
          ? GestureDetector(onTap: () {}, child: WButton().padX())
          : null,
      appBar: AppBar(title: Text("Stopwatch")),
      body: Column(
        children: [
          SizedBox.square(
            dimension: 190.w,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: MyColor.cardColor,
                border: Border.all(color: MyColor.buttonColor, width: 10.w),
              ),
              child: BlocSelector<CounterBloc, CurrentState, Duration>(
                selector: (state) {
                  return state.mStopwatch.duration;
                },
                builder: (context, duration) {
                  print(duration);
                  Duration currentCountTime = duration;

                  return Center(
                    child: Text(
                      currentCountTime.toString().split(".").first +
                          ":" +
                          currentCountTime
                              .toString()
                              .split(".")
                              .last
                              .substring(0, 2),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  );
                },
              ),
            ),
          ).padY(val: 50),

          // list while
          BlocSelector<CounterBloc, CurrentState, List<Duration>>(
            selector: (state) {
              // selector compare with object reference not value.
              // print("ss${state.mStopwatch.lapList.hashCode}");
              return state.mStopwatch.lapList;
            },
            builder: (_, length) {
              print("sssss${length}");
              return StatefulBuilder(
                builder: (context, setLocalState) {
                  // debugPrint("ss listwheel rebuilded $lapList");
                  return SizedBox(
                    child: ClipRRect(
                      child: Align(
                        alignment: Alignment.topCenter,
                        heightFactor: 0.6, // show only top half
                        child: SizedBox(
                          height: 400,
                          child: ListWheelScrollView.useDelegate(
                            controller: listWheelController,
                            physics: FixedExtentScrollPhysics(),
                            itemExtent: 30,

                            onSelectedItemChanged: (value) {
                              setLocalState(() {
                                selectedIndex = value;
                              });
                            },
                            dragStartBehavior: DragStartBehavior.down,
                            //       initialIndex: cBloc.state.mStopwatch.lapList.isEmpty
                            // ? 0
                            // : cBloc.state.mStopwatch.lapList.length - 1,
                            childDelegate: ListWheelChildBuilderDelegate(
                              childCount: cBloc.state.mStopwatch.lapList.length,
                              builder: (BuildContext context, int index) {
                                String lap = cBloc
                                    .state
                                    .mStopwatch
                                    .lapList[index]
                                    .toString();
                                return Center(
                                  child: Text(
                                    "#${index + 1} ${lap.split(".").first}:${lap.split(".").last.substring(0, 2)}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          fontWeight: index == selectedIndex
                                              ? FontWeight.bold
                                              : null,
                                        ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),

          // buttons tile
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Rest
              GestureDetector(
                onTap: () {
                  restStopwatch();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: MyColor.buttonColor,
                    borderRadius: BorderRadius.circular(
                      MyDimension.borderRadius,
                    ),
                  ),
                  child: Text(
                    "Rest",
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall!.copyWith(color: MyColor.white),
                  ).padX().padY(val: 5),
                ),
              ),

              // playpose
              StatefulBuilder(
                builder: (context, setLocalState) {
                  return GestureDetector(
                    onTap: () {
                      setLocalState(() {
                        _startTimer();
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: MyColor.buttonColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        !cBloc.state.mStopwatch.isRunning
                            ? Icons.play_arrow
                            : Icons.stop,
                        color: MyColor.white,
                        size: 25,
                      ).padAll(),
                    ),
                  );
                },
              ),

              // lap
              GestureDetector(
                onTap: () {
                  addLap();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: MyColor.buttonColor,
                    borderRadius: BorderRadius.circular(
                      MyDimension.borderRadius,
                    ),
                  ),
                  child: Text(
                    "Lap",
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall!.copyWith(color: MyColor.white),
                  ).padX().padY(val: 5),
                ),
              ),
            ],
          ).padY(),
        ],
      ),
    );
  }
}
