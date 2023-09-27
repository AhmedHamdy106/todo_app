import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/network_layer/firestore_utils.dart';
import 'package:todo_app/core/theme/app_theme.dart';
import 'package:todo_app/models/TaskModel.dart';
import 'package:todo_app/moduls/settings/settings_view.dart';
import 'package:todo_app/moduls/tasks_list/tasks_list_view.dart';
import 'package:todo_app/settings_provider.dart';
import 'package:todo_app/utils/my_date_time.dart';

import '../core/network_layer/user-data.dart';
import '../core/services/toast.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = "home_layout";

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  var formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  int selectedIndex = 0;
  List<Widget> screens = [
    TasksListView(),
    SettingsView(),
  ];
  String? name;

  @override
  void initState() {
    // TODO: implement initState
    UserDatabase.getUser(id: FirebaseAuth.instance.currentUser!.uid)
        .then((value) {
      name = value;
      setState(() {});
    });
  }

  // const HomeLayout({super.key});
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<SettingProvider>(context);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(!provider.isDark()
              ? "assets/images/background.png"
              : "assets/images/dark_background.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        body: screens[selectedIndex],
        extendBody: true,
        floatingActionButton: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: FloatingActionButton(
            onPressed: () {
              showAddTaskBottomSheet();
            },
            tooltip: ('add new task'),
            child: Icon(Icons.add),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (int index) {
              setState(() {
                selectedIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu,
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "settings"),
            ],
          ),
        ),
      ),
    );
  }

  void showAddTaskBottomSheet() {
    // var provider = Provider.of<SettingProvider>(context);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        topLeft: Radius.circular(20),
      )),
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 28.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Add New Task",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        // color: ! provider.isDark() ? Colors.black : Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text("Title",
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          // color: ! provider.isDark() ? Colors.black : Colors.white,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
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
                    const SizedBox(
                      height: 20,
                    ),
                    Text("Description",
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          // color: ! provider.isDark() ? Colors.black : Colors.white,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
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
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Select Time",
                      style: GoogleFonts.poppins(
                        fontSize: 17, fontWeight: FontWeight.bold,
                        // color: ! provider.isDark() ? Colors.black : Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        addTask();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: Text(
                              "add Task",
                              style: GoogleFonts.poppins(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
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
      ),
      //  AddTask
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
        dateTime: MyDateTime.exctractDateonly(selectedDate),
        isDone: false,
      );
      try {
        EasyLoading.show();
        await FirestoreUtils.addTask(taskModel);
        EasyLoading.dismiss();
        Tost.ShowTost(
          massage: "A task has been added",
          toastGravity: ToastGravity.TOP,
        );
        // SnackBarServices.showSuccessMessage("Task added Successfuly");
        Navigator.pop(context);
      } catch (e) {
        EasyLoading.dismiss();
        Tost.ShowTost(
          massage: "A task hasn't been added",
          toastGravity: ToastGravity.TOP,
        );
        // SnackBarServices.showErrorMessage("Task added Failed");
        Navigator.pop(context);
      }
    }
  }
}
