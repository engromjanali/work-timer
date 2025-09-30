import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:work_timer/core/controller/c_theme.dart';
import 'package:work_timer/presentation/p_home.dart';
// import 'dart:async';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// const notificationChannelId = "my foreground service";
// const notificationId = 888;

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await initializeService();
//   runApp(const MyApp());
// }

// /// Initialize background service
// Future<void> initializeService() async {
//   debugPrint(" timer service initialized");
//   final service = FlutterBackgroundService();

//   await service.configure(
//     androidConfiguration: AndroidConfiguration(
//       autoStart: false,
//       autoStartOnBoot: false,
//       isForegroundMode: true,
//       onStart: onStart,

//       notificationChannelId:
//           notificationChannelId, // this must match with notification channel you created above.
//       initialNotificationTitle: 'AWESOME SERVICE',
//       initialNotificationContent: 'Initializing',
//       foregroundServiceNotificationId: notificationId,
//     ),
//     iosConfiguration: IosConfiguration(
//       autoStart: false,
//       onForeground: onStart,
//       onBackground: onIosBackground,
//     ),
//   );
// }

// /// iOS background boilerplate
// @pragma('vm:entry-point')
// Future<bool> onIosBackground(ServiceInstance service) async {
//   return true;
// }

// @pragma('vm:entry-point')
// void onStart(ServiceInstance service) {
//   debugPrint("timer service start");
//   int counter = 0;
//   Timer? timer;

//   // Start timer automatically
//   void startTimer() async {
//     debugPrint("timer start");
//     timer?.cancel();

//     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//         FlutterLocalNotificationsPlugin();
//     const AndroidNotificationChannel channel = AndroidNotificationChannel(
//       notificationChannelId, // id
//       'MY FOREGROUND SERVICE', // title
//       description:
//           'This channel is used for important notifications.', // description
//       importance: Importance.low, // importance must be at low or higher level
//     );

//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin
//         >()
//         ?.createNotificationChannel(channel);

//     timer = Timer.periodic(const Duration(seconds: 1), (t) {
//       debugPrint("counter :" + counter.toString());
//       counter++;
//       service.invoke("update", {"counter": counter});
//       if (service is AndroidServiceInstance) {
//         service.setForegroundNotificationInfo(
//           title: "Background Timer",
//           content: "Counter: $counter",
//         );
//         flutterLocalNotificationsPlugin.show(
//           101,
//           'COOL SERVICE',
//           'Awesome ${DateTime.now()}',
//           const NotificationDetails(
//             android: AndroidNotificationDetails(
//               "notificationChannelId",
//               'MY FOREGROUND SERVICE',
//               icon: 'ic_bg_service_small',
//               ongoing: true,
//             ),
//           ),
//         );
//       }
//     });
//   }

//   startTimer();

//   // Listen for UI commands
//   service.on("start").listen((event) => startTimer());
//   service.on("stop").listen((event) {
//     debugPrint("timer stop");
//     timer?.cancel();
//     service.stopSelf();
//   });
//   service.on("reset").listen((event) {
//     debugPrint("timer rest");
//     counter = 0;
//     service.invoke("update", {"counter": counter});
//   });
// }

// /// UI App
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   int counter = 0;
//   final service = FlutterBackgroundService();

//   @override
//   void initState() {
//     super.initState();

//     // Listen for data from background service
//     service.on("update").listen((event) {
//       if (event != null && event.containsKey("counter")) {
//         setState(() => counter = event["counter"]);
//       }
//     });
//   }

//   void startService() {
//     setState(() {});
//     service.startService();
//     print(1);
//   }

//   void startTimer() {
//     setState(() {});
//     service.invoke("start");
//     print(2);
//   }

//   void stopTimer() {
//     setState(() {});
//     service.invoke("stop");
//     print(3);
//   }

//   void resetTimer() {
//     setState(() {});
//     service.invoke("reset");
//     print(4);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text("Background Timer Demo")),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text("Counter: $counter", style: const TextStyle(fontSize: 30)),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: startService,
//                 child: const Text("Start Service"),
//               ),
//               ElevatedButton(
//                 onPressed: startTimer,
//                 child: const Text("Start Timer"),
//               ),
//               ElevatedButton(
//                 onPressed: stopTimer,
//                 child: const Text("Stop Timer"),
//               ),
//               ElevatedButton(
//                 onPressed: resetTimer,
//                 child: const Text("Reset Timer"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// Future<void> main() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     // await initializeService();

//     runApp(MyApp());
// }

// // this will be used as notification channel id
// const notificationChannelId = 'my_foreground';

// // this will be used for notification id, So you can update your custom notification with this id.
// const notificationId = 888;

// Future<void> initializeService() async {
//   final service = FlutterBackgroundService();

