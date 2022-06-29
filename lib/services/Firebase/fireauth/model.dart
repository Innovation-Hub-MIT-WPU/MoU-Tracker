class UserModel {

  String? userid;
  String? email;
  String? firstName;
  String? lastName;

  UserModel({this.userid, this.email, this.firstName, this.lastName});

  // receive data from server -> creating map
  factory UserModel.fromMap(map){
    return UserModel(
      userid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName']
    );
  }

  //sending data to server
  Map<String, dynamic> toMap(){
    return {
      'userid': userid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName
    };
  }
}