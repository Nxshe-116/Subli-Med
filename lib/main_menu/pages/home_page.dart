import 'package:flutter/material.dart';
import 'package:sublimed_health/mainComponents/appointments.dart';
import 'package:sublimed_health/mainComponents/medical_page.dart';
import 'package:sublimed_health/main_menu/pages/offline_page.dart';
import '../../components/constants.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
           SizedBox(
             width: size.width,
             child: Material(
               color: kPrimaryColor,
               elevation: 10,
               borderRadius: BorderRadius.circular(20),
               clipBehavior: Clip.antiAliasWithSaveLayer,
               child: InkWell(
                 splashColor: kPrimaryColor2,
                   onTap: () {
                     Navigator.push(
                       context,
                       MaterialPageRoute(
                         builder: (context) {
                           return const AppointmentPage();
                         },
                       ),
                     );
                   },
                   child: Row(
                     children: [
                       Ink.image(
                image: const AssetImage("assets/appoint.png"),
                         height: 180,
                         fit: BoxFit.cover,
                         width: size.width*0.4,
        ),
                       SizedBox(
                         width: size.width*0.55,
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children:  [
                              SizedBox(
                                 height: 50,
                                 child: Image.asset(
                                   "assets/app.png",
                                   fit: BoxFit.contain,
                                 )),
                             const SizedBox(height: 10,),
                              const Text('Schedule An Appointment', style: TextStyle(color: Colors.white, fontSize: 18)),
                           ],
                         ),
                       )
                     ],
                   )
               ),
             ),
           ),
            SizedBox(
              height: size.height * 0.05,
            ),
            SizedBox(
              width: size.width,
              child: Material(
                color: kPrimaryColor,
                elevation: 10,
                borderRadius: BorderRadius.circular(20),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: InkWell(
                    splashColor: kPrimaryColor2,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const VitalsPage();
                          },
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.08,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            SizedBox(
                                height: 50,
                                child: Image.asset(
                                  "assets/med1.png",
                                  fit: BoxFit.contain,
                                )),
                            const SizedBox(height: 10,),
                            const Text('Record Vitals', style: TextStyle(color: Colors.white, fontSize: 18)),
                          ],
                        ),
                        SizedBox(
                          width: size.width * 0.09,
                        ),
                        Ink.image(
                          image: const AssetImage("assets/med.png"),
                          height: 180,
                          fit: BoxFit.fill,
                          width: size.width*0.556,
                        ),
                      ],
                    )
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            SizedBox(
              width: size.width,
              child: Material(
                color: kPrimaryColor,
                elevation: 10,
                borderRadius: BorderRadius.circular(20),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: InkWell(
                    splashColor: kPrimaryColor2,
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const Facts();
                            },)
                      );
                    } ,
                    child: Row(
                      children: [
                        Ink.image(
                          image: const AssetImage("assets/offline1.png"),
                          height: 180,
                          fit: BoxFit.cover,
                            width: size.width*0.4,
                        ),
                        const SizedBox(width: 20,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:  [
                            SizedBox(
                                height: 50,
                                child: Image.asset(
                                  "assets/offline.png",
                                  fit: BoxFit.contain,
                                )),
                            const SizedBox(height: 10,),
                            const Text('Medical Advice & Tips', style: TextStyle(color: Colors.white, fontSize: 16)),
                          ],
                        )
                      ],
                    )
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
