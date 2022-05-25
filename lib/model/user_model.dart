class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? surname;
  String? doctor;
  DateTime? time;

  UserModel({this.uid, this.email, this.firstName, this.surname, this.doctor, this.time});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      surname: map['Surname'],
      doctor: map['doctor'],
      time: map['time'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'Surname': surname,
      'doctor': doctor,
      'time': time,

    };
  }
}