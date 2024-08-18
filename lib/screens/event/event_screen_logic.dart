import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/event_provider.dart';

class EventScreenLogic with ChangeNotifier {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  DateTime get selectedDay => _selectedDay;
  DateTime get focusedDay => _focusedDay;

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    _selectedDay = selectedDay;
    _focusedDay = focusedDay;
    notifyListeners();
  }

  void onPageChanged(DateTime focusedDay) {
    _focusedDay = focusedDay;
    notifyListeners();
  }

  // 共通のイベントダイアログを表示
  void _showEventDialog({
    required BuildContext context,
    required WidgetRef ref,
    Event? event,
    required bool isEditing,
  }) {
    final eventNotifier = ref.read(eventProvider.notifier);

    String title = event?.title ?? '';
    String location = event?.location ?? '';
    TimeOfDay startTime = event != null ? TimeOfDay.fromDateTime(event.startTime) : TimeOfDay.now();
    TimeOfDay endTime = event != null ? TimeOfDay.fromDateTime(event.endTime) : TimeOfDay(hour: startTime.hour + 1, minute: startTime.minute);
    int participants = event?.participants ?? 1;
    String description = event?.description ?? ''; // 追加

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEditing ? '予定を編集' : '予定を追加'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    onChanged: (value) => title = value,
                    decoration: const InputDecoration(hintText: 'イベントタイトル'),
                  ),
                  TextField( // 追加: 説明フィールド
                    onChanged: (value) => description = value,
                    decoration: const InputDecoration(hintText: 'イベントの説明'),
                  ),
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

                if (isEditing) {
                  eventNotifier.updateEvent(
                    _selectedDay,
                    event!,
                    title,
                    location,
                    selectedStartDateTime,
                    selectedEndDateTime,
                    participants,
                    registrationDeadline: event.registrationDeadline,
                    description: description, // 追加
                  );
                } else {
                  eventNotifier.addEvent(
                    _selectedDay,
                    title,
                    location,
                    selectedStartDateTime,
                    selectedEndDateTime,
                    participants,
                    registrationDeadline: DateTime.now(), // 必須パラメータを追加
                    description: description, // 必須パラメータを追加
                  );
                }
                Navigator.of(context).pop();
              },
              child: Text(isEditing ? '保存' : '追加'),
            ),
          ],
        );
      },
    );
  }

  void showAddEvent(BuildContext context, WidgetRef ref) {
    _showEventDialog(context: context, ref: ref, isEditing: false);
  }

  void showEditEvent(BuildContext context, WidgetRef ref, Event event) {
    _showEventDialog(context: context, ref: ref, event: event, isEditing: true);
  }

  void showDeleteEventDialog(BuildContext context, WidgetRef ref, Event event) {
    final eventNotifier = ref.read(eventProvider.notifier);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('削除確認'),
          content: const Text('このイベントを削除してもよろしいですか？'),
          actions: [
            TextButton(
              onPressed: () {
                eventNotifier.removeEvent(_selectedDay, event);
                Navigator.of(context).pop();
              },
              child: const Text('はい'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('いいえ'),
            ),
          ],
        );
      },
    );
  }
}