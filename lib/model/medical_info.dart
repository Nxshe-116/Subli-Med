
class Database {

  String? uid;
  String? temperature;
  String? bp;
  String? weight;
  String? hr;

  Database({this.uid, this.temperature,this.bp,this.weight,this.hr});

  // receiving data from server
  factory Database.fromMap(map) {
    return Database(
      uid: map['uid'],
      temperature: map['temperature'],
      bp: map['bp'],
      weight: map['weight'],
      hr: map['heartRate'],

    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'temperature': temperature,
      'bp': bp,
      'weight': weight,
      'heartRate': hr,


    };
  }
}