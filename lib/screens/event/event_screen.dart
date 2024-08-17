import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../providers/event_provider.dart';

class EventScreen extends ConsumerStatefulWidget {
  const EventScreen({super.key});

  @override
  EventScreenState createState() => EventScreenState();
}

class EventScreenState extends ConsumerState<EventScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  Future<void> _showAddEventDialog(BuildContext context) async {
    TimeOfDay startTime = TimeOfDay.now();
    TimeOfDay endTime = TimeOfDay(hour: startTime.hour + 1, minute: startTime.minute);
    int participants = 1;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('予定を追加'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 開始時間の設定
                  ListTile(
                    title: const Text('開始時間'),
                    trailing: TextButton(
                      child: Text(startTime.format(context)),
                      onPressed: () async {
                        final TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: startTime,
                        );
                        if (picked != null) {
                          setState(() {
                            startTime = picked;
                          });
                        }
                      },
                    ),
                  ),
                  // 終了時間の設定
                  ListTile(
                    title: const Text('終了時間'),
                    trailing: TextButton(
                      child: Text(endTime.format(context)),
                      onPressed: () async {
                        final TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: endTime,
                        );
                        if (picked != null) {
                          setState(() {
                            endTime = picked;
                          });
                        }
                      },
                    ),
                  ),
                  // 参加人数の設定
                  ListTile(
                    title: const Text('参加人数'),
                    trailing: DropdownButton<int>(
                      value: participants,
                      onChanged: (int? newValue) {
                        setState(() {
                          participants = newValue!;
                        });
                      },
                      items: List.generate(10, (index) => index + 1)
                          .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('キャンセル'),
            ),
            ElevatedButton(
              onPressed: () {
                final selectedStartDateTime = DateTime(
                  _selectedDay.year,
                  _selectedDay.month,
                  _selectedDay.day,
                  startTime.hour,
                  startTime.minute,
                );
                final selectedEndDateTime = DateTime(
                  _selectedDay.year,
                  _selectedDay.month,
                  _selectedDay.day,
                  endTime.hour,
                  endTime.minute,
                );
                ref.read(eventProvider.notifier).addEvent(
                  _selectedDay,
                  '新しい予定',
                  '東京',  // イベントの場所のデフォルト設定
                  selectedStartDateTime,
                  selectedEndDateTime,
                  participants,
                );
                Navigator.of(context).pop();
              },
              child: const Text('追加'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final events = ref.watch(eventProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('イベントカレンダー'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TableCalendar(
              locale: 'ja_JP',
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
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
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: events[_selectedDay]?.length ?? 0,
                itemBuilder: (context, index) {
                  final event = events[_selectedDay]![index];
                  return ListTile(
                    title: Text('予定: ${event.title}'),
                    subtitle: Text('場所: ${event.location}'),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _showAddEventDialog(context);
              },
              child: const Text('予定を追加'),
            ),
          ],
        ),
      ),
    );
  }
}
