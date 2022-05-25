import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sublimed_health/components/constants.dart';
import 'package:sublimed_health/model/medical_info.dart';
import 'package:sublimed_health/model/view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const VitalsPage());
}

class VitalsPage extends StatefulWidget {
  const VitalsPage({Key? key}) : super(key: key);

  @override
  State<VitalsPage> createState() => _VitalsPageState();
}

class _VitalsPageState extends State<VitalsPage> {

  User? user = FirebaseAuth.instance.currentUser;
  Database loggedInUser = Database();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users/uid/medical_info")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = Database.fromMap(value.data());
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(32.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: kPrimaryColor,
                    ),
                    height: 400,
                    width: 500,
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        const Text(
                          'Previous Readings',
                          textScaleFactor: 1.7,
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 60),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(

                                      height: 20,
                                      width: 20,

                                      child: Image.asset("assets/temp.png"),
                                    ),
                                    const SizedBox(width: 15),
                                    const Text(
                                      "Temperature",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                if(loggedInUser.temperature ==null)
                                   const Text("--", style: TextStyle(fontSize: 40,color: Colors.white),)
                                else
                                  Text(
                                    "${loggedInUser.temperature} °C",
                                  style: const TextStyle(
                                      fontSize: 40, color: Colors.white),
                                ),
                              ],
                            ),
                            const SizedBox(width: 30),
                            Column(
                              children:  [
                                Row(
                                  children: [
                                    SizedBox(

                                      height: 20,
                                      width: 20,

                                      child: Image.asset("assets/bp.png"),
                                    ),
                                    const SizedBox(width: 15),
                                    const Text(
                                      "Blood Pressure",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                if(loggedInUser.bp ==null)
                                  const Text("--", style: TextStyle(fontSize: 40,color: Colors.white),)
                                else
                                 Text(
                                  "${loggedInUser.bp}",
                                  style: const TextStyle(
                                      fontSize: 40, color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children:  [
                                Row(
                                  children: [
                                    SizedBox(

                                      height: 20,
                                      width: 20,

                                      child: Image.asset("assets/weight.png"),
                                    ),
                                    const SizedBox(width: 15),
                                    const Text(
                                      "Weight",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                if(loggedInUser.weight ==null)
                                  const Text("--", style: TextStyle(fontSize: 40,color: Colors.white),)
                                else
                                 Text(
                                  "${loggedInUser.weight} kg",
                                  style: const TextStyle(
                                      fontSize: 40, color: Colors.white),
                                ),
                              ],
                            ),
                            const SizedBox(width: 30),
                            Column(
                              children:  [
                                Row(
                                  children: [
                                    SizedBox(

                                      height: 20,
                                      width: 20,

                                      child: Image.asset("assets/hr.png"),
                                    ),
                                    const SizedBox(width: 15),
                                    const Text(
                                      "Heart Rate",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                if(loggedInUser.hr ==null)
                                  const Text("--", style: TextStyle(fontSize: 40,color: Colors.white),)
                                else
                                 Text(
                                  "${loggedInUser.hr} bpm",
                                  style: const TextStyle(
                                      fontSize: 40, color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
           Card(
              color: kPrimaryColor,
              elevation: 5,
              margin: const EdgeInsets.all(10),

              child: ListTile(
                 onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const View()));

              },


                contentPadding: const EdgeInsets.only(right: 30, left: 36),
                title: const Text(
                  "Update Readings",
                  style: TextStyle(color: Colors.white),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: kPrimaryColor2,
                ),
              ))
        ],
      ),
    );
  }
}
