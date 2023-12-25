import 'package:flutter/material.dart';
import 'package:todo_with_hive/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final dynamic controller;
  const DialogBox(
      {super.key,
      required this.controller,
      required this.onCancel,
      required this.onSave});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[200],
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Add a new task'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(nameButton: 'Cancel', onPressed: onCancel),
                const SizedBox(
                  width: 10,
                ),
                MyButton(nameButton: 'Save', onPressed: onSave),
              ],
            )
          ],
        ),
      ),
    );
  }
}
