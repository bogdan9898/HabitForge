import 'package:flutter/material.dart';
import 'package:habit_forge/src/models/database.dart';
import 'package:habit_forge/src/calendar_feature/day_container.dart';
import 'package:habit_forge/src/medals_feature/medals_details_view.dart';

import '../settings/settings_view.dart';
import 'package:intl/intl.dart';

import 'package:drift_db_viewer/drift_db_viewer.dart';

class CalendarGridView extends StatefulWidget {
  const CalendarGridView({
    super.key,
  });

  static const routeName = '/';

  @override
  State<CalendarGridView> createState() => _CalendarGridViewState();
}

class _CalendarGridViewState extends State<CalendarGridView> {
  late DateTime currentDateTime;
  late int currentYear;
  late int currentMonthIndex;
  late String currentMonthName;
  late int firstDayOfCurrentMonthIndex;
  late int currentMonthTotalDays;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    updateCurrentDate(now);
  }

  void updateCurrentDate(DateTime dateTime) {
    int year = dateTime.year;
    int monthIndex = dateTime.month;
    String monthName = DateFormat('MMMM').format(dateTime);

    setState(() {
      currentDateTime = dateTime;
      currentYear = year;
      currentMonthIndex = monthIndex;
      currentMonthName = monthName;
      firstDayOfCurrentMonthIndex = getFirstDayIndex(dateTime);
      currentMonthTotalDays = getTotalDaysOfMonth(dateTime);
    });
  }

  int getFirstDayIndex(DateTime? dateTime) {
    int year = currentYear;
    int month = currentMonthIndex;
    if (dateTime != null) {
      year = dateTime.year;
      month = dateTime.month;
    }
    dateTime = DateTime(year, month, 1);
    const List weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    String firstDayOfMonth = DateFormat('E').format(dateTime);
    return weekDays.indexOf(firstDayOfMonth);
  }

  int getTotalDaysOfMonth(DateTime? dateTime) {
    int year = currentYear;
    int month = currentMonthIndex;
    if (dateTime != null) {
      year = dateTime.year;
      month = dateTime.month;
    }
    dateTime = DateTime(year, month + 1, 0);
    return dateTime.day;
  }

  @override
  Widget build(BuildContext context) {
    const List weekDays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    Row headers = Row(
      children: List.generate(
        7,
        (i) {
          return Flexible(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[700],
              ),
              child: Center(
                child: Text(weekDays[i]),
              ),
            ),
          );
        },
      ),
    );
    List<Widget> daysWidgets = List.generate(11, (i) {
      if (i % 2 != 0) {
        return const Divider(
          height: 1,
          color: Colors.grey,
        );
      }
      return Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            13,
            (j) {
              if (j % 2 != 0) {
                return const VerticalDivider(
                  width: 1,
                  color: Colors.grey,
                );
              }
              int dayIndex =
                  i ~/ 2 * 7 + j ~/ 2 + 1 - firstDayOfCurrentMonthIndex;
              if (dayIndex < 0 || dayIndex > currentMonthTotalDays) {
                dayIndex = 0;
              }
              Widget widget = DayContainer(dayIndex: dayIndex);
              if (0 == dayIndex) {
                return Flexible(
                  flex: 1,
                  child: Visibility(
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: false,
                    child: widget,
                  ),
                );
              }
              return Flexible(
                flex: 1,
                child: widget,
              );
            },
          ),
        ),
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('$currentMonthName $currentYear'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {
              updateCurrentDate(DateTime(currentYear, currentMonthIndex + 1));
            },
          ),
          PopupMenuButton<String>(
            onSelected: (String choice) {
              switch (choice) {
                case 'Settings':
                  Navigator.restorablePushNamed(
                    context,
                    SettingsView.routeName,
                  );
                  break;
                case 'Database view':
                  AppDatabase dbInstance = AppDatabase.instance;
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DriftDbViewer(dbInstance),
                    ),
                  );
                  break;
                case 'Medals':
                  Navigator.restorablePushNamed(
                    context,
                    MedalsDetailsView.routeName,
                  );
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return {
                ['Medals', const Icon(Icons.military_tech)],
                ['Settings', const Icon(Icons.settings)],
                ['Database view', const Icon(Icons.table_view)],
              }.map((List choice) {
                return PopupMenuItem<String>(
                  value: choice[0],
                  child: Row(
                    children: [
                      choice[1],
                      const SizedBox(width: 20),
                      Text(choice[0]),
                    ],
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            print("SWIPED RIGHT");
          } else if (details.primaryVelocity! < 0) {
            print("SWIPED LEFT");
          }
        },
        child: Column(children: [headers, ...daysWidgets]),
      ),
    );
  }
}
