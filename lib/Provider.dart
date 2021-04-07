import 'package:flutter/foundation.dart';
import 'package:time_machine/time_machine.dart';

class Myprovider extends ChangeNotifier {
  String year='-', month='-' , day='-', byear='-', bmonth='-' , bday='-';
  calculte(DateTime birthday , DateTime current) {
    LocalDate birth = LocalDate.dateTime(birthday);
    LocalDate today = LocalDate.dateTime(current);

    DateTime next = new DateTime(current.year,birthday.month,birthday.day);
    if (next.isBefore(current)){
      next= new DateTime(current.year+1,birthday.month,birthday.day);
    }
    LocalDate next1 = LocalDate.dateTime(next);
    Period diff1 = next1.periodSince(today);

    bday=diff1.days.toString();
    bmonth=diff1.months.toString();
    byear=diff1.years.toString();
    Period diff = today.periodSince(birth);
    year = diff.years.toString();
          month = diff.months.toString();
          day = diff.days.toString();
    notifyListeners();
  }

  clear(){
    year='-'; month='-' ; day='-'; byear='-'; bmonth='-' ; bday='-';
    notifyListeners();

  }
}