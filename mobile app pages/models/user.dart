import 'package:cloud_firestore/cloud_firestore.dart';
// ignore_for_file: unnecessary_null_comparison

class UserModel {
   String? userId;
 String? name;
  String? email;
  //final String? imageUrl;
 String? password;
   int? postsCount;

UserModel(
      {this.userId,
      this.name,
      this.email,
      /*this.imageUrl,*/

      this.password,
      this.postsCount});

  
 UserModel.fromjson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    } else {
      userId = map['userId'];
      email = map['email'];
      name = map['name'];
      password = map['password'];
    }
  }

  toJson() {
    return {
      'userId' : userId ,
      'email' : email ,
      'name' : name ,
      'pic' : password ,

    };
  }
  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      userId: doc.data().toString().contains('id') ? doc.get('id') : '',
      email: doc.data().toString().contains('email') ? doc.get('email') : '',
      name: doc.data().toString().contains('name') ? doc.get('name') : '',
      password:
          doc.data().toString().contains('password') ? doc.get('password') : '',
      //postsCount: doc.data().toString().contains('postsCount')
        //  ? doc.get('postsCount')
          //: '0',
       postsCount:0   
      //imageUrl: doc.data().toString().contains('imageUrl') ? doc.get('imageUrl') : '',
    );
  }
  
}
