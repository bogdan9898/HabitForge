import 'package:drift/drift.dart';

class Days extends Table {
  // @override
  // List<Set<Column>> get uniqueKeys => [
  //       {year, month, day}
  //     ];

  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime().unique()();
  // IntColumn get year => integer().check(year.isBetweenValues(2000, 3000))();
  // IntColumn get month => integer().check(month.isBetweenValues(1, 12))();
  // IntColumn get day => integer().check(day.isBetweenValues(1, 31))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDate)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
