import 'package:cable_chat_app/src/services/authentication.dart';
import 'package:cable_chat_app/src/services/message_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ChatScreen extends StatefulWidget {

  static const String routeName = '/chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  TextEditingController _messagecontroller = TextEditingController();
  InputDecoration _messageTextDecoratio = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    hintText: 'Ingresar su mensaje aqui...',
    border: InputBorder.none
  );
  BoxDecoration _messageContainerDecoration = BoxDecoration(
    border: Border(
      top: BorderSide(color: Colors.lightBlueAccent, width: 2.0)
    )
  );
  TextStyle _sendButtonStyle = TextStyle(
    color: Colors.lightBlueAccent,
    fontWeight: FontWeight.bold,
    fontSize: 18.0
  );

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    _getMessages();
  }

  void getCurrentUser()async{
        var user = await Authentication().getCurrentUser();
        if (user != null) {
          loggedInUser = user;
          print(loggedInUser.email);
        }

  }

  void _getMessages() async{
    await for(var snapshot in MessageService().getMessageStrem()){
      for(var message in snapshot.documents){
        print(message.data);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("chat screen"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.highlight_off),
            onPressed: (){
              Authentication().singOut();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            StreamBuilder(
              stream: MessageService().getMessageStrem(),
              builder: (context, snapshot){
                if (snapshot.hasData) {                 
                  return Flexible(
                    child: ListView(
                    children: _getChatItems(snapshot.data.documents),
                  ));
                }else
                return null;
              }
            ),
            Container(
              decoration: _messageContainerDecoration,
              child: Row(children: <Widget>[
                Expanded(
                child: TextField(
                  decoration: _messageTextDecoratio,
                  controller: _messagecontroller,
                ),
                ),
                FlatButton(
                  child: Text("enviar",style: _sendButtonStyle),
                  onPressed: (){

                    MessageService().save(collectionName: "messages", collectionValues: {
                      'value': _messagecontroller.text,
                      'sender': loggedInUser.email
                    });
                    _messagecontroller.clear();

                  },
                )
              ],)
            )
        ]),
      ),

    );
  }

  List<ChatItem> _getChatItems(dynamic messages){
    List<ChatItem> chatItems = [];
      for (var message in messages) {
        final messageValue = message.data["value"];
        final messageSender = message.data["sender"];
        chatItems.add(ChatItem(message: messageValue,sender: messageSender, isLoggedInUser: messageSender == loggedInUser.email,));
      }
      return chatItems;
  }



}

class ChatItem extends StatelessWidget {
  final String sender;
  final String message;
  final bool isLoggedInUser;

  ChatItem({this.sender, this.message, this.isLoggedInUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(sender, style: TextStyle(fontSize: 15.0, color: Colors.black54)),
          Material(
            color: isLoggedInUser ? Colors.lightBlueAccent : Colors.purple,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0)
            ),
            elevation: 5.0,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Text(message, style: TextStyle(fontSize: 18.0, color: Colors.white))
            )
          )
        ],
      ),      
    );
  }
}