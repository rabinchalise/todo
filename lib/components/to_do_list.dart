import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  const ToDoTile(
      {super.key,
      required this.taskName,
      required this.taskCompeletd,
      required this.onChanged,
      required this.deleteItme});
  final String taskName;
  final bool taskCompeletd;
  final void Function(bool?) onChanged;
  final Function(BuildContext) deleteItme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, right: 25, left: 25),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: deleteItme,
            icon: Icons.delete,
            foregroundColor: Colors.white,
            backgroundColor: Colors.red.shade200,
            borderRadius: BorderRadius.circular(12),
          )
        ]),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: Colors.deepPurple.shade100,
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Checkbox(value: taskCompeletd, onChanged: onChanged),
              Text(
                taskName,
                style: TextStyle(
                    fontSize: 18,
                    decoration:
                        taskCompeletd ? TextDecoration.lineThrough : null),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
