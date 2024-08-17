import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Riverpodをインポート
import '../../providers/user_profile_provider.dart';
import 'selection_logic.dart'; // 新しく作成したファイルをインポート

class DecadeSelection extends ConsumerStatefulWidget { // ConsumerStatefulWidgetに変更
  final bool isVisible;
  final VoidCallback onToggleVisibility;
  final ValueChanged<List<RangeValues>> onSave;

  const DecadeSelection({
    super.key,
    required this.isVisible,
    required this.onToggleVisibility,
    required this.onSave,
  });

  @override
  DecadeSelectionState createState() => DecadeSelectionState();
}

class DecadeSelectionState extends ConsumerState<DecadeSelection> { // ConsumerStateに変更
  bool _isSaving = false;

  void _saveDecades(List<RangeValues> selectedDecadesRanges) {
    setState(() {
      _isSaving = true;
    });
    SelectionLogic(ref).saveDecades(selectedDecadesRanges); // refを使用
    setState(() {
      _isSaving = false;
    });
    widget.onToggleVisibility();
  }

  @override
  Widget build(BuildContext context) {
    final List<RangeValues> selectedDecadesRanges = ref.watch(userProfileProvider).selectedDecadesRanges; // ref.watchを使用

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: widget.onToggleVisibility,
            child: const Text('好きな年代'),
          ),
        ),
        if (widget.isVisible)
          Column(
            children: [
              ...selectedDecadesRanges.asMap().entries.map((entry) {
                final index = entry.key;
                final range = entry.value;
                return Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          RangeSlider(
                            values: range,
                            min: 1940,
                            max: 2024,
                            divisions: 84,
                            labels: RangeLabels(
                              '${range.start.round()}年',
                              '${range.end.round()}年',
                            ),
                            onChanged: (values) {
                              SelectionLogic(ref).updateDecadeRange(index, values); // refを使用
                            },
                          ),
                          Text(
                            '${range.start.round()}年 - ${range.end.round()}年',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        SelectionLogic(ref).removeDecadeRange(index); // refを使用
                      },
                    ),
                  ],
                );
              }),
              ElevatedButton(
                onPressed: () {
                  SelectionLogic(ref).addDecadeRange(); // refを使用
                },
                child: const Text('好きな年代を追加する'),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : () => _saveDecades(selectedDecadesRanges),
                  child: _isSaving
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('年代を保存'),
                ),
              ),
            ],
          ),
      ],
    );
  }
}