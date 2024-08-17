import 'package:flutter_riverpod/flutter_riverpod.dart';

class Event {
  final String title;
  final String location;

  Event({required this.title, required this.location});
}

// 状態管理用のNotifier
class EventNotifier extends StateNotifier<Map<DateTime, List<Event>>> {
  EventNotifier() : super({});

  void addEvent(DateTime date, String title, String location) {
    final event = Event(title: title, location: location);
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

// プロバイダーの宣言
final eventProvider = StateNotifierProvider<EventNotifier, Map<DateTime, List<Event>>>((ref) {
  return EventNotifier();
});