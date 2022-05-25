import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sublimed_health/components/constants.dart';
import 'package:sublimed_health/mainComponents/payments.dart';
import '../model/appointment_info.dart';


final List<String> imgList = [
  "https://images.unsplash.com/photo-1594824476967-48c8b964273f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTh8fGRvY3RvcnN8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1559839734-2b71ea197ec2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8ZG9jdG9yc3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1613918108466-292b78a8ef95?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fGRvY3RvcnN8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60"
];

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({
    Key? key,
  }) : super(key: key);

  //final String title;

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {

  DateTime dateTime=DateTime.now();

  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  // our form key
  final _formKey = GlobalKey<FormState>();

  // editing Controller
  final doctorEditingController = TextEditingController();
  final reasonEditingController= TextEditingController();


  @override
  Widget build(BuildContext context) {
    final dateTimeField = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: kPrimaryColor2,
      child: MaterialButton(
          padding:
          const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth:
          MediaQuery.of(context).size.width * 0.6,
          onPressed: pickDateTime,
          child: const Text(
            "Select Appointment Date and Time",
            style: TextStyle(color: kPrimaryColor),
          )),
    );
    final doctorNameField = TextFormField(
        validator: (value) {
          RegExp regex = RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("field cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          doctorEditingController.text = value!;
        },
        controller: doctorEditingController,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Name of Doctor",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final reasonField = TextFormField(
      minLines: 1,
      controller: reasonEditingController,
      maxLines: 5,
      keyboardType: TextInputType.multiline,
      onSaved: (value) {
        reasonEditingController.text = value!;
      },
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 40, horizontal: 5),
          labelText: 'Reason for consultation',
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )),
      textInputAction: TextInputAction.done,
    );
    final proceedButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: kPrimaryColor,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width * 0.4,
          onPressed: () {
            save().then((value) =>  Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const PaymentScreen();
                },
              ),
            ));

          },
          child: const Text(
            "Proceed",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Appointments",
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
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
              items: imageSliders,
            ),
            const SizedBox(height: 20),
            const Text("Schedule Appointment"),
            const SizedBox(height: 20),
            SizedBox(
              height: 550,
              width: 500,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 350, child: doctorNameField),
                    const SizedBox(height: 40),
                    dateTimeField,
                    const SizedBox(height: 25),
                    SizedBox(width: 350, child: reasonField),
                    const SizedBox(height: 50),
                    Positioned(right: 0, bottom: 0, child: proceedButton)
                  ],
                ),
              ),
            )
          ],
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

    Appointmentinfo appInfo = Appointmentinfo();

    // writing all the values
    appInfo.uid = user?.uid;
    appInfo.nameOfDoctor = doctorEditingController.text;
    appInfo.reason = reasonEditingController.text;
    appInfo.date= dateTime;

    await firebaseFirestore
        .collection('users/uid/appointment')
        .doc(user?.uid)
        .set(appInfo.toMap());

    Fluttertoast.showToast(msg: "Appointment details saved successfully",backgroundColor: kPrimaryColor, textColor:Colors.white);

  }

  pickDateTime() async{
    DateTime? date= await pickDate();
    if(date== null) return;

    TimeOfDay? time= await pickTime();
    if(date==null) return;

    final dateTime = DateTime(

        date.year,
      date.month,
      date.day,
      time!.hour,
      time.minute
    );
  setState(() {
    this.dateTime=dateTime;
  });
  }

Future<DateTime?> pickDate() => showDatePicker(
  context: context,
  initialDate: dateTime,
  firstDate: DateTime(2020),
  lastDate: DateTime(2025),
);

Future<TimeOfDay?> pickTime()   => showTimePicker(context: context, initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));}
final List<Widget> imageSliders = imgList
    .map((item) => Container(
          margin: const EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  Image.network(item, fit: BoxFit.cover, width: 1000.0),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [0.3, 1],
                            colors: [Colors.white, kPrimaryColor2]),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),

                    ),
                  ),
                ],
              )),
        ))
    .toList();
