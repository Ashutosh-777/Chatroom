import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:core';
import 'package:project_test/Welcome_screen.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: welcome_screen()
  ));
}
//



//
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
// final  TextEditingController name_controller = TextEditingController();
// final  TextEditingController age_controller = TextEditingController();
// final  TextEditingController birthdate_controller = TextEditingController();
// @override
//   Widget build(BuildContext context) {
//     return  MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.dark(),
//       home:  Scaffold(
//         appBar: AppBar(
//           title:  const Text('CRUD TESTING'),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               TextField(
//                 controller: name_controller,
//                 decoration: InputDecoration(
//                   hintText: 'name',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   )
//                 ),
//               ),
//               TextField(
//                 controller: age_controller,
//                 decoration: InputDecoration(
//                     hintText: 'age',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     )
//                 ),
//               ),
//               TextField(
//                 controller: birthdate_controller,
//                 decoration: InputDecoration(
//                     hintText: 'Birth Date',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     )
//                 ),
//               ),
//               ElevatedButton(
//                   onPressed: (){
//                     print(birthdate_controller.text);
//                     CreateUser(
//                       User(
//                         Id: name_controller.text,
//                           name: name_controller.text,
//                           age: age_controller.text,
//                           birthdate: birthdate_controller.text
//                       )
//
//                     );
//                   },
//                   child:const Text('Create '),
//               ),
//               ElevatedButton(
//                   onPressed: (){
//                     UpdateUser(
//                         User(
//                           Id: name_controller.text,
//                             name: name_controller.text,
//                             age: age_controller.text,
//                             birthdate: birthdate_controller.text
//                         )
//                     );
//
//                   },
//                   child:const Text('Update User Data'),
//               ),
//               ElevatedButton(
//                   onPressed: (){
//                   DeleteUser(name_controller.text);
//                   },
//                   child: const Icon(
//                     Icons.delete,
//                   )
//               ),
//               ElevatedButton(
//                   onPressed: (){
//
//                   },
//                   child:const Icon(
//                     Icons.remove_red_eye,
//                   )
//               ),
//               StreamBuilder<List<User>>(
//                   stream: readusers(),
//                   builder: (context,snapshot){
//                     if(snapshot.hasData){
//                       final messages_1=snapshot.data!;
//                       return ListView(
//                         children: messages_1.map(builduser).toList(),
//                       );
//                     }else if(snapshot.hasError){
//                       return  Text( '${snapshot.error}');
//                     }
//                     else{
//                       return const CircularProgressIndicator();
//                     }
//                   }
//               ),
//               SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.all(0),
//                   child: StreamBuilder(
//                     stream:  FirebaseFirestore.instance.collection('users').snapshots(),
//                       builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
//                       if(snapshot.hasData){
//                         return Expanded(
//                           child: ListView(
//                             shrinkWrap: true,
//                             children: snapshot.data!.docs.map(
//                                     (doc) {
//                                       return Center(
//                                         child: SizedBox(
//                                           width: 400,
//                                           height: 50,
//                                           // width: MediaQuery.of(context).size.width/1.2,
//                                           // height: MediaQuery.of(context).size.width/4,
//                                           // child: Text("name: " + doc['name']),
//                                           child: Text(doc.id),
//                                         ),
//                                       );
//                                     }).toList(),
//                           ),
//                         );
//                       }else{
//                         return const Center(child: CircularProgressIndicator());
//                       }
//                       }
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
// // ignore: non_constant_identifier_names
// Future CreateUser(User user) async {
//   final docUser = FirebaseFirestore.instance.collection('users').doc(user.name);
//   final user1 = user;
//   final json = user1.toJson();
//   await docUser.set(json);
// }
// Future UpdateUser(User user) async{
//   final docUser =FirebaseFirestore.instance.collection('users').doc(user.name);
//   final json = user.toJson();
//   await docUser.update(json);
// }
// Future DeleteUser(id) async{
//   final docUser =FirebaseFirestore.instance.collection('users').doc(id);
//   await docUser.delete();
// }
// Widget builduser(User user){
//   return ListTile(
//     title: Text(user.name),
//     subtitle: Text(user.age),
//   );
// }
// Stream<List<User>> readusers() {
//   return FirebaseFirestore.instance.collection('users').snapshots().map((snapshot) {
//     return snapshot.docs.map((doc) {
//       return User.fromjson(doc.data());
//     }).toList();
//   });
// }
//
// // Future ReadUserData() async{
// //
// //   await
// // }
//
//
//
//
//
//
