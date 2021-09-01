part of 'helpers.dart';

class DateTimeHelper {
 static DateTime format() {
   final now = DateTime.now();
   final dateFormat = DateFormat('y/M/d');
   const timeSpecific = "01:29:00";
   final completeFormat = DateFormat('y/M/d H:m:s');
 
   final todayDate = dateFormat.format(now);
   final todayDateAndTime = "$todayDate $timeSpecific";
   var resultToday = completeFormat.parseStrict(todayDateAndTime);
 
   var formatted = resultToday.add(const Duration(days: 1));
   final tomorrowDate = dateFormat.format(formatted);
   final tomorrowDateAndTime = "$tomorrowDate $timeSpecific";
   var resultTomorrow = completeFormat.parseStrict(tomorrowDateAndTime);
 
   return now.isAfter(resultToday) ? resultTomorrow : resultToday;
 }
}