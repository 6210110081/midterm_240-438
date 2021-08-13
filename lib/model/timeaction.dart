import 'package:hive/hive.dart';

part 'timeaction.g.dart';

@HiveType(typeId: 0)
class Timeaction extends HiveObject {
  @HiveField(0)
  late String work;

  @HiveField(1)
  late DateTime todayDate;

  @HiveField(2)
  late String groupwork;
}
