import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/network_layer/firestore_utils.dart';
import 'package:todo_app/core/theme/app_theme.dart';
import 'package:todo_app/moduls/tasks_list/widgets/task_item_widget.dart';

import '../../models/TaskModel.dart';

class TasksListView extends StatefulWidget {
  const TasksListView({super.key});

  @override
  State<TasksListView> createState() => _TasksListViewState();
}

class _TasksListViewState extends State<TasksListView> {
  List<TaskModel> allTasks = [];
  DateTime selectedDate = DateTime.now();

  // @override
  // void initState() {
  //  loadTask();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: 40, left: 20),
          width: mediaQuery.width,
          height: mediaQuery.height * 0.15,
          color: AppTheme.lightPrimary,
          child: Text(
            "To Do List",
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          color: Colors.grey,
          padding: EdgeInsets.symmetric(vertical: 12),
          margin: EdgeInsets.symmetric(vertical: 12),
          child: CalendarTimeline(
            initialDate: selectedDate,
            firstDate: DateTime.now().subtract(Duration(days: 30)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date) {
              selectedDate = date;
              setState(() {});
              Padding(padding: EdgeInsets.only(bottom: 12));
            },
            leftMargin: 20,
            monthColor: Colors.black,
            dayColor: Colors.black,
            activeDayColor: AppTheme.lightPrimary,
            activeBackgroundDayColor: Colors.white,
            dotsColor: Color(0xFF333A47),
          ),
        ),
        Expanded(
          child: StreamBuilder(
              stream: FirestoreUtils.getRealTimeDataFromFirestore(selectedDate),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Error Eccoured");
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: AppTheme.lightPrimary,
                  ));
                }
                var tasksList =
                    snapshot.data?.docs.map((e) => e.data()).toList();
                return ListView.builder(
                  itemBuilder: (context, index) => TaskItemWidget(
                    model: tasksList![index],
                  ),
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: tasksList?.length ?? 0,
                );
              }),
        ),
      ],
    );
  }

// loadTask() {
//   FirestoreUtils.getDataFromFirestore().then((value) {
//     setState(() {
//       allTasks=value;
//     });
//   });
// }
}
