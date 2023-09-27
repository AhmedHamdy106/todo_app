import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/TaskModel.dart';
import 'package:todo_app/utils/my_date_time.dart';

class FirestoreUtils {
  static CollectionReference<TaskModel> getCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(
          fromFirestore: (snapshot, _) =>
              TaskModel.FromFirestore(snapshot.data()!),
          toFirestore: (taskModel, _) => taskModel.toFirestore(),
        );
  }

  static Future<void> addTask(TaskModel taskModel) async {
    var collection = getCollection();
    var doc = collection.doc();
    taskModel.id = doc.id;
    return doc.set(taskModel);
  }

  static Stream<QuerySnapshot<TaskModel>> getRealTimeDataFromFirestore(
      DateTime dateTime) {
    return getCollection()
        .where("dateTime",
            isEqualTo:
                MyDateTime.exctractDateonly(dateTime).millisecondsSinceEpoch)
        .snapshots();

    // List<TaskModel>tasksList = querySnapshots.docs.map((element) => element.data()).toList();
    // return tasksList;
  }

  static Future<List<TaskModel>> getDataFromFirestore() async {
    var snapshots = await getCollection().get();
    List<TaskModel> tasksList =
        snapshots.docs.map((element) => element.data()).toList();
    return tasksList;
  }

  static Future<void> deleteData(TaskModel model) {
    var collectionRef = getCollection().doc(model.id);
    return collectionRef.delete();
  }

  static Future<void> UpdateTask(TaskModel TaskModel) {
    var collection = getCollection();
    return collection.doc(TaskModel.id).update(TaskModel.toFirestore());
  }

  static Future<void> doneTask(TaskModel taskModel) async {
    await getCollection()
        .doc(taskModel.id)
        .update({"isDone": !taskModel.isDone!});
  }
}
