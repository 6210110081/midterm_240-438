import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:midterm/boxes.dart';
import 'package:midterm/model/timeaction.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:midterm/widget/transaction_dialog.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  // @override
  // void dispose() {
  //   Hive.close();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Timeaction>>(
      valueListenable: Boxes.getTimeactions().listenable(),
      builder: (context, box, _) {
        final timeactions = box.values.toList().cast<Timeaction>();

        return buildContent(timeactions);
      },
    );
  }

  Widget buildContent(List<Timeaction> timeactions) {
    if (timeactions.isEmpty) {
      return Center(
        child: Text(
          'No expenses yet!',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return Column(
        children: [
          SizedBox(height: 24),
          Text(
            'Net Expense: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              // color: color,
            ),
          ),
          SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: timeactions.length,
              itemBuilder: (BuildContext context, int index) {
                final timeaction = timeactions[index];

                return buildTimeaction(context, timeaction);
              },
            ),
          ),
        ],
      );
    }
  }

  Widget buildTimeaction(
    BuildContext context,
    Timeaction timeaction,
  ) {
    // final date = DateFormat.yMMMd().format(timeaction.createdDate);

    return Card(
      color: Colors.white,
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: Text(
          timeaction.work,
          maxLines: 2,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(timeaction.groupwork),
        trailing: Text(
          timeaction.todayDate.toString(),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        children: [
          // buildButtons(context, timeaction),
        ],
      ),
    );
  }

  // Widget buildButtons(BuildContext context, Timeaction timeaction) => Row(
  //       children: [
  //         Expanded(
  //           child: TextButton.icon(
  //             label: Text('Edit'),
  //             icon: Icon(Icons.edit),
  //             onPressed: () => Navigator.of(context).push(
  //               MaterialPageRoute(
  //                 builder: (context) => TimeactionDialog(
  //                   timeaction: timeaction,
  //                   onClickedDone: (name, amount, isExpense) =>
  //                       editTimeaction(timeaction, name, amount, isExpense),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     );

  // void editTimeaction(
  //   Timeaction timeaction,
  //   String work,
  //   String groupwork,
  //   DateTime todayDate,
  // ) {
  //   timeaction.work = work;
  //   timeaction.groupwork = groupwork;
  //   timeaction.todayDate = todayDate;

  //   // final box = Boxes.getTimeactions();
  //   // box.put(timeaction.key, timeaction);

  //   timeaction.save();
  // }
}
