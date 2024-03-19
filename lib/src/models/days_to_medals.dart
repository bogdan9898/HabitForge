import 'package:drift/drift.dart';
import 'package:habit_forge/src/models/days.dart';
import 'package:habit_forge/src/models/medals.dart';

@DataClassName('DaysToMedals')
class DaysToMedalsModel extends Table {
  @override
  Set<Column> get primaryKey => {dayId, medalId};

  IntColumn get dayId => integer().references(DaysModel, #id)();
  IntColumn get medalId => integer().references(MedalsModel, #id)();
}
