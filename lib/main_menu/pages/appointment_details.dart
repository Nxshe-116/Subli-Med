import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:sublimed_health/mainComponents/appointments.dart';
import 'package:sublimed_health/main_menu/menu.dart';
import 'package:sublimed_health/model/appointment_info.dart';

import '../../call_page/home.dart';
import '../../components/constants.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<Details> {

  User? user = FirebaseAuth.instance.currentUser;
  Appointmentinfo appointmentDB = Appointmentinfo();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users/uid/appointment")
        .doc(user!.uid)
        .get()
        .then((value) {
      appointmentDB = Appointmentinfo.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(25.0),
          child: Center(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  height: 600,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'Scheduled Appointment',
                        textScaleFactor: 1.9,
                        style: TextStyle(color: kPrimaryColor),
                      ),
                      const SizedBox(
                        height: 55,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Name of Doctor:",
                                style: TextStyle(fontSize: 18),
                              ),
                              const SizedBox(
                                height: 20,
                              ),

                              Text(
                                "${appointmentDB.nameOfDoctor}",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Reason for scheduling Appointment",
                                style: TextStyle(fontSize: 18),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              if (appointmentDB.reason == null)
                                const Text(
                                  "--",
                                  style: TextStyle(fontSize: 20),
                                )
                              else
                                Text(
                                  "${appointmentDB.reason}",
                                  style: const TextStyle(fontSize: 20),
                                )
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Date of appointment",
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              if (appointmentDB.date == null)
                                const Text(
                                  "--",
                                  style: TextStyle(fontSize: 20),
                                )
                              else
                                Text("${appointmentDB.date?.toIso8601String()}",
                                    style: const TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold))
                            ],
                          ),

                        ],
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      Row(
                        children: [
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(30),
                            color: kPrimaryColor,
                            child: MaterialButton(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.4,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const HomeScreen();
                                      },
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Done",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                          const SizedBox(width: 10),
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(30),
                            color: kPrimaryColor,
                            child: MaterialButton(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.4,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const AppointmentPage();
                                      },
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Reschedule",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                 Card(
                    color: Colors.white,
                    elevation: 5,
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                       onTap: () {
                         //if(appointmentDB.date==DateTime.now()) {
                           Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const CallHomePage()));
                         //}
                         /*else{
                           AlertDialog alert = AlertDialog(

                             title:  const Text("Oops! It's not yet time for the appointment"),
                             content: Image.asset("assets/wait.png"),
                             elevation: 5,

                             actions:  const [

                             ],
                           );
                           // show the dialog
                           showDialog(
                             context: context,
                             builder: (BuildContext context) {
                               return alert;
                             },
                           );
                         }*/

                      },

                      contentPadding: const EdgeInsets.only(right: 30, left: 36),
                      title: const Text(
                        "Consultation room",
                        style: TextStyle(color: kPrimaryColor),
                      ),
                      trailing: const Icon(
                        Icons.video_call,size: 20,
                        color: kPrimaryColor,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
