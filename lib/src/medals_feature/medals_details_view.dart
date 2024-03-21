import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:habit_forge/src/medals_feature/medals_add_form.dart';
import 'package:habit_forge/src/models/database.dart';
import 'package:habit_forge/src/models/medals_repository.dart';
import 'package:habit_forge/src/utils.dart';

class MedalsDetailsView extends StatefulWidget {
  const MedalsDetailsView({super.key});

  static const routeName = '/sample_item';

  @override
  State<MedalsDetailsView> createState() => _MedalsDetailsViewState();
}

class _MedalsDetailsViewState extends State<MedalsDetailsView> {
  late List<Medal> allMedals;
  late Stream<List<Medal>> allMedalsStream;

  @override
  void initState() {
    super.initState();
    allMedalsStream = MedalDao(AppDatabase.instance).watchAllMedals();

    allMedalsStream.listen((medalsList) {
      setState(() {
        allMedals = medalsList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All medals'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: allMedals.length,
          prototypeItem: ListTile(
            title: Text(allMedals.first.name),
          ),
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(allMedals[index].name),
              subtitle: Text(unicodeStr(allMedals[index].emoji)),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext builder) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: const SizedBox(
                    height: 400,
                    child: MedalsAddForm(),
                  ),
                );
              });
        },
      ),
      // bottomNavigationBar: BottomAppBar(
      //   color: Colors.orange,
      //   child: Container(height: 10),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
