import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:habit_forge/src/models/database.dart';
import 'package:habit_forge/src/models/medals_repository.dart';
import 'package:provider/provider.dart';

class MedalsAddForm extends StatefulWidget {
  const MedalsAddForm({
    super.key,
  });

  @override
  State<MedalsAddForm> createState() => _MedalsAddFormState();
}

class _MedalsAddFormState extends State<MedalsAddForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Add new medal",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            TextFormField(
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Name*',
                labelStyle: Theme.of(context).textTheme.labelLarge,
              ),
              validator: (value) {
                if (null == value || value.isEmpty) {
                  return 'Name is mandatory';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Emoji*',
                labelStyle: Theme.of(context).textTheme.labelLarge,
              ),
              validator: (value) {
                if (null == value || value.isEmpty) {
                  return 'Emoji is mandatory';
                }
                if (value.trim().length > 1) {
                  return 'Only one character permited';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  print("wip... sending to db...");
                  await MedalDao(Provider.of<AppDatabase>(
                    context,
                    listen: false,
                  )).createMedal(
                    const MedalsModelCompanion(
                      name: drift.Value('test'),
                      emoji: drift.Value('T'),
                    ),
                  );
                }
              },
              child: const Text('Submit'),
            )
          ],
        ),
      ),
    );
    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   mainAxisSize: MainAxisSize.min,
    //   children: <Widget>[Text('test 1234')],
    // );
  }
}
