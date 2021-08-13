import 'package:flutter/material.dart';
import 'package:midterm/boxes.dart';
import 'package:midterm/model/transaction.dart';
import 'package:midterm/screen/home.dart';
import 'package:midterm/screen/list.dart';
import 'package:midterm/screen/profile.dart';
import 'package:midterm/widget/transaction_dialog.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(TransactionAdapter());
  await Hive.openBox<Transaction>('transactions');

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
          List(),
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

          /// Likes
          SalomonBottomBarItem(
            icon: Icon(Icons.favorite_border),
            title: Text("List"),
            selectedColor: Colors.pink,
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
          builder: (context) => TransactionDialog(
            onClickedDone: addTransaction,
          ),
        ),
      ),
    );
  }
}

Future addTransaction(String name, double amount, bool isExpense) async {
  final transaction = Transaction()
    ..name = name
    ..createdDate = DateTime.now()
    ..amount = amount
    ..isExpense = isExpense;

  final box = Boxes.getTransactions();
  box.add(transaction);
  //box.put('mykey', transaction);

  // final mybox = Boxes.getTransactions();
  // final myTransaction = mybox.get('key');
  // mybox.values;
  // mybox.keys;
}
