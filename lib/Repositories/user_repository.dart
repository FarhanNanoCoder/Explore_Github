import 'package:explore_github/Models/api_response.dart';
import 'package:explore_github/Models/app_user.dart';
import 'package:explore_github/Providers/user_provider.dart';
import 'package:explore_github/Utilities/utility.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository{

  final  _userCollection = FirebaseFirestore.instance.collection("users");

  static Future<APIResponse<bool>> createUser(AppUser appUser)async{
    if(! await Utility.isInternetConnected()){
      return APIResponse<bool>(error: true, message: "No Internet Connection");
    }

    try{
      await FirebaseFirestore.instance.collection("users").doc(appUser.id).set(appUser.toJson());
      return APIResponse<bool>(data: true);
    }catch(e){
      return APIResponse<bool>(error: true, message: e.toString());
    }
  }

  static Future<APIResponse<AppUser?>> getUser(String id)async{
    if(! await Utility.isInternetConnected()){
      return APIResponse<AppUser>(error: true, message: "No Internet Connection");
    }
    UserProvider().setLoader(true);
    try{
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection("users").doc(id).get();
      UserProvider().setLoader(false);
      if(doc.exists){
        return APIResponse<AppUser>(data: AppUser.fromDocumentSnapshot(doc));
      }
      return APIResponse<AppUser>(error: true, message: "User not found");
    }catch(e){
      UserProvider().setLoader(false);
      return APIResponse<AppUser>(error: true, message: e.toString());
    }
  }
}