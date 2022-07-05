class UserModel {

  String? userid;
  String? email;
  String? firstName;
  String? lastName;
  String? designation;

  UserModel({this.userid, this.email, this.firstName, this.lastName, this.designation});

  // receive data from server -> creating map
  factory UserModel.fromMap(map){
    return UserModel(
      userid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      designation: map['designation']
    );
  }

  //sending data to server
  Map<String, dynamic> toMap(){
    return {
      'userid': userid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'designation': designation
    };
  }
}