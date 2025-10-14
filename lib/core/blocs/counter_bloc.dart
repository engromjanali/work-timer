import 'package:flutter_bloc/flutter_bloc.dart';

// basic declearations ---------
// singele----
// BlocProvider(
//   create: (_) => CounterBloc(),
//   child: MyHomePage(),
// )

// multi ----
// MultiBlocProvider(
//   providers: [
//     BlocProvider(create: (_) => AuthBloc()),
//     BlocProvider(create: (_) => ThemeBloc()),
//     BlocProvider(create: (_) => UserBloc()),
//   ],
//   child: MyApp(),
// )

// event
abstract class CounterEvent {} // abstract class

class IncrementEvent extends CounterEvent {
  final Duration duration;
  IncrementEvent({this.duration = const Duration(milliseconds: 100)});
}

// state
class CurrentState {
  Duration currentCountTime;
  CurrentState({required this.currentCountTime});
}

class CounterBloc extends Bloc<CounterEvent, CurrentState> {
  CounterBloc() : super(CurrentState(currentCountTime: Duration.zero)) {
    // ui will rebuild on emit if the emited instance are not same.
    // because bloc check by instance not value,
    // Note: in here we are emit every time a new instance("CurrentState(currentCountTime: state.currentCountTime + event.duration))") that's why ui will be rubild even we are emiting same value.
    on<IncrementEvent>((event, emit) {
      return emit(
        CurrentState(
          currentCountTime: state.currentCountTime += event.duration,
        ),
      );
    });
  }
}



// fatch methods------------
// // first way
// CounterBloc  uBloc = context.read<CounterBloc>();

// // 2nd way 
// BlocBuilder<CounterBloc,CurrentState>(
//   builder: (context,CurrentState) {
//     return Widget;
//   }
// ),

// // 3rd way
// 🧩 ৩️⃣ BlocListener
// 👉 Bloc এর state পরিবর্তন হলে একবার কিছু কাজ চালাতে (side effect trigger করতে) ব্যবহার হয়।
// 🔹 এটা UI rebuild করে না
// 🔹 বরং শুধু listen করে state পরিবর্তন
// 🔹 যেমন Snackbar দেখানো, Navigation করা, Dialog খোলা ইত্যাদি
// BlocListener<AuthBloc, AuthState>(
//   listener: (context, state) {
//     if (state is AuthSuccess) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Login Success")),
//       );
//     }
//   },
//   child: LoginForm(),
// )

// // 4th way
// 🧩 ৪️⃣ BlocConsumer
// 👉 এটা BlocBuilder + BlocListener একসাথে।
// 🔹 অর্থাৎ — একই Bloc এর জন্য UI rebuild + side effect দুটোই দরকার হলে
// 🔹 দুইটা আলাদা Widget না লিখে একটাতেই করা যায়
// BlocConsumer<UserBloc, UserState>(
//   listener: (context, state) {
//     if (state is UserError) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text(state.message)));
//     }
//   },
//   builder: (context, state) {
//     if (state is UserLoading) {
//       return CircularProgressIndicator();
//     } else if (state is UserLoaded) {
//       return Text("Welcome, ${state.name}");
//     } else {
//       return Text("Press Load");
//     }
//   },
// )
// 🕐 ব্যবহার: যখন একই Bloc এর জন্য UI rebuild + event-based action দুটোই দরকার হয়।

// // 5th way
// 🧩 ৬️⃣ BlocSelector
// 👉 Bloc থেকে শুধুমাত্র নির্দিষ্ট অংশ listen করার জন্য ব্যবহৃত হয়।
// 🔹 পুরো state rebuild না করে শুধু প্রয়োজনীয় অংশ rebuild হয়
// 🔹 Performance বাড়ায়
// BlocSelector<CounterBloc, CurrentState, int>(
//   selector: (state) => state.count,
//   builder: (context, count) {
//     return Text('Count: $count');
//   },
// )
// 🕐 ব্যবহার: বড় Bloc state থাকলে এবং UI এর ছোট অংশ আপডেট দরকার হলে।

// debuging and loging ----------------------------------------------------------------------------------------------------------------------
// 🧩 ৭️⃣ BlocObserver
// 👉 এটা ব্যবহার করে তুমি Bloc এর সকল event এবং state transition track করতে পারো (debugging/logging এর জন্য)।
// class MyBlocObserver extends BlocObserver {
//   @override
//   void onTransition(Bloc bloc, Transition transition) {
//     print(transition);
//     super.onTransition(bloc, transition);
//   }
// }
// main.dart এ যোগ করো 👇
// void main() {
//   Bloc.observer = MyBlocObserver();
//   runApp(MyApp());
// }
// 🕐 ব্যবহার: Debugging বা Analytics purpose এ Bloc state change ট্র্যাক করতে।

// others method ------------------------------------------
// it will help to change data without update screen.
// context.read<CounterBloc>().state.currentCountTime = Duration(seconds: 5);

// class Person {
//   String name;
//   Person(this.name);
// }
// void main() {
//   var p = Person("Romjan");
//   fun(p);
//   print(p.name); // Output: Ali
// }
// void fun(Person val) {
//   val.name = "Ali"; // এই পরিবর্তন আসল object এও হবে
// }
// void fun(Person val) {
//   val = Person("New Person"); // এখন val অন্য object এর দিকে নির্দেশ করছে
// }
