import 'package:flutter/material.dart';  // 必要なインポート
import 'package:table_calendar/table_calendar.dart';  // 必要なインポート

class Event {
  final String title;
  final String location;

  Event({required this.title, required this.location});
}

class EventScreenLogic with ChangeNotifier {
  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
  Map<DateTime, List<Event>> events = {};

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    this.selectedDay = selectedDay;
    this.focusedDay = focusedDay;
    notifyListeners();
  }

  void onFormatChanged(CalendarFormat format) {
    if (calendarFormat != format) {
      calendarFormat = format;
      notifyListeners();
    }
  }

  void onPageChanged(DateTime focusedDay) {
    this.focusedDay = focusedDay;
  }

  void addEvent(String title, String location) {
    final event = Event(title: title, location: location);
    if (selectedDay != null) {
      if (events[selectedDay] != null) {
        events[selectedDay]!.add(event);
      } else {
        events[selectedDay!] = [event];
      }
      notifyListeners();
    }
  }
}