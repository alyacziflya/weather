import 'package:intl/intl.dart';

class DateConverter{
  static dynamic changeDtToDateTime(dt){
    final formatter = DateFormat.MMMd();
    // ---Jun 23---
    var result = formatter.format(new DateTime.fromMillisecondsSinceEpoch(dt * 1000, isUtc: true));
    return result;
  }
}