import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_test/chatpage.dart';
List chatrooms=[];
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const mainpage());
// }
class mainpage extends StatefulWidget {
  const mainpage({Key? key}) : super(key: key);
  @override
  State<mainpage> createState() => _mainpageState();
}
class _mainpageState extends State<mainpage> {
  TextEditingController chatroom_namecontroller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //drawer: NavBar(),
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(left: 90),
            child: Text('Chatroom'),
          ),
        ),
        body: Column(
          children:  [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: chatroom_namecontroller,
                minLines: 1,
                maxLines: 5,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white24,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color:Colors.white24 ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color:Colors.white24 ),
                    )
                ),
              ),
            ),
            Center(
              child:  TextButton(
                onPressed: (){
                  if(chatroom_namecontroller.text.isNotEmpty){
                    setState(() {
                      chatrooms.add(chatroom_namecontroller.text);
                      CreateChatroom(chatroom_namecontroller.text);
                    });
                    chatroom_namecontroller.clear();
                    print(chatrooms.length);
                    print(chatrooms[0]);
                  }
                },
                child: const Text('Create Chatroom',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                  color: Colors.white24,

                ),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                  stream:  FirebaseFirestore.instance.collection('Chatrooms.all').snapshots(),
                  builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                    if(snapshot.hasData){
                      return SizedBox(
                        child: ListView(
                          shrinkWrap: true,
                          children: snapshot.data!.docs.map(
                                  (doc) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>  chatpage(doc['nameofchatroom']),
                                          )
                                      );
                                    },
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(color: Colors.black, width: 1),
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    tileColor: Colors.white,
                                    // padding: const EdgeInsets.all(8.0),
                                    title: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(doc['nameofchatroom'],
                                          style: const TextStyle(
                                            fontSize:24,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
                      );
                    }else{
                      return const Center(child: CircularProgressIndicator());
                    }
                  }
              ),
            ),
          ],
        ),
      );
  }
}



Future CreateChatroom(chatroom_name) async {
  FirebaseFirestore.instance.collection('Chatrooms.all').doc().set({'nameofchatroom':chatroom_name});
}

