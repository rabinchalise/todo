import 'package:flutter/material.dart';
import 'package:todo/components/my_button.dart';
import 'package:todo/extension.dart';

class DialogBox extends StatelessWidget {
  const DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });
  final TextEditingController controller;
  final VoidCallback onSave, onCancel;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.deepPurple[100],
      content: SizedBox(
        height: 140,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                  hintText: 'Add new Task', border: OutlineInputBorder()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(text: 'Save', onTap: onSave),
                10.0.hotizontalSpacer,
                MyButton(text: 'Cancel', onTap: onCancel)
              ],
            )
          ],
        ),
      ),
    );
  }
}
