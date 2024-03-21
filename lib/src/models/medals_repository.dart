import 'package:drift/drift.dart';
import 'package:habit_forge/src/models/database.dart';
import 'package:habit_forge/src/models/medals.dart';

part 'medals_repository.g.dart';

@DriftAccessor(tables: [MedalsModel])
class MedalDao extends DatabaseAccessor<AppDatabase> with _$MedalDaoMixin {
  MedalDao(AppDatabase db) : super(db);

  Future<Medal?> createMedal(MedalsModelCompanion newMedal) {
    return into(medalsModel).insertReturning(newMedal);
  }

  Future<void> updateMedal() {
    // TODO: implement updateMedal
    throw UnimplementedError();
  }

  Stream<Medal?> watchMedalById(int id) {
    return (select(medalsModel)..where((t) => t.id.equals(id))).watchSingle();
  }

  Stream<List<Medal>> watchAllMedals() {
    return select(medalsModel).watch();
  }

  Future<void> deleteMedal() {
    // TODO: implement deleteMedal
    throw UnimplementedError();
  }
}
