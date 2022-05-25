import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sublimed_health/components/Divider.dart';
import 'package:sublimed_health/components/constants.dart';
import 'package:sublimed_health/main_menu/pages/settings.dart';

import 'package:sublimed_health/model/user_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
                      Row(
                        children: [
                             SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Image.asset(
                                    "assets/user1.png",
                                    fit: BoxFit.contain,
                                  )
                  ),
                          const SizedBox(width: 20,),
                          SizedBox(
                            width: size.width*0.6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  [
                                Text("${loggedInUser.firstName} ${loggedInUser.surname}", style: const TextStyle(color: kPrimaryColor, fontSize: 30)),
                                Text("${loggedInUser.email}",
                                  style: const TextStyle(color: kPrimaryColor, fontSize: 22),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
               const SizedBox(height: 5,),
               const Text("version 1.2.5"),
            const SizedBox(height: 5,),
            const PageDivider(),
             Card(
                color: Colors.white,
                elevation: 5,
                margin: const EdgeInsets.all(10),

                child: ListTile(
                  onTap: () {
                   Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                    const SettingsPage()));

                  },

                  contentPadding: const EdgeInsets.only(right: 30, left: 36),
                  title: const Text(
                    "Settings",
                    style: TextStyle(color: kPrimaryColor),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: kPrimaryColor2,
                  ),
                )),
            const SizedBox(height: 5,),
            const Card(
                color: Colors.white,
                elevation: 5,
                margin: EdgeInsets.all(10),

                child: ListTile(
                  /* onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const View()));

                  },*/

                  contentPadding: EdgeInsets.only(right: 30, left: 36),
                  title: Text(
                    "Change Password, Details",
                    style: TextStyle(color: kPrimaryColor),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: kPrimaryColor2,
                  ),
                )),


          ],
        ),
        );
  }
}
