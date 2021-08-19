
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'movieCell.dart';
import 'package:moviemania/dataBaseHelper.dart';
import '../constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
var consImage='/data/user/0/com.mugilant.moviemania/app_flutter/scaled_image_picker1868103566793207133.jpg';
Color mainColor = const Color(0xff3C3261);

class listPage extends StatefulWidget {

  @override
  listPageState createState() => listPageState();
}

class listPageState extends State<listPage> with SingleTickerProviderStateMixin {
  final _auth=FirebaseAuth.instance;
  List movieList=[];
  List directorList=[];
  List imageUrl=[];
  var movie;
  var director;
  var poster;
  late Animation<double> _animation;
  late AnimationController _animationController;
  static var dbObj;
  static var filePath;
  void initState() {
    _animationController=AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 260)
    );
    final curvedAnimation=CurvedAnimation(parent: _animationController, curve: Curves.easeInOutExpo);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    dbObj=dataBaseHelper.instance;
    //takePicture();
    super.initState();
  }
  void insertRow(var movie,var director,var image)async{
    Map<String,dynamic> row={
      dataBaseHelper.movieNames: movie,
      dataBaseHelper.directorNames:director,
      dataBaseHelper.imageUrls: image
    };
    var m=await dbObj.insert(row);
  }
   void deleteItem(var movie,int index) async {
    final rowsDeleted = await dbObj.delete(movie);
    setState(() async{
      movieList.removeAt(index);
    });
  }
  void updateItem(var prevMovie,var movie,var director,var image) async{
    Map<String,dynamic> row={
      dataBaseHelper.movieNames: movie,
      dataBaseHelper.directorNames:director,
      dataBaseHelper.imageUrls: image
    };
    var updated=await dbObj.update(row,prevMovie);
  }
 var  storedImage;

  Future<void> takePicture() async{
   var imageFile= await ImagePicker().pickImage(source: ImageSource.gallery, maxWidth: 600,);
    if(imageFile==null){
      print('image picker is NULL');
    }
      filePath= imageFile!.path;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.3,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: new Text(
          '',
          style: new TextStyle(
              color: mainColor,
              fontFamily: 'Arvo',
              fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          FlatButton(
            child: new Icon(
              Icons.exit_to_app,
              color: mainColor,
            ),
            onPressed: (){
              _auth.signOut();
              Navigator.pop(context);
            },
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionBubble(
        backGroundColor: mainColor,
        animation: _animation,
        onPress: (){
          _animationController.isCompleted?_animationController.reverse():_animationController.forward();
        },
        animatedIconData: AnimatedIcons.home_menu,
        iconColor: Colors.blueGrey,
        items: [
          Bubble(
              title: 'ADD',
              titleStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: whiteColor),
              iconColor: Colors.white,
              bubbleColor: mainColor,
              icon: Icons.add,
              onPress: (){
                Alert(
                    context: context,
                    title: 'Add Movie Details',
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
                      DialogButton(child: Text('ADD'),
                          onPressed: () async {
                           File   imgFile = new File(filePath);
                              String fileName = basename(imgFile.path);
                           final appDir=await getApplicationDocumentsDirectory();
                              String destFilePath =appDir.path+'/'+fileName;
                              imgFile.copy(destFilePath);
                              setState(() {
                                insertRow(movie, director, destFilePath);
                              });
                            Alert(context: context,
                              title: 'SUCCESS',
                              type: AlertType.success,
                            ).show();
                            Navigator.pop(context);
                          }),
                      DialogButton(
                          child: Text('CANCEL'),
                          onPressed:(){
                            Navigator.pop(context);
                          })
                    ]
                ).show();
              }),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Padding(
               padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
               child: Container(
                 child: CircleAvatar(
                   radius: 60,
                   backgroundColor: Colors.pinkAccent,
                   child: CircleAvatar(
                     radius: 55,
                     backgroundImage: NetworkImage(appLogo),

                   ),
                 ),
               ),
             ),
             SizedBox(
               height: 20,
             ),
             Expanded(
               child: StreamBuilder<List>(
                 stream: dataBaseHelper.showTable().asStream(),
                 builder: (context,snapshot){
                   if(snapshot.hasData){
                     return ListView.builder(
                         itemCount: snapshot.data!.length,
                         itemBuilder: (context,i){
                           var item=snapshot.data![i];
                           if(item['images']==null){
                             print('Image data is NULL');
                             return movieCell(i,item['movies'],item['director'],consImage,item['movies']);
                           }
                           return movieCell(i,item['movies'],item['director'],item['images'],item['movies']);
                         }
                     );
                   }
                   else
                     return Container();
                 },
               ),
             )
           ],
        ),
      ),
    );
  }
}