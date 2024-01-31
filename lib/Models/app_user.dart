import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser{
  String? id;
  String? name;
  String? email;
  String? createdAt;

  AppUser({this.id,this.name,this.email,this.createdAt});

  factory AppUser.fromDocumentSnapshot(DocumentSnapshot doc){
    dynamic data = doc.data();
    return AppUser(
      id: doc.id,
      name: data["name"],
      email: data["email"],
      createdAt: data["createdAt"]
    );
  }

  AppUser.fromJson(Map<String,dynamic> json){
    id = json["id"];
    name = json["name"];
    email = json["email"];
    createdAt = json["createdAt"];
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = {};
    data["id"] = id;
    data["name"] = name;
    data["email"] = email;
    data["createdAt"] = createdAt;
    return data;
  }

}