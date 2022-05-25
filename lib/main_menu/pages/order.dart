import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sublimed_health/model/order_details.dart';
import '../../components/constants.dart';
import '../menu.dart';


class PharmOrder extends StatefulWidget {
  const PharmOrder({Key? key}) : super(key: key);

  @override
  State<PharmOrder> createState() => _PharmOrderState();
}

class _PharmOrderState extends State<PharmOrder> {
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController addressController = TextEditingController();
  final TextEditingController prescriptionController =  TextEditingController();

  // firebase
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {

    final prescriptionField = TextFormField(
      minLines: 1,
      maxLines: 5,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Fill in Prescription field");
        }
        return null;
      },
      controller: prescriptionController,
      keyboardType: TextInputType.multiline,
      onSaved: (value) {
        prescriptionController.text = value!;
      },
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(6, 0, 20, 80),
          labelText: 'Prescription',
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )),
      textInputAction: TextInputAction.next,
    );

    final addrressField = TextFormField(
      minLines: 1,
      controller: addressController,
      maxLines: 5,
      keyboardType: TextInputType.multiline,
      onSaved: (value) {
        addressController.text = value!;
      },
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(15, 5, 0, 0),
          labelText: 'Address',
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )),
      textInputAction: TextInputAction.done,
    );

    final orderButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: kPrimaryColor,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width * 0.4,
          onPressed: () {
            placeOrder().then((value) =>  Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const HomeScreen();
                },
              ),
            ));

          },
          child: const Text(
            "Order Prescription",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Order",
            style: TextStyle(color: kPrimaryColor),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: kPrimaryColor),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()));
              }),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                const SizedBox(height: 32,),
                const Text("Place your prescription order as recommended by the doctor", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300 ),),
                SizedBox(
                  height: 710,
                  width: 500,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 350, child: prescriptionField),
                      const SizedBox(height: 40),
                        SizedBox(width: 350, child: addrressField),
                        const SizedBox(height: 50),
                        Positioned(right: 0, bottom: 0, child: orderButton),
                        const SizedBox(height: 10),
                        Image.asset("assets/Medicine.gif"),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
 );
  }
  Future<void> placeOrder() async {
    if (_formKey.currentState!.validate()) {
      try {
        _auth;

        postDetailsToFirestore();


      } on FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    }
  }
  postDetailsToFirestore() async {

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

Order ordering = Order();
    // writing all the values
    ordering.prescription=prescriptionController.text;
    ordering.address=addressController.text;

    await firebaseFirestore
        .collection('users/uid/order_info')
        .doc(user?.uid)
        .set(ordering.toMap());
    AlertDialog alert = AlertDialog(

      title: const Text("Order success"),
      content: Image.asset("assets/delivery_address.gif"),
    elevation: 5,

      actions:  [
        okButton
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );

  }

  Widget okButton = TextButton(
    child: const Text("OK", style: TextStyle(color: kPrimaryColor),),
    onPressed: () { },
  );
}
