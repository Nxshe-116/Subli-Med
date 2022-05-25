
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/constants.dart';
import '../model/user_model.dart';

class MyHeaderDrawer extends StatefulWidget {
  const MyHeaderDrawer({Key? key}) : super(key: key);



  @override
  _MyHeaderDrawerState createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
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
    return Container(
      color:kPrimaryColor,
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.only(top: 20.0),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(

            height: size.height*0.1,
            width: size.width*0.1,

            child: Image.asset("assets/user_icon.png"),
          ),
           const SizedBox(width: 10,),
           SizedBox(
             width: size.width*0.5,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text("Hello ${loggedInUser.firstName} ${loggedInUser.surname}", style: const TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.w400  ),),
                 Text("${loggedInUser.email}",style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w200))
               ],
             ),
           )
        ],
      ),
    );
  }
}
