import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_test/mainscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model.dart';
String Uservalue='';

class chatpage extends StatefulWidget {
  const chatpage({Key? key}) : super(key: key);


  @override
  State<chatpage> createState() => _chatpageState();
}

class _chatpageState extends State<chatpage> {
  TextEditingController Message_controller =TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    getUser_Name();
    super.initState();
  }
  Future<String> getUser_Name() async{
    var prefs = await SharedPreferences.getInstance();
    Uservalue =  prefs.getString("username") ?? "No name found";
    return Uservalue;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title:  Text('Football'),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height-163,
            child: StreamBuilder(
              stream: readmessages(),
                builder: (context,snapshot){
                if(snapshot.hasError){
                  print(snapshot.error);
                  return const Text('Error');
                }else if(snapshot.hasData){
                  return build_message(snapshot.data!);
                }else{
                  return const CircularProgressIndicator();
                }
                }
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children:  [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(

                      width: 372,
                      child: TextField(
                        controller: Message_controller,
                        minLines: 1,
                        maxLines: 5,
                        decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:Colors.white24 ),
                            ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color:Colors.white24 ),
                          )
                        ),
                      )),
                  ),
                    IconButton(
                      icon: const Icon(
                        Icons.send
                      ), onPressed: () {
                        String messages =Message_controller.text;

                      CreateMessage(
                          Messagemodel(
                              sender: Uservalue,
                              message: messages,
                              CreatedAt: Timestamp.now(),
                          )
                      );
                      Message_controller.clear();
                    },
                    ),

              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom,
          ),
        ],
      ),
    );
  }
}

Future CreateMessage(Messagemodel message) async {
  final docMessage = FirebaseFirestore.instance.collection('Football').doc();
  final message1 =message;
  final json = message1.toJson();
  await docMessage.set(json);
}
Widget build_message(List<Messagemodel> messages){
  return ListView.builder(
    shrinkWrap: true,
    itemCount: messages.length,
      itemBuilder: (context,index){
        return Container(
          padding: const EdgeInsets.only(left: 08,right: 20,top: 4,bottom: 4),
          child: Align(
            alignment: (messages[index].sender.trim().toLowerCase() == Uservalue.trim().toLowerCase()?Alignment.topRight:Alignment.topLeft),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: (messages[index].sender.trim().toLowerCase() == Uservalue.trim().toLowerCase()?const Color.fromRGBO(124, 96, 139, 1):Colors.blueGrey),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: (messages[index].sender.trim().toLowerCase() == Uservalue.trim().toLowerCase()?CrossAxisAlignment.end:CrossAxisAlignment.start),

                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: Text(
                      messages[index].sender,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 14,
                        color: (messages[index].sender.trim().toLowerCase() == Uservalue.trim().toLowerCase()?Colors.orange:Colors.orange),

                      ),
                    ),
                  ),
                  Text(messages[index].message, style: const TextStyle(fontSize: 15),),
                ],
              ),
            ),
          ),
        );
      }
  );
}
Stream<List<Messagemodel>> readmessages() {
  return FirebaseFirestore.instance.collection('Football').orderBy('CreatedAt',descending: false).snapshots().map((snapshot) {
    return snapshot.docs.map((doc) {
      return Messagemodel.fromjson(doc.data());
    }).toList();
  });
}
///not working
/// // SingleChildScrollView(
//           //   child: StreamBuilder<List<Messagemodel>>(
//           //       stream: readmessages(),
//           //       builder: (context,snapshot){
//           //         if(snapshot.hasData){
//           //           final messages_1=snapshot.data!;
//           //           return ListView(
//           //             children: messages_1.map(build_message).toList(),
//           //           );
//           //         }else if(snapshot.hasError){
//           //           return Text('errororo');
//           //         }
//           //         else{
//           //           return const CircularProgressIndicator();
//           //         }
//           //       }
//           //   ),
//           // ),