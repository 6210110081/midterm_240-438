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
  List<Timeaction> initial = [];
  List<Timeaction> searchCurrent = [];

  @override
  void initState() {
    searchCurrent = initial;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Timeaction>>(
      valueListenable: Boxes.getTimeactions().listenable(),
      builder: (context, box, _) {
        final timeactions = box.values.toList().cast<Timeaction>();
        timeactions.sort((a, b) => a.todayDate.compareTo(b.todayDate));
        initial = timeactions;

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
            padding: const EdgeInsets.all(8.0),
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
                      searchWork(timeactions, newValue);
                      setState(() {
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
          TextButton(
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Update Time Work'),
                content: const Text('คุณแน่ใจไหมที่จะอัปเดตเวลาทำงาของคุณ'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        timeaction.todayDate = DateTime.now();
                      });
                      Navigator.pop(context, 'OK');
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
            child: const Text('Click for Update Time Work'),
          ),
        ],
      ),
    );
  }

  void searchWork(List<Timeaction> value, String? newValue) async {
    searchCurrent = [];
    value.forEach((element) {
      element.groupwork.contains(newValue!) ? searchCurrent.add(element) : '';
    });
    if (searchCurrent.isEmpty) {
      searchCurrent = value;
    }
  }
}
