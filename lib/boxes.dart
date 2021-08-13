import 'package:hive/hive.dart';
import 'package:midterm/model/timeaction.dart';

class Boxes {
  static Box<Timeaction> getTimeactions() =>
      Hive.box<Timeaction>('timeactions');
}
