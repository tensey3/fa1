import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/event_provider.dart';

Future<void> showEventDialog({
  required BuildContext context,
  required WidgetRef ref,
  required DateTime selectedDay,
  Event? event,
}) async {
  final isEditing = event != null;
  String eventTitle = isEditing ? event.title : '';
  String eventLocation = isEditing ? event.location : '';
  TimeOfDay startTime = isEditing ? TimeOfDay.fromDateTime(event.startTime) : TimeOfDay.now();
  TimeOfDay endTime = isEditing ? TimeOfDay.fromDateTime(event.endTime) : TimeOfDay(hour: startTime.hour + 1, minute: startTime.minute);
  int participants = isEditing ? event.participants : 1;

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(isEditing ? '予定を編集' : '予定を追加'),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTextField('予定のタイトル', eventTitle, (value) => eventTitle = value),
                  _buildTextField('場所', eventLocation, (value) => eventLocation = value),
                  _buildTimePickerTile(context, '開始時間', startTime, (picked) {
                    setState(() {
                      startTime = picked;
                      if (endTime.hour < startTime.hour || (endTime.hour == startTime.hour && endTime.minute <= startTime.minute)) {
                        endTime = TimeOfDay(hour: startTime.hour + 1, minute: startTime.minute);
                      }
                    });
                  }),
                  _buildTimePickerTile(context, '終了時間', endTime, (picked) {
                    setState(() {
                      if (picked.hour > startTime.hour || (picked.hour == startTime.hour && picked.minute > startTime.minute)) {
                        endTime = picked;
                      } else {
                        _showSnackBar(context, '終了時間は開始時間より後でなければなりません');
                      }
                    });
                  }),
                  _buildParticipantsDropdown(participants, (newValue) {
                    setState(() {
                      participants = newValue!;
                    });
                  }),
                ],
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('キャンセル'),
          ),
          ElevatedButton(
            onPressed: () {
              if (eventTitle.isEmpty || eventLocation.isEmpty) {
                _showSnackBar(context, 'タイトルと場所は必須です');
              } else {
                final selectedStartDateTime = DateTime(
                  selectedDay.year,
                  selectedDay.month,
                  selectedDay.day,
                  startTime.hour,
                  startTime.minute,
                );
                final selectedEndDateTime = DateTime(
                  selectedDay.year,
                  selectedDay.month,
                  selectedDay.day,
                  endTime.hour,
                  endTime.minute,
                );

                if (isEditing) {
                  ref.read(eventProvider.notifier).updateEvent(
                    selectedDay,
                    event,
                    eventTitle,
                    eventLocation,
                    selectedStartDateTime,
                    selectedEndDateTime,
                    participants,
                  );
                } else {
                  ref.read(eventProvider.notifier).addEvent(
                    selectedDay,
                    eventTitle,
                    eventLocation,
                    selectedStartDateTime,
                    selectedEndDateTime,
                    participants,
                  );
                }

                Navigator.of(context).pop();
              }
            },
            child: Text(isEditing ? '保存' : '追加'),
          ),
        ],
      );
    },
  );
}

Widget _buildTextField(String label, String initialValue, Function(String) onChanged) {
  return TextField(
    decoration: InputDecoration(labelText: label),
    controller: TextEditingController(text: initialValue),
    onChanged: onChanged,
  );
}

Widget _buildTimePickerTile(
  BuildContext context,
  String label,
  TimeOfDay initialTime,
  Function(TimeOfDay) onTimePicked,
) {
  return ListTile(
    title: Text(label),
    trailing: TextButton(
      child: Text(initialTime.format(context)),
      onPressed: () async {
        final TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: initialTime,
        );
        if (picked != null) {
          onTimePicked(picked);
        }
      },
    ),
  );
}

Widget _buildParticipantsDropdown(int participants, Function(int?) onChanged) {
  return ListTile(
    title: const Text('参加人数'),
    trailing: DropdownButton<int>(
      value: participants,
      onChanged: onChanged,
      items: List.generate(10, (index) => index + 1).map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
    ),
  );
}

void _showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}