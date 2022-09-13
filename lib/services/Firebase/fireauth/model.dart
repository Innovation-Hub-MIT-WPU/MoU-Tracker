class UserModel {
  String? email;
  String? firstName;
  String? lastName;
  String? designation;

  UserModel({this.email, this.firstName, this.lastName, this.designation});

  // receive data from server -> creating map
  factory UserModel.fromMap(map) {
    return UserModel(
        email: map['email'],
        firstName: map['firstName'],
        lastName: map['lastName'],
        designation: map['designation']);
  }

  //sending data to server
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'designation': designation
    };
  }
}
