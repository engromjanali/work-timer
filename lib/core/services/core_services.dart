import 'package:shared_preferences/shared_preferences.dart';

class CoreServices {
  CoreServices._();
  static CoreServices instance = CoreServices._();
  
  // 
  late SharedPreferences sharedPreferences;

  Future<void> init()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }
}