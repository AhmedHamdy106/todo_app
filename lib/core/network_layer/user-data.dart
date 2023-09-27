import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user_model.dart';

class UserDatabase {
  static CollectionReference<UserModel> getCollection() {
    return FirebaseFirestore.instance
        .collection(UserModel.collectionName)
        .withConverter<UserModel>(
      fromFirestore: (snapshot, options) {
        return UserModel.fromFireStore(snapshot.data() ?? {});
      },
      toFirestore: (value, options) {
        return value.toFireStore();
      },
    );
  }

  static Future<void> addUser(UserModel userModel, String uid) async {
    var collection = getCollection();
    var doc = collection.doc(uid);
    await doc.set(userModel);
  }

  static Future<String?> getUser({required String id}) async {
    DocumentSnapshot<UserModel> getDoc = await getCollection().doc(id).get();
    print("get name : ${getDoc.data()?.name}");
    return getDoc.data()?.name;
  }
}
