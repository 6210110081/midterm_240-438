import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:midterm/boxes.dart';
import 'package:midterm/model/timeaction.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  String dropdownValue = 'แสดงทั้งหมด';
  List<Timeaction> searchCurrent = [];

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
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Search'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    focusColor: Colors.white,
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    iconEnabledColor: Colors.black,
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        searchWork(timeactions, newValue);
                        print(newValue);
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['แสดงทั้งหมด', 'งานในบ้าน', 'งานในครัว']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
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

  void searchWork(List<Timeaction> value, String newValue) {
    value.forEach((element) {
      element.groupwork = newValue?
    });
  }
}
