
class CurrentUser {
  static var userId;
  

  CurrentUser();

  static Map toJson() => {
        'userId': userId,
          
      };

  CurrentUser.fromJson(Map json) {
    CurrentUser.userId = json['userId'];
  }

  static clearUser() {
    CurrentUser.userId = '';
  }

  // Future<bool> userSignUp() async {
  //   var url = "${Variables.apiUrl}signup.php";
  //   var data = {
  //     'Identification': identifications,
  //     'userName': CurrentUser.userName,
  //     'firstName': CurrentUser.firstName,
  //     'lastName': CurrentUser.lastName,
  //     'email': CurrentUser.email,
  //     'mobile': CurrentUser.mobile,
  //     'country': CurrentUser.country,
  //     'city': CurrentUser.city,
  //     'region': CurrentUser.region,
  //     'address': CurrentUser.address,
  //     'secKey': CurrentUser.password,
  //     'fileName': CurrentUser.fileName,
  //     'base64': CurrentUser.base64,
  //     'dateBirth': CurrentUser.dateBirth.toString()
  //   };
  //   print(data);
  //   var res = await http.post(Uri.parse(url), body: data);
  //   print(res.body);
  //   var resbody;
  //   if (res.body.isNotEmpty) {
  //     resbody = json.decode(res.body);
  //   }
  //   CurrentUser.id = '0';
  //   CurrentUser.id = resbody['userId'];
  //   print(resbody['status']);
  //   if (resbody['status'] == 'success') {
  //     Fluttertoast.showToast(
  //         msg: resbody['message'], toastLength: Toast.LENGTH_SHORT);
  //     return true;
  //   } else {
  //     Fluttertoast.showToast(
  //         msg: resbody['message'], toastLength: Toast.LENGTH_SHORT);
  //     return false;
  //   }
  // }

}
