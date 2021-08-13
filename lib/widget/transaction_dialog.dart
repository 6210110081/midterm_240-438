import 'package:flutter/material.dart';

import '../model/timeaction.dart';

class TimeactionDialog extends StatefulWidget {
  final Timeaction? timeaction;
  final Function(String work, String groupwork, DateTime todayDate)
      onClickedDone;

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

  late DateTime todayDate;

  @override
  void initState() {
    super.initState();

    if (widget.timeaction != null) {
      final timeaction = widget.timeaction!;

      workController.text = timeaction.work;
      groupworkController.text = timeaction.groupwork.toString();
      todayDate = timeaction.todayDate;
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
              buildRadioButtons(),
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

  Widget buildgroupwork() => TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter groupwork',
        ),
        keyboardType: TextInputType.number,
        validator: (groupwork) =>
            groupwork != null && double.tryParse(groupwork) == null
                ? 'Enter a valid number'
                : null,
        controller: groupworkController,
      );

  Widget buildRadioButtons() => Column(
        children: [
          RadioListTile<bool>(
            title: Text('Expense'),
            value: true,
            groupValue: todayDate,
            onChanged: (value) => setState(() => todayDate = value!),
          ),
          RadioListTile<bool>(
            title: Text('Income'),
            value: false,
            groupValue: todayDate,
            onChanged: (value) => setState(() => todayDate = value!),
          ),
        ],
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
          final groupwork = double.tryParse(groupworkController.text) ?? 0;

          widget.onClickedDone(work, groupwork, todayDate);

          Navigator.of(context).pop();
        }
      },
    );
  }
}
