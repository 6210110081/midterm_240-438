import 'package:flutter/cupertino.dart';
import 'package:midterm/starwar/starwars_list.dart';

class List extends StatefulWidget {
  const List({Key? key}) : super(key: key);

  @override
  _List createState() => _List();
}

class _List extends State<List> {
  @override
  Widget build(BuildContext context) {
    return StarwarsList();
  }
}
