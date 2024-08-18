import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Event クラス: 各イベントのデータ構造を定義します
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Event &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          location == other.location &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          participants == other.participants;

  @override
  int get hashCode =>
      title.hashCode ^
      location.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      participants.hashCode;
}

// EventNotifier クラス: StateNotifier を拡張し、イベントの状態を管理します
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

    // デバッグ用ログ
    if (kDebugMode) {
      print("Event added: $title on $date");
    }
    if (kDebugMode) {
      print("Current state: $state");
    }
  }

  void removeEvent(DateTime date, Event event) {
    if (state[date] != null) {
      final updatedEvents = state[date]!.where((e) => e != event).toList();
      if (updatedEvents.isEmpty) {
        final newState = Map<DateTime, List<Event>>.from(state);
        newState.remove(date);
        state = newState;
      } else {
        state = {
          ...state,
          date: updatedEvents,
        };
      }
    }
  }

  void updateEvent(DateTime date, Event oldEvent, String newTitle, String newLocation, DateTime newStartTime, DateTime newEndTime, int newParticipants) {
    if (state[date] != null) {
      state = {
        ...state,
        date: state[date]!.map((e) {
          if (e == oldEvent) {
            return Event(
              title: newTitle,
              location: newLocation,
              startTime: newStartTime,
              endTime: newEndTime,
              participants: newParticipants,
            );
          }
          return e;
        }).toList(),
      };
    }
  }
}

// StateNotifierProvider を使って、EventNotifier を提供します
final eventProvider = StateNotifierProvider<EventNotifier, Map<DateTime, List<Event>>>((ref) {
  return EventNotifier();
});