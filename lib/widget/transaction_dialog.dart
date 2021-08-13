import 'package:flutter/material.dart';

import '../model/timeaction.dart';

class TimeactionDialog extends StatefulWidget {
  final Timeaction? timeaction;
  final Function(String work, String groupwork) onClickedDone;

  const TimeactionDialog({
    Key? key,
    this.timeaction,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _TimeactionDialogState createState() => _TimeactionDialogState();
}

class _TimeactionDialogState extends State<TimeactionDialog> {
  final formKey = GlobalKey<FormState>();
  final workController = TextEditingController();
  final groupworkController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.timeaction != null) {
      final timeaction = widget.timeaction!;

      workController.text = timeaction.work;
      groupworkController.text = timeaction.groupwork.toString();
    }
  }

  @override
  void dispose() {
    workController.dispose();
    groupworkController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.timeaction != null;
    final title = isEditing ? 'Edit Timeaction' : 'Add Timeaction';

    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 8),
              buildwork(),
              SizedBox(height: 8),
              buildgroupwork(),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        buildCancelButton(context),
        buildAddButton(context, isEditing: isEditing),
      ],
    );
  }

  Widget buildwork() => TextFormField(
        controller: workController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter work',
        ),
        validator: (work) =>
            work != null && work.isEmpty ? 'Enter a work' : null,
      );

  String dropdownValue = 'งานในบ้าน';
  Widget buildgroupwork() => DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: <String>['งานในบ้าน', 'งานในครัว']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );

  Widget buildCancelButton(BuildContext context) => TextButton(
        child: Text('Cancel'),
        onPressed: () => Navigator.of(context).pop(),
      );

  Widget buildAddButton(BuildContext context, {required bool isEditing}) {
    final text = isEditing ? 'Save' : 'Add';

    return TextButton(
      child: Text(text),
      onPressed: () async {
        final isValid = formKey.currentState!.validate();

        if (isValid) {
          final work = workController.text;
          final groupwork = groupworkController.text;

          widget.onClickedDone(work, groupwork);

          Navigator.of(context).pop();
        }
      },
    );
  }
}
