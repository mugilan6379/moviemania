import 'package:flutter/material.dart';
class myButton extends StatelessWidget {
  final Color col;
  final String title;
  final void Function() press;
  myButton(this.col, this.title,this.press);
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('$title',
          style: TextStyle(
              fontSize: 20.0
          ),
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 5.0,
      fillColor: col,
      onPressed: press,
    );
  }
}