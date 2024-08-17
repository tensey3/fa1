import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../providers/event_provider.dart';

class TournamentDetailsScreen extends ConsumerStatefulWidget {
  const TournamentDetailsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TournamentDetailsScreenState createState() => _TournamentDetailsScreenState();
}

class _TournamentDetailsScreenState extends ConsumerState<TournamentDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  String tournamentName = '';
  DateTime? eventDate;
  DateTime? registrationDeadline;
  int participants = 0;
  String message = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('大会の詳細設定'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: '大会名'),
                onSaved: (value) => tournamentName = value ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '大会名を入力してください';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildDatePicker(
                context: context,
                label: '開催日',
                selectedDate: eventDate,
                onDateSelected: (date) => setState(() => eventDate = date),
              ),
              const SizedBox(height: 16),
              _buildDatePicker(
                context: context,
                label: '募集締切日',
                selectedDate: registrationDeadline,
                onDateSelected: (date) => setState(() => registrationDeadline = date),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: '募集人数'),
                keyboardType: TextInputType.number,
                onSaved: (value) => participants = int.tryParse(value ?? '0') ?? 0,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '募集人数を入力してください';
                  }
                  if (int.tryParse(value) == null) {
                    return '有効な数値を入力してください';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: '一言メッセージ'),
                onSaved: (value) => message = value ?? '',
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: '概要（目的）'),
                maxLines: 3,
                onSaved: (value) => description = value ?? '',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _saveTournamentDetails(),
                child: const Text('保存する'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker({
    required BuildContext context,
    required String label,
    required DateTime? selectedDate,
    required ValueChanged<DateTime> onDateSelected,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            selectedDate != null
                ? DateFormat.yMMMd('ja_JP').format(selectedDate)
                : '日付を選択してください',
          ),
        ),
        TextButton(
          onPressed: () async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
              locale: const Locale('ja', 'JP'),  // カレンダーを日本語に設定
            );
            if (pickedDate != null) {
              onDateSelected(pickedDate);
            }
          },
          child: const Text('日付を選択'),
        ),
      ],
    );
  }

  void _saveTournamentDetails() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      final event = Event(
        title: tournamentName,
        location: '未定',
        startTime: eventDate!,
        endTime: eventDate!.add(const Duration(hours: 2)),  // デフォルトの終了時間を設定
        participants: participants,
      );

      ref.read(eventProvider.notifier).addEvent(
        eventDate!, event.title, event.location, event.startTime, event.endTime, event.participants
      );

      Navigator.pop(context);
    }
  }
}