import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../providers/event_provider.dart';
import 'event_screen_logic.dart';

class EventScreen extends ConsumerStatefulWidget {
  const EventScreen({super.key});

  @override
  EventScreenState createState() => EventScreenState();
}

class EventScreenState extends ConsumerState<EventScreen> {
  final EventScreenLogic logic = EventScreenLogic();

  @override
  Widget build(BuildContext context) {
    final events = ref.watch(eventProvider);
    final selectedDay = logic.getSelectedDay();
    final focusedDay = logic.getFocusedDay();

    return Scaffold(
      appBar: AppBar(
        title: const Text('イベントカレンダー'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildCalendar(context, events, selectedDay, focusedDay),
            const SizedBox(height: 16.0),
            _buildEventList(context, events, selectedDay),
            ElevatedButton(
              onPressed: () => logic.showAddEvent(context, ref),
              child: const Text('予定を追加'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar(BuildContext context, Map<DateTime, List<Event>> events, DateTime selectedDay, DateTime focusedDay) {
    return TableCalendar(
      locale: 'ja_JP',
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: focusedDay,
      selectedDayPredicate: (day) {
        return isSameDay(selectedDay, day);
      },
      eventLoader: (day) {
        return events[day] ?? [];
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          logic.onDaySelected(selectedDay, focusedDay);
        });
      },
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        markerDecoration: BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
        markersMaxCount: 1,
        outsideDaysVisible: false,
      ),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
    );
  }

  Widget _buildEventList(BuildContext context, Map<DateTime, List<Event>> events, DateTime selectedDay) {
    final dayEvents = events[selectedDay] ?? [];

    return Expanded(
      child: ListView.builder(
        itemCount: dayEvents.length,
        itemBuilder: (context, index) {
          final event = dayEvents[index];
          return ListTile(
            title: Text('予定: ${event.title}'),
            subtitle: Text(
              '場所: ${event.location}\n'
              '時間: ${event.startTime.hour}:${event.startTime.minute.toString().padLeft(2, '0')} - ${event.endTime.hour}:${event.endTime.minute.toString().padLeft(2, '0')}\n'
              '参加人数: ${event.participants}人',
            ),
            trailing: _buildEventActions(context, ref, event),
          );
        },
      ),
    );
  }

  Widget _buildEventActions(BuildContext context, WidgetRef ref, Event event) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => logic.showEditEvent(context, ref, event),
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => logic.showDeleteEventDialog(context, ref, event),
        ),
      ],
    );
  }
}