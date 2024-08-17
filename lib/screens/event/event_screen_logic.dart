import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Event {
  final String title;
  final String location;
  final DateTime startTime;  // 開始時間のフィールド
  final DateTime endTime;    // 終了時間のフィールド
  final int participants;    // 参加人数のフィールド

  Event({
    required this.title,
    required this.location,
    required this.startTime,
    required this.endTime,
    required this.participants,
  });
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

  void addEvent(String title, String location, DateTime startTime, DateTime endTime, int participants) {
    final event = Event(
      title: title,
      location: location,
      startTime: startTime,
      endTime: endTime,
      participants: participants,
    );
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
