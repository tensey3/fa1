import 'package:flutter_riverpod/flutter_riverpod.dart';

class Event {
  final String title;
  final String location;
  final DateTime startTime;
  final DateTime endTime;
  final int participants;

  Event({
    required this.title,
    required this.location,
    required this.startTime,
    required this.endTime,
    required this.participants,
  });
}

class EventNotifier extends StateNotifier<Map<DateTime, List<Event>>> {
  EventNotifier() : super({});

  void addEvent(DateTime date, String title, String location, DateTime startTime, DateTime endTime, int participants) {
    final event = Event(
      title: title,
      location: location,
      startTime: startTime,
      endTime: endTime,
      participants: participants,
    );
    if (state[date] != null) {
      state = {
        ...state,
        date: [...state[date]!, event],
      };
    } else {
      state = {
        ...state,
        date: [event],
      };
    }
  }
}

final eventProvider = StateNotifierProvider<EventNotifier, Map<DateTime, List<Event>>>((ref) {
  return EventNotifier();
});
