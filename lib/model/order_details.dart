
class Order {
  String? uid;
  String? prescription;
  String? address;


  Order({this.uid, this.address, this.prescription, });

  // receiving data from server
  factory Order.fromMap(map) {
    return Order(
      uid: map['uid'],
      address: map['address'],
      prescription: map['prescription'],

    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'address': address,
      'prescription': prescription,

    };
  }
}