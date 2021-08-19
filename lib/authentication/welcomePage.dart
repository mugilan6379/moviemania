import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:moviemania/myButton.dart';
import 'loginScreen.dart';
import 'registerPage.dart';
import 'package:moviemania/constants.dart';
class welcomeScreen extends StatefulWidget {
  const welcomeScreen({Key? key}) : super(key: key);

  @override
  _welcomeScreenState createState() => _welcomeScreenState();
}

class _welcomeScreenState extends State<welcomeScreen> with SingleTickerProviderStateMixin{
  late AnimationController myController;
  late Animation curve;
  @override
  void initState() {
    super.initState();
    myController=AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    curve=ColorTween(
        begin: Colors.black12,
        end: Colors.blueGrey
    ).animate(myController);
    myController.forward();
    myController.addListener(() {
      setState(() {});
    });

  }
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: curve.value,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.pinkAccent,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(appLogo),

                    ),
                  ),
                ),
                SizedBox(width: 20.0,),
                TypewriterAnimatedTextKit(
                  speed: Duration(milliseconds: 100),
                  text: ['MovieMania'],
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w900,
                  ),
                  isRepeatingAnimation: false,
                ),
              ],
            ),
            SizedBox(height: 70.0,),
            myButton(Colors.lightBlueAccent,'Login',(){Navigator.push(context,MaterialPageRoute(builder: (context){
              return loginScreen();
            }));}),
            SizedBox(height: 30.0,),
            myButton(Colors.lightBlueAccent,'Register',(){Navigator.push(context,MaterialPageRoute(builder: (context){
              return registerScreen();
            }));})
          ],
        ),
      ),
    );
  }
}
