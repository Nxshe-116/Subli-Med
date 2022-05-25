import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sublimed_health/components/constants.dart';
import 'package:sublimed_health/model/medical_info.dart';


class View extends StatefulWidget {
  const View({Key? key}) : super(key: key);

  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  TextEditingController tempController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController bpController = TextEditingController();
  TextEditingController hrController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Record Vitals",
          style: TextStyle(color: kPrimaryColor),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kPrimaryColor),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 600,
          width: 500,
          color: Colors.white,
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: size.height*0.05),
                const Text(
                  'Input readings on your medical equipment',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Temperature:'),
                    SizedBox(width: size.width*0.23),
                    SizedBox(
                      height: 40,
                      width: 80,
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          tempController.text = value!;
                        },
                        autofocus: false,
                        controller: tempController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: '°C',
                          border: OutlineInputBorder(),
                        ),
                        style: const TextStyle(fontSize: 20), // <-- SEE HERE
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Blood Pressure:'),
                    SizedBox(width: size.width*0.26),
                    SizedBox(
                      height: 40,
                      width: 90,
                      child: TextFormField(
                        autofocus: false,
                        textInputAction: TextInputAction.next,
                        controller: bpController,
                        onSaved: (value) {
                          bpController.text = value!;
                        },
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'mmHg',
                          border: OutlineInputBorder(),
                        ),
                        style: const TextStyle(fontSize: 20), // <-- SEE HERE
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Weight:'),
                    SizedBox(width: size.width*0.4),
                    SizedBox(
                      height: 40,
                      width: 80,
                      child: TextFormField(
                        autofocus: false,
                        textInputAction: TextInputAction.next,
                        controller: weightController,
                        onSaved: (value) {
                          weightController.text = value!;
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'kg',
                          border: OutlineInputBorder(),
                        ),
                        style: const TextStyle(fontSize: 20), // <-- SEE HERE
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Heart Beat (BPM):'),
                    SizedBox(width: size.width*0.23),
                    SizedBox(
                      height: 40,
                      width: 80,
                      child: TextFormField(
                        autofocus: false,
                        controller: hrController,
                        onSaved: (value) {
                          hrController.text = value!;
                        },
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'bpm',
                          border: OutlineInputBorder(),
                        ),
                        style: const TextStyle(fontSize: 20), // <-- SEE HERE
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 40,),
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(30),
                  color: kPrimaryColor,
                  child: MaterialButton(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      minWidth: MediaQuery.of(context).size.width * 0.4,
                      onPressed: () {
                    save();
                      },
                    child: const Text("Save",style: TextStyle(color: Colors.white),)),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> save() async {
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

    Database medicalInfo = Database();

    // writing all the values
    medicalInfo.uid = user?.uid;
    medicalInfo.temperature = tempController.text;
    medicalInfo.bp = bpController.text;
    medicalInfo.weight=weightController.text;
    medicalInfo.hr=hrController.text;

    await firebaseFirestore
        .collection('users/uid/medical_info')
        .doc(user?.uid)
        .set(medicalInfo.toMap());
    Fluttertoast.showToast(msg: "Readings have been saved successfully",backgroundColor: kPrimaryColor, textColor:Colors.white);

  }
}

