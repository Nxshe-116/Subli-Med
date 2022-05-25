
class Appointmentinfo {
  String? uid;
  String? nameOfDoctor;
  DateTime? date;
  String? reason;


  Appointmentinfo({this.uid, this.nameOfDoctor,this.date,this.reason, });

  // receiving data from server
  factory Appointmentinfo.fromMap(map) {
    return Appointmentinfo(
      uid: map['uid'],
      nameOfDoctor: map['Doctor'],
      date: map['Date'],
      reason: map['Reason'],

    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'Doctor': nameOfDoctor,
      'Date': date,
      'Reason': reason,

    };
  }
}