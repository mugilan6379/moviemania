import 'package:flutter/material.dart';
import 'dart:io';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'movieDetail.dart';
import 'listPage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
Color mainColor = const Color(0xff3C3261);
class movieCell extends StatelessWidget {
  var movie;
  var director;
  var poster;
  int index;
  var movieBeforeChange;
  var filePath;
  movieCell(this.index,this.movie,this.director,this.poster,this.movieBeforeChange);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(0.0),
                child:  Container(
                  child: Image(
                    fit: BoxFit.cover,
                    width: 70,
                    height: 70,
                    image: FileImage(File(poster)),

                  ),
                  margin: const EdgeInsets.all(16.0),
                  decoration:  BoxDecoration(
                    borderRadius:  BorderRadius.circular(20.0),
                    color: Colors.grey,
                    //image: FileImage(File(poster)),
                    boxShadow: [
                      new BoxShadow(
                          color: mainColor,
                          blurRadius: 5.0,
                          offset: new Offset(2.0, 5.0))
                    ],
                  ),
                ),
              ),
              new Expanded(
                  child:  Container(
                    margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                    child: new Column(
                      children: [
                        new Text(
                          movie,
                          style: new TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'Arvo',
                              fontWeight: FontWeight.bold,
                              color: mainColor),
                        ),
                        new Padding(padding: const EdgeInsets.all(2.0)),
                        new Text(
                          'Director: $director',
                          maxLines: 3,
                          style: new TextStyle(
                              color: const Color(0xff8785A4), fontFamily: 'Arvo'),
                        ),
                        new Padding(padding: const EdgeInsets.all(4.0)),
                        Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          direction: Axis.horizontal,
                          children: [
                            FlatButton(
                              minWidth: 30,
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return movieDetail(movie,director,poster);
                                }));
                              },
                              child: Icon(
                                Icons.remove_red_eye,
                                size: 20,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(width: 5,),
                            FlatButton(
                              minWidth: 30,
                              onPressed: (){
                                Alert(
                                  context: context,
                                  title: 'Edit Details',
                                  type: AlertType.none,
                                  content: Column(
                                    children: [
                                      TextField(
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                          hintText: 'Movie name',
                                        ),
                                        onChanged: (value){
                                          movie=value;
                                        },
                                      ),
                                      TextField(
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                          hintText: 'Director',
                                        ),
                                        onChanged: (value){
                                            director=value;
                                          print(director);
                                        },
                                      ),
                                      FlatButton(
                                          onPressed: ()  async {
                                           await listPageState().takePicture();
                                         },
                                          child: Text('SelectImage'))
                                    ],
                                  ),
                                  buttons: [
                                    DialogButton(
                                      onPressed: () async {
                                        filePath=listPageState.filePath;
                                        File   imgFile = new File(filePath);
                                        String fileName = basename(imgFile.path);
                                        final appDir=await getApplicationDocumentsDirectory();
                                        String destFilePath =appDir.path+'/'+fileName;
                                        imgFile.copy(destFilePath);
                                        listPageState().updateItem(movieBeforeChange,movie,director,destFilePath);
                                        Navigator.push(context,MaterialPageRoute(builder: (context){
                                          return listPage();
                                        }));
                                      },
                                      child: Text('Sava'),
                                    ),
                                    DialogButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Cancel'),
                                    )
                                  ]
                                ).show();
                              },
                              child: Icon(Icons.edit,
                                size: 20,
                                color: Colors.green,),
                            ),
                            SizedBox(width: 5,),
                            FlatButton(
                              minWidth: 30,
                              onPressed: (){
                                listPageState().deleteItem(movie,index);
                                Navigator.pop(context);
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return listPage();
                                }));
                                Alert(
                                    context: context,
                                    type: AlertType.success,
                                    title: 'Deleted Successfully',
                                ).show();
                              },
                              child: Icon(Icons.delete,
                                size: 20,
                                color: Colors.red,),
                            )
                          ],
                        )
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  )),
            ],
          ),
          new Container(
            width: 300.0,
            height: 0.5,
            color: const Color(0xD2D2E1ff),
            margin: const EdgeInsets.all(16.0),
          )
        ],
      ),
    );
  }

}
//image: ,ew DecorationImage(
//                         image: NetworkImage(poster),
//                         fit: BoxFit.cover),
//Image(image: FileImage(File(path)))
//child:new Container(
//                     width: 70.0,
//                     height: 70.0,
//                   )

//TextField(
//                                         textAlign: TextAlign.center,
//                                         decoration: InputDecoration(
//                                           hintText: 'Image Link',
//                                         ),
//                                         onChanged: (value){
//                                             poster=value;
//                                           print(poster);
//                                         },
//
//                                       )
//Image(
//                       fit: BoxFit.cover,
//                       width: 70,
//                       height: 70,
//                       image: FileImage(File(poster)),
//                     )