import 'package:flutter/material.dart';

class SelectionScreen extends StatelessWidget {
  final String title;
  final String initialValue;
  final List<String>? items;
  final ValueChanged<String> onSave;

  const SelectionScreen({
    super.key,
    required this.title,
    required this.initialValue,
    this.items,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    String selectedValue = initialValue; // ここで初期値がnullの場合に空文字に設定
    final TextEditingController controller =
        TextEditingController(text: selectedValue);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: items == null || items!.isEmpty
            ? TextField(
                controller: controller,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey,
                  hintText: '入力してください',
                  hintStyle: TextStyle(color: Colors.white54),
                ),
              )
            : DropdownButtonFormField<String>(
                value: selectedValue.isNotEmpty ? selectedValue : items!.first,
                items: items!.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: const TextStyle(color: Colors.white)),
                  );
                }).toList(),
                onChanged: (value) {
                  selectedValue = value!;
                },
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey,
                ),
                dropdownColor: Colors.grey[850],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (items == null || items!.isEmpty) {
            onSave(controller.text);
          } else {
            onSave(selectedValue);
          }
          Navigator.of(context).pop();
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.save),
      ),
    );
  }
}