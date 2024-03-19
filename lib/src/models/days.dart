import 'package:drift/drift.dart';

@DataClassName("Day")
class DaysModel extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime().unique()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDate)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
