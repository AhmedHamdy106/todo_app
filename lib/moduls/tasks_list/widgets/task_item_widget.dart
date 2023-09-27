import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/network_layer/firestore_utils.dart';
import 'package:todo_app/core/theme/app_theme.dart';

import '../../../models/TaskModel.dart';

class TaskItemWidget extends StatefulWidget {
  final TaskModel model;

  const TaskItemWidget({super.key, required this.model});

  @override
  State<TaskItemWidget> createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {
  var formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as TaskModel;

    titleController.text = args.title!;
    descriptionController.text = args.description!;
    selectedDate = args.dateTime!;

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Slidable(
          startActionPane: ActionPane(
            extentRatio: 0.5,
            motion: BehindMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  FirestoreUtils.deleteData(widget.model);
                },
                icon: Icons.delete,
                label: "Delete",
                backgroundColor: Colors.red,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
              ),
              SlidableAction(
                onPressed: (context) {
                  showEditbottomSheet(context);
                },
                icon: Icons.edit,
                label: "Edit",
                backgroundColor: Colors.green,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
              )
            ],
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 5.0,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    color: AppTheme.lightPrimary,
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.model.title ?? "",
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.lightPrimary),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.model.description ?? "",
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          widget.model.dateTime.toString(),
                          style: GoogleFonts.roboto(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: AppTheme.lightPrimary,
                      borderRadius: BorderRadius.circular(12.0)),
                  child: Icon(
                    Icons.check,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showEditbottomSheet(context) {
    showModalBottomSheet(
      context: context,
      // isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        topLeft: Radius.circular(20),
      )),
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Edit Task",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  Text("Title",
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        // color: ! provider.isDark() ? Colors.black : Colors.white,
                      )),
                  Spacer(),
                  TextFormField(
                    controller: titleController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Title cannot be empty";
                      } else if (value.length < 10) {
                        return "Title must be at least 10 characters";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Your Task Title",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Text("Description",
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        // color: ! provider.isDark() ? Colors.black : Colors.white,
                      )),
                  Spacer(),
                  TextFormField(
                    controller: descriptionController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Title cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    maxLines: 2,
                    minLines: 2,
                    decoration: InputDecoration(
                      hintText: "Enter Your Task Description",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    "Select Time",
                    style: GoogleFonts.poppins(
                      fontSize: 17, fontWeight: FontWeight.bold,
                      // color: ! provider.isDark() ? Colors.black : Colors.white,
                    ),
                  ),
                  Spacer(),
                  Center(
                      child: InkWell(
                    onTap: () {
                      selectDateTime();
                    },
                    child: Text(
                      (DateFormat.yMMMEd().format(selectedDate)),
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.lightPrimary),
                    ),
                  )),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      addTask();
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Text(
                            "Save Changes  ",
                            style: GoogleFonts.poppins(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  selectDateTime() async {
    var currentDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(days: 365),
      ),
    );

    if (currentDate == null) {
      return;
    }

    setState(() {
      selectedDate = currentDate;
    });
  }

  void addTask() async {
    if (formKey.currentState!.validate()) {
      TaskModel taskModel = TaskModel(
        title: titleController.text,
        description: descriptionController.text,
        dateTime: selectedDate,
        isDone: false,
      );
      try {
        EasyLoading.show();
        await FirestoreUtils.addTask(taskModel);
        EasyLoading.dismiss();
        // SnackBarServices.showSuccessMessage("Task added Successfuly");
        Navigator.pop(context);
      } catch (e) {
        EasyLoading.dismiss();
        // SnackBarServices.showErrorMessage("Task added Failed");
        Navigator.pop(context);
      }
    }
  }
}
