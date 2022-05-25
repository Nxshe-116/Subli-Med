import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
     Key? key, required this.child,  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
       Positioned(
         top: size.height*0.08,
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Positioned(

                child: Image.asset(
                  "assets/logo.png",
                  width: size.width * 0.9,
                )),
            SizedBox(
              height: size.height * 0.0003,
            ),
            Positioned(
                child: Image.asset(
                  "assets/Hello.png",
                  width: size.width * 0.6,
                  height: size.height*0.6,
                )),


          ],
         ),
       ),


          child,
        ],
      ),
    );
  }
}
