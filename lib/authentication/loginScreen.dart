import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:moviemania/movieCell/listPage.dart';
import 'package:moviemania/myButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../constants.dart';
class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final _auth=FirebaseAuth.instance;
  late String mailId;
  late String password;
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
                  onChanged: (value){
                    mailId=value;
                  },
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  decoration: textFieldDesign.copyWith(
                      labelText: 'Mail id'
                  ),
                ),
                SizedBox(height: 10.0,),
                TextField(
                  onChanged: (value){
                    password=value;
                  },
                  textAlign: TextAlign.center,
                  obscureText: true,
                  decoration: textFieldDesign.copyWith(
                      labelText: 'Password'
                  ),
                ),
                SizedBox(height: 50.0,),
                myButton(Colors.lightBlueAccent, 'Login', () async{
                  setState(() {
                    spin=true;
                  });
                  try{
                    final user=await  _auth.signInWithEmailAndPassword(email: mailId, password: password);
                    if(user !=null){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return listPage();
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
                      desc: "User does not exist",
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
