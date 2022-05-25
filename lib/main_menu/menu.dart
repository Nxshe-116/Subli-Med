import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sublimed_health/mainComponents/medical_page.dart';
import 'package:sublimed_health/main_menu/pages/appointment_details.dart';






import 'package:sublimed_health/main_menu/pages/home_page.dart';
import 'package:sublimed_health/main_menu/pages/order.dart';
import 'package:sublimed_health/main_menu/pages/profile_page.dart';
import 'package:sublimed_health/main_menu/pages/settings.dart';
import '../components/constants.dart';
import '../mainComponents/chats/chatsInbox.dart';
import '../welcome_screen/welcome_screen.dart';

import 'my_header_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final screens = [
    const HomePage(),
    const Details(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          backgroundColor: kPrimaryColor,
          shadowColor: kPrimaryColor2,
          elevation: 5,

        ),
      body: screens[currentIndex],
      drawer: Drawer(

        child: SingleChildScrollView(
          child: Column(
            children: [
              const MyHeaderDrawer(),
              myDrawerList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
      decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          blurRadius: 20,
          color: Colors.black.withOpacity(.1),
        )
      ],
    ),
    child: SafeArea(
    child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
    child: GNav(
    rippleColor: Colors.grey[300]!,
    hoverColor: kPrimaryColor2,
    gap: 8,
    activeColor: kPrimaryColor,
    iconSize: 24,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    duration: const Duration(milliseconds: 400),
    tabBackgroundColor: Colors.white,
    color: Colors.blueGrey,
    tabs: const [
    GButton(
    icon: Icons.home,
    text: 'Home',
    ),
    GButton(
    icon: Icons.schedule,
    text: 'Appointments',
    ),
    GButton(
    icon: Icons.account_circle,
    text: 'Profile',
    ),

    ],
    selectedIndex: currentIndex,
    onTabChange: (index) {
    setState(() {
    currentIndex = index;
    });
    },
    )
    )
    )
    )
    );
  }

  Widget myDrawerList() {
    return Container(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            order(),
            chats(),
            settings(),
            readings(),
            menuItem(),
          ],
        ));
  }

  Widget menuItem() {
    return Material(
      child: InkWell(
        onTap: () {
          logout(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: const [
              Expanded(
                  child: Icon(
                Icons.logout,
                color: kPrimaryColor,
              )),
              Expanded(
                  flex: 3,
                  child: Text(
                    "Log Out",
                    style: TextStyle(
                      color: kPrimaryColor,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
  Widget readings() {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const VitalsPage()));
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: const [
              Expanded(
                  child: Icon(
                    Icons.monitor_heart_outlined,
                    color: kPrimaryColor,
                  )),
              Expanded(
                  flex: 3,
                  child: Text(
                    "Update Vitals",
                    style: TextStyle(
                      color: kPrimaryColor,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
  Widget settings() {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const SettingsPage()));
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: const [
              Expanded(
                  child: Icon(
                    Icons.settings_sharp,
                    color: kPrimaryColor,
                  )),
              Expanded(
                  flex: 3,
                  child: Text(
                    "Settings",
                    style: TextStyle(
                      color: kPrimaryColor,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
  Widget order() {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const PharmOrder()));
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: const [
              Expanded(
                  child: Icon(
                    Icons.delivery_dining_sharp,
                    color: kPrimaryColor,
                  )),
              Expanded(
                  flex: 3,
                  child: Text(
                    "Prescription Order",
                    style: TextStyle(
                      color: kPrimaryColor,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

Widget chats() {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const MyChats()));
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: const [
              Expanded(
                  child: Icon(
                    Icons.messenger_rounded,
                    color: kPrimaryColor,
                  )),
              Expanded(
                  flex: 3,
                  child: Text(
                    "Chats",
                    style: TextStyle(
                      color: kPrimaryColor,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

}

Future <void> logout(BuildContext context) async
{
  await FirebaseAuth.instance.signOut();
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const WelcomeScreen()));
}
