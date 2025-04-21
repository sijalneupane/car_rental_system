import 'package:car_rental_system/model/car.dart';
import 'package:car_rental_system/model/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetUserInfo {
  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");
    if (userId != null) {
      return userId;
    } else {
      return null;
    }
  }
  // Future<User?> getUserDetails(String userId) async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   firestore.collection("Register").doc(userId).get().then((value) {
  //     // if (value.exists) {
  //       print(value);
  //       User user = User.fromJson(value.data() as Map<String, dynamic>);
  //       return user;
  //     // }
  //   });
  //   return null;
  // }
// }
Future<Users?> getUserDetails(String userId) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  DocumentSnapshot doc = await firestore.collection("Register").doc(userId).get();

  if (doc.exists && doc.data() != null) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    Users user = Users.fromJson(data);
    user.userId=userId;
    return user;
  }

  return null;
}
}