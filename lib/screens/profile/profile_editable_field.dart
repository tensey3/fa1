import 'package:flutter/material.dart';

class ProfileEditableField extends StatelessWidget {
  final String label;
  final String value;
  final int maxLines;
  final ValueChanged<String> onSave;

  const ProfileEditableField({
    super.key,
    required this.label,
    required this.value,
    this.maxLines = 1,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: value);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: label,
            border: const OutlineInputBorder(),
          ),
          onSubmitted: onSave,
        ),
      ],
    );
  }
}