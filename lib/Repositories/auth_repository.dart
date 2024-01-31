import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore_github/Models/api_response.dart';
import 'package:explore_github/Models/app_user.dart';
import 'package:explore_github/Providers/app_auth_provider.dart';
import 'package:explore_github/Repositories/github_user_repository.dart';
import 'package:explore_github/Utilities/utility.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final _userCollection = FirebaseFirestore.instance.collection("users");

  static Future<APIResponse<bool>> createUser(AppUser appUser) async {
    if (!await Utility.isInternetConnected()) {
      return APIResponse<bool>(error: true, message: "No Internet Connection");
    }

    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(appUser.id)
          .set(appUser.toJson());
      return APIResponse<bool>(data: true);
    } catch (e) {
      return APIResponse<bool>(error: true, message: e.toString());
    }
  }

  static Future<APIResponse<AppUser?>> getUser(String id) async {
    if (!await Utility.isInternetConnected()) {
      return APIResponse<AppUser>(
          error: true, message: "No Internet Connection");
    }

    try {
      DocumentSnapshot doc =
          await FirebaseFirestore.instance.collection("users").doc(id).get();

      if (doc.exists) {
        return APIResponse<AppUser>(data: AppUser.fromDocumentSnapshot(doc));
      }
      return APIResponse<AppUser>(error: true, message: "User not found");
    } catch (e) {
      return APIResponse<AppUser>(error: true, message: e.toString());
    }
  }

  static Future<APIResponse<AppUser?>> registerUser(
      {required String name,
      required String email,
      required String password}) async {
    if (!await Utility.isInternetConnected()) {
      return APIResponse<AppUser>(
          error: true, message: "No Internet Connection");
    }

    AppAuthProvider().setLoader(true);
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        AppUser user = AppUser(
            id: userCredential.user!.uid,
            name: name,
            email: email,
            createdAt: DateTime.now().toString());
        APIResponse<bool> res = await AuthRepository.createUser(user);
        AppAuthProvider().setLoader(false);
        if (res.error!) {
          return APIResponse<AppUser>(error: true, message: res.message);
        }
        Utility.showSnackBar("User Registered Successfully");
        return APIResponse<AppUser>(data: user);
      }

      return APIResponse<AppUser>(error: true, message: "Something went wrong");
    } catch (e) {
      Utility.showSnackBar(e.toString());
      AppAuthProvider().setLoader(false);
      return APIResponse<AppUser>(error: true, message: e.toString());
    }
  }

  static Future<APIResponse<AppUser?>> loginUser(
      {required String email, required String password}) async {
    if (!await Utility.isInternetConnected()) {
      return APIResponse<AppUser>(
          error: true, message: "No Internet Connection");
    }

    AppAuthProvider().setLoader(true);
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        APIResponse<AppUser?> res =
            await AuthRepository.getUser(userCredential.user!.uid);
        AppAuthProvider().setLoader(false);
        if (res.data != null) {
          Utility.showSnackBar("User Logged In Successfully");
          AppAuthProvider().setAppUser(res.data);
          return APIResponse<AppUser>(data: res.data);
        }

        return APIResponse<AppUser>(error: true, message: res.message);
      }

      return APIResponse<AppUser>(error: true, message: "Something went wrong");
    } catch (e) {
      Utility.showSnackBar(e.toString());
      AppAuthProvider().setLoader(false);
      return APIResponse<AppUser>(error: true, message: e.toString());
    }
  }

  static Future<APIResponse<bool>> signout() async {
    AppAuthProvider().setLoader(true);
    try {
      await FirebaseAuth.instance.signOut();
      AppAuthProvider().setLoader(false);
      AppAuthProvider().setAppUser(null);
      return APIResponse<bool>(data: true);
    } catch (e) {
      Utility.showSnackBar(e.toString());
      AppAuthProvider().setLoader(false);
      return APIResponse<bool>(error: true, message: e.toString());
    }
  }
}
