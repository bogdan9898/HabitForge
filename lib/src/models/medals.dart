import 'package:drift/drift.dart';

@DataClassName("Medal")
class MedalsModel extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
  TextColumn get description => text().nullable()();
  TextColumn get emoji => text().unique()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDate)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
