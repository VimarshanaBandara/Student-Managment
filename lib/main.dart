import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  late String studentName , studentID , studyProgramID;
  late double studentGPA;

  getStudentName(name){
    this.studentName = name;
  }

  getStudentID(id){
    this.studentID = id;
  }

  getStudyProgramID(programID){
    this.studyProgramID = programID;
  }


  getStudentGPA(gpa){
    this.studentGPA = double.parse(gpa);
  }

  createData(){

     DocumentReference documentReference = FirebaseFirestore.instance.collection("MyStudents").doc(studentName);
     Map<String , dynamic> students = {
       "studentName" : studentName,
    "studentID" : studentID,
    "studyProgramID" : studyProgramID,
    "studentGPA" : studentGPA,
     };
     documentReference.set(students).whenComplete((){

       print("$studentName created");
     });

  }


  readData(){
  /* DocumentReference documentReference = FirebaseFirestore.instance.collection("MyStudents").doc(studentName);
   documentReference.get().then((datasnapshot){
    print(datasnapshot.data["studentName"]);
    print(datasnapshot.data["studentID"]);
    print(datasnapshot.data["studyProgramID"]);
    print(datasnapshot.data["studentGPA"]);
   });*/
  }


  updateData(){
    DocumentReference documentReference = FirebaseFirestore.instance.collection("MyStudents").doc(studentName);
    Map<String , dynamic> students = {
      "studentName" : studentName,
      "studentID" : studentID,
      "studyProgramID" : studyProgramID,
      "studentGPA" : studentGPA,
    };
    documentReference.set(students).whenComplete((){

      print("$studentName updated");
    });

  }


  deleteData(){
       DocumentReference documentReference = FirebaseFirestore.instance.collection("MyStudents").doc(studentName);
       documentReference.delete().whenComplete((){
         print('$studentName deleted');
       });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My College'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Name',
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue , width: 2.0),
                    )

                ),
                onChanged: (String name){
                    getStudentName(name);
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Student ID',
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue , width: 2.0),
                    )

                ),
                onChanged: (String id){
                     getStudentID(id);
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Study Program ID',
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue , width: 2.0),
                    )

                ),
                onChanged: (String programID){
                     getStudyProgramID(programID);
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'GPA',
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue , width: 2.0),
                    )

                ),
                onChanged: (String gpa){
                       getStudentGPA(gpa);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Text('Create'),
                  textColor: Colors.white,

                  onPressed: (){
                    createData();
                  },
                ),

                RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Text('Read'),
                  textColor: Colors.white,

                  onPressed: (){
                    readData();
                  },
                ),

                RaisedButton(
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Text('Update'),
                  textColor: Colors.white,

                  onPressed: (){
                    updateData();
                  },
                ),

                RaisedButton(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Text('Delete'),
                  textColor: Colors.white,

                  onPressed: (){
                    deleteData();
                  },
                ),
              ],
            ),


          ],
        ),
      )

    );
  }
}
