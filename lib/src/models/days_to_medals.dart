import 'package:drift/drift.dart';
import 'package:habit_forge/src/models/days.dart';
import 'package:habit_forge/src/models/medals.dart';

class DaysToMedals extends Table {
  @override
  Set<Column> get primaryKey => {dayId, medalId};

  IntColumn get dayId => integer().references(Days, #id)();
  IntColumn get medalId => integer().references(Medals, #id)();
}
