import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mainscreen.dart';
// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const welcome_screen());
// }
class welcome_screen extends StatefulWidget {
  const welcome_screen({Key? key}) : super(key: key);

  @override
  State<welcome_screen> createState() => _welcome_screenState();
}

class _welcome_screenState extends State<welcome_screen> {
  final TextEditingController username = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(bottom: 160),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 270),
                  child: SizedBox(
                    child: Text('Create a username',
                      style: TextStyle(
                        fontSize: 22,

                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: username,
                    decoration:  const InputDecoration(
                      hintText: 'USERNAME',
                      filled: true,
                      fillColor: Colors.white70,
                      focusedBorder:  OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white70,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white70,
                        ),
                      ),
                    ),

                    ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: SizedBox(
                      width: 420,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white24,
                        ),

                          onPressed: () async{
                          var prefs = await SharedPreferences.getInstance();
                          prefs.setString("username",username.text);
                          if(!mounted) return;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => mainpage(),
                              )
                          );
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Continue',
                              style: TextStyle(
                                fontSize: 22,
                              ),

                            ),
                          ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

  }
}
