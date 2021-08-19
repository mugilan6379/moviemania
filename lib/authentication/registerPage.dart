import 'package:flutter/material.dart';
import 'package:moviemania/authentication/loginScreen.dart';
import 'package:moviemania/myButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:moviemania/constants.dart';
class registerScreen extends StatefulWidget {
  const registerScreen({Key? key}) : super(key: key);

  @override
  _registerScreenState createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  final _auth= FirebaseAuth.instance;
  late var password;
  late var mailId;
  bool spin=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: spin,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.pinkAccent,
                    child: CircleAvatar(
                      radius: 55,
                      backgroundImage: NetworkImage(appLogo),

                    ),
                  ),
                ),
                SizedBox(height: 60.0,),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  decoration: textFieldDesign.copyWith(
                      labelText: 'Mail id'
                  ),
                  onChanged: (value){
                    mailId=value;
                  },
                ),
                SizedBox(height: 10.0),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  decoration: textFieldDesign.copyWith(
                      labelText: 'Password'
                  ),
                  onChanged: (value){
                    password=value;
                  },
                ),
                SizedBox(height: 50.0,),
                myButton(Colors.lightBlueAccent, 'Register', () async{
                  setState(() {
                    spin=true;
                  });
                  try {
                    final userInfo = await _auth.createUserWithEmailAndPassword(email: mailId, password: password);
                    if(userInfo !=null){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return loginScreen();
                      }));
                    }
                    setState(() {
                      spin=false;
                    });
                  }catch(e){
                    Alert(
                      context: context,
                      type: AlertType.error,
                      title: "Error occured!!",
                      desc: "User already exist or enter valid information",
                      buttons: [
                        DialogButton(
                          child: Text(
                            "CANCEL",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () => Navigator.pop(context),
                          width: 120,
                          color: Colors.lightBlueAccent,
                        )
                      ],
                    ).show();
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
