class UserModel {
  String? email;
  String? firstName;
  String? lastName;
  String? designation;
  int? pos;
  List? positions;
  UserModel(
      {this.email,
      this.firstName,
      this.lastName,
      this.designation,
      this.pos,
      this.positions});

  // receive data from server -> creating map
  factory UserModel.fromMap(map) {
    return UserModel(
        pos: map['pos'],
        email: map['email'],
        lastName: map['lastName'],
        firstName: map['firstName'],
        positions: map['positions'] as List,
        designation: map['designation']);
  }

  //sending data to server
  Map<String, dynamic> toMap() {
    return {
      'pos': pos,
      'email': email,
      'lastName': lastName,
      'firstName': firstName,
      'designation': designation,
      'positions': positions
    };
  }
}
