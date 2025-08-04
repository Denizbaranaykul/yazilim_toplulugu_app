import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yazilim_toplulugu_app/models/user_model.dart';

//firebase e istek yapacağımız nokta
class UserService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> createUserDataBase(UserModel user) async {
    try {
      await firestore.collection("users").doc(user.uid).set(user.toJson());
    } catch (e) {
      print("kullanıcı oluşturma hatası$e");
    }
  }
}
