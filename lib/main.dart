import 'package:flutter/material.dart';
import 'package:midterm/boxes.dart';
import 'package:midterm/model/timeaction.dart';
import 'package:midterm/screen/home.dart';
import 'package:midterm/screen/profile.dart';
import 'package:midterm/widget/timeaction_dialog.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(TimeactionAdapter());
  await Hive.openBox<Timeaction>('timeactions');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Midterm 240-438',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _currentIndex = 0;
  final PageController pageController = PageController(initialPage: 0);

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 400), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Midterm'),
      ),
      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: pageController,
        onPageChanged: (indx) {
          setState(() {
            _currentIndex = indx;
          });
        },
        children: <Widget>[
          Home(),
          Profile(),
        ],
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _onItemTapped(index);
        },
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            selectedColor: Colors.purple,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
            selectedColor: Colors.teal,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => showDialog(
          context: context,
          builder: (context) => TimeactionDialog(
            onClickedDone: addTimeaction,
          ),
        ),
      ),
    );
  }
}

Future addTimeaction(
  String work,
  String groupwork,
) async {
  final timeaction = Timeaction()
    ..work = work
    ..todayDate = DateTime.now()
    ..groupwork = groupwork;

  final box = Boxes.getTimeactions();
  box.add(timeaction);
}
