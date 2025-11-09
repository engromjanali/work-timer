import 'package:intl/intl.dart';

String formatedTime(DateTime dateTime){
  return DateFormat('hh:mm a').format(dateTime);
}

 