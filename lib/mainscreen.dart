import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_test/chatpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project_test/Welcome_screen.dart';
import 'package:google_fonts/google_fonts.dart';
List chatrooms=[];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const mainpage());
}

class mainpage extends StatefulWidget {
  const mainpage({Key? key}) : super(key: key);

  @override
  State<mainpage> createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {
  TextEditingController chatroom_namecontroller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        drawer: NavBar(),
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
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: chatrooms.length,
                  itemBuilder: (context,index){
                    return Padding(
                      padding:const EdgeInsets.all(8),
                      child: ListTile(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>  chatpage(),
                              )
                          );
                        },
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        tileColor: Colors.white,
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              chatrooms[index],
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );

                  }
              ),
            ),


          ],
        ),
      ),
    );
  }
}

class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  void initState() {
    // TODO: implement initState
    getUser_Name();
    super.initState();
  }

  Future<String> getUser_Name() async {
    String Uservalue;
    var prefs = await SharedPreferences.getInstance();
    Uservalue = prefs.getString("username") ?? "No name found";
    return Uservalue;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: FutureBuilder(
              future: getUser_Name(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data);
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            accountEmail: const Text(
              '',
              style: TextStyle(fontSize: 0),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://imgs.search.brave.com/Fojuagpfu6ztWjaHJlhyzK4FeMuHRisbX79ghd2aKMA/rs:fit:735:794:1/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vNzM2/eC8wMi9jZC9jYi8w/MmNkY2I5ZjIwOWEz/OTRhMzdkNzJkYjU5/OWJjMzg4YS5qcGc',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://imgs.search.brave.com/sp6SCd1yG4DInPkwlxOsFO4TpSUYLgqCH1PkwmKPoi4/rs:fit:841:225:1/g:ce/aHR0cHM6Ly90c2Uy/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC5s/NERmZzNXSU1EQkcx/RVo1UVpERU9nSGFF/TCZwaWQ9QXBp')),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.sports_football),
            title: const Text('Football'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) {
                        return  const chatpage();
                      }));
            },
          ),
          Divider(),

        ],
      ),
    );
  }
}



