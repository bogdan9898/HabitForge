import 'package:flutter/material.dart';
import 'package:habit_forge/src/medals_feature/medals_add_form.dart';

/// Displays detailed information about a SampleItem.
class MedalsDetailsView extends StatelessWidget {
  const MedalsDetailsView({super.key});

  static const routeName = '/sample_item';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All medals'),
      ),
      body: const Center(
        child: Text('WIP...'),
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
                    child: Center(
                      child: MedalsAddForm(),
                    ),
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
