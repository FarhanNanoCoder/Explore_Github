import 'package:explore_github/Models/api_response.dart';
import 'package:explore_github/Models/app_user.dart';
import 'package:explore_github/Providers/app_auth_provider.dart';
import 'package:explore_github/Repositories/user_repository.dart';
import 'package:explore_github/Utilities/utility.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
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
        APIResponse<bool> res = await UserRepository.createUser(user);
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
            await UserRepository.getUser(userCredential.user!.uid);
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
}
