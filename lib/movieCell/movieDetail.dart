import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:moviemania/constants.dart';
class movieDetail extends StatelessWidget {
  var movie;
  var director;
  var image;
  movieDetail(this.movie,this.director,this.image);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white12,
        leading: FlatButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.west_outlined)
        ),
      ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              child: Image(
                width: 70,
                height: 70,
                image: FileImage(File(image)),
              ),),
            BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 5,sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.white24,
                              blurRadius: 20.0,
                              offset: new Offset(0.0, 10.0)
                          )
                        ]
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        width: 400,
                        height: 400,
                        child: Image(image: FileImage(File(image)),fit: BoxFit.cover,),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20,horizontal: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          new Expanded(
                              child: new Text(
                                'Movie :$movie',
                                style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontFamily: 'Arvo'),
                              )),
                        ],
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(10.0)),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20,horizontal: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          new Expanded(
                              child: new Text(
                                'Director:$director',
                                style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontFamily: 'Arvo'),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