//   const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     notificationChannelId, // id
//     'MY FOREGROUND SERVICE', // title
//     description:
//         'This channel is used for important notifications.', // description
//     importance: Importance.low, // importance must be at low or higher level
//   );

//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);

//   await service.configure(
//     androidConfiguration: AndroidConfiguration(
//       // this will be executed when app is in foreground or background in separated isolate
//       onStart: onStart,

//       // auto start service
//       autoStart: false,
//       isForegroundMode: true,

//       notificationChannelId: notificationChannelId, // this must match with notification channel you created above.
//       initialNotificationTitle: 'AWESOME SERVICE',
//       initialNotificationContent: 'Initializing',
//       foregroundServiceNotificationId: notificationId,
//     ),
//     iosConfiguration: IosConfiguration(
//       autoStart: false,
//       onForeground: onStart,
//       onBackground: onIosBackground,
//     ),
//   );
// }

// /// iOS background boilerplate
// @pragma('vm:entry-point')
// Future<bool> onIosBackground(ServiceInstance service) async {
//   return true;
// }

//   @pragma('vm:entry-point')
//   Future<void> onStart(ServiceInstance service) async {
//   // Only available for flutter 3.0.0 and later
//   DartPluginRegistrant.ensureInitialized();

//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   // bring to foreground
//   Timer.periodic(const Duration(seconds: 1), (timer) async {
//     if (service is AndroidServiceInstance) {

//       if (await service.isForegroundService()) {
//       print("object");
//         // flutterLocalNotificationsPlugin.show(
//         //   notificationId,
//         //   'COOL SERVICE',
//         //   'Awesome ${DateTime.now()}',
//         //   const NotificationDetails(
//         //     android: AndroidNotificationDetails(
//         //       notificationChannelId,
//         //       'MY FOREGROUND SERVICE',
//         //       icon: 'ic_bg_service_small',
//         //       ongoing: true,
//         //     ),
//         //   ),
//         // );
//       }
//     }
//   });
// }

// // /// UI App
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   int counter = 0;
//   final service = FlutterBackgroundService();

//   @override
//   void initState() {
//     super.initState();

//     // Listen for data from background service
//     service.on("update").listen((event) {
//       if (event != null && event.containsKey("counter")) {
//         setState(() => counter = event["counter"]);
//       }
//     });
//   }

//   void startService() {
//     setState(() {});
//     service.startService();
//     print(1);
//   }

//   void startTimer() {
//     setState(() {});
//     service.invoke("start");
//     print(2);
//   }

//   void stopTimer() {
//     setState(() {});
//     service.invoke("stop");
//     print(3);
//   }

//   void resetTimer() {
//     setState(() {});
//     service.invoke("reset");
//     print(4);
//   }

//       // Scaffold(
//       //   appBar: AppBar(title: const Text("Background Timer Demo")),
//       //   body: Center(
//       //     child: Column(
//       //       mainAxisAlignment: MainAxisAlignment.center,
//       //       children: [
//       //         Text("Counter: $counter", style: const TextStyle(fontSize: 30)),
//       //         const SizedBox(height: 20),
//       //         ElevatedButton(
//       //           onPressed: startService,
//       //           child: const Text("Start Service"),
//       //         ),
//       //         ElevatedButton(
//       //           onPressed: startTimer,
//       //           child: const Text("Start Timer"),
//       //         ),
//       //         ElevatedButton(
//       //           onPressed: stopTimer,
//       //           child: const Text("Stop Timer"),
//       //         ),
//       //         ElevatedButton(
//       //           onPressed: resetTimer,
//       //           child: const Text("Reset Timer"),
//       //         ),
//       //       ],
//       //     ),
//       //   ),
//       // ),

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: PHome()

//     );
//   }
// }

// void main()async {
//     WidgetsFlutterBinding.ensureInitialized();
//     // await initializeService();

//     runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<CTheme>(
//       init: Get.put(CTheme()),
//       builder: (cTheme) =>  GetMaterialApp(
//         theme: cTheme.lightTheme,
//         darkTheme: cTheme.darkTheme,
//         themeMode: ThemeMode.system,
//         title: "Work Timer",
//         home: PHome(),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final cTheme = Get.put(CTheme());

    return ScreenUtilInit(
      designSize: const Size(430, 932), // iPhone X size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, _) {
        return GetBuilder<CTheme>(
          builder: (cTheme) {
            return AnimatedTheme(
              duration: Duration(microseconds: 500),
              curve: Curves.bounceIn,
              data: cTheme.currentTheme,
              child: GetMaterialApp(
                theme: cTheme.lightTheme,
                darkTheme: cTheme.darkTheme,
                themeMode: ThemeMode.light,
                home: const PHome()),
            );
          },
        );
      },
    );
  }
}
