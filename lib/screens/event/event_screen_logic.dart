import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'event_dialogs.dart';
import '../../providers/event_provider.dart';
import 'event_day_selector.dart';

class EventScreenLogic {
  final EventDaySelector daySelector = EventDaySelector();

  DateTime getSelectedDay() {
    return daySelector.selectedDay;
  }

  DateTime getFocusedDay() {
    return daySelector.focusedDay;
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    daySelector.onDaySelected(selectedDay, focusedDay);
  }

  Future<void> showAddEvent(BuildContext context, WidgetRef ref) async {
    await showEventDialog(
      context: context,
      ref: ref,
      selectedDay: daySelector.selectedDay,
    );
  }

  Future<void> showEditEvent(BuildContext context, WidgetRef ref, Event event) async {
    await showEventDialog(
      context: context,
      ref: ref,
      selectedDay: daySelector.selectedDay,
      event: event,
    );
  }

  Future<void> showDeleteEventDialog(BuildContext context, WidgetRef ref, Event event) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('この予定を削除しますか？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('いいえ'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('はい'),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      ref.read(eventProvider.notifier).removeEvent(daySelector.selectedDay, event);
    }
  }
}