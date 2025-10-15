import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_timer/core/constants/keys.dart';
import 'package:work_timer/core/services/core_services.dart';
import 'package:work_timer/presentation/m_stopwatch.dart';

class SStopwatch {
  static SStopwatch getInstance = SStopwatch._();
  late SharedPreferences _sharedPreferences;
  SStopwatch._() {
    _sharedPreferences = CoreServices.instance.sharedPreferences;
  }

  Future<void> saveCurrentStopwatchState(MStopwatch? mStopwatch) async {
    try {
      if (mStopwatch == null) return;
      await _sharedPreferences.setString(
        Keys.currentStopWatchState,
        jsonEncode(mStopwatch.toJson()),
      );
    } catch (e) {
      debugPrint("error from saveCurrentStopwatchState:" +e.toString());
    }
  }

  Future<MStopwatch?> getCurrentStopwatchState() async {
    try {
      var rawData = _sharedPreferences.getString(Keys.currentStopWatchState);
      if (rawData == null) return null;
      Map<String, dynamic> data = await jsonDecode(rawData);
      
      return MStopwatch.fromJson(data);
    } catch (e) {
      debugPrint("error from getCurrentStopwatchState:" + e.toString());
      return null;
    }
  }
}
