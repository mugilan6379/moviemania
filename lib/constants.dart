import 'package:flutter/material.dart';
const appLogo='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfZ7m4m-8vQjBmAnNRatEonoZ_kEcet24E6hJG995AlBwak5K7lUoyanDtGQFUfOwLCYs&usqp=CAU';
const blackColor=Color(0xFF000000);
const whiteColor=Color(0xFFffffff);
const lightWhite=Color(0xFF6f6f6f);
const lightBlack=Color(0xFF414141);

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);
const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);
const textFieldDesign=InputDecoration(labelText: 'text here',
  contentPadding: EdgeInsets.all(15.0),
  border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(25.0))),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.lightBlueAccent,width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(15.0))
  ),
  focusedBorder:  OutlineInputBorder(
      borderSide: BorderSide(color: Colors.lightBlueAccent,width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(15.0))
  ),
);