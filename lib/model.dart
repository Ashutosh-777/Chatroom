// class User{
//   String Id;
//   final String name;
//   final String age;
//    final String birthdate;
//  User(
//   {
//     this.Id ='',
//     required this.name,
//     required this.age,
//     required this.birthdate,
// }
//      );
//  Map<String,dynamic> toJson() {
//    return {
//    'Id':Id,
//    'name':name,
//    'age' : age,
//    'birthdate' : birthdate
//  };
//  }
//   static User fromjson(Map<String,dynamic> json){
//     return User(
//         name: json['name'],
//         age: json['age'],
//         birthdate: json['birthdate']
//     );
//   }
// }
class Messagemodel{
 String sender;
  String message;
  final CreatedAt;
  String nameofcurrentchatroom;
  Messagemodel({
    required this.sender,
    required this.message,
    required this.CreatedAt,
    required this.nameofcurrentchatroom
});
  Map<String,dynamic> toJson() {
    return {
      'message':message,
      'sender':sender,
      'CreatedAt': CreatedAt,
      'nameofcurrentchatroom':nameofcurrentchatroom,
    };
  }
  static Messagemodel fromjson(Map<String,dynamic> json){
    return Messagemodel(
        sender: json['sender'],
        message: json['message'],
        CreatedAt: json['CreatedAt'],
        nameofcurrentchatroom: json['nameofcurrentchatroom']
    );
  }

}
