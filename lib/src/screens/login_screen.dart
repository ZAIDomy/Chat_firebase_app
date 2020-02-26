import 'package:cable_chat_app/src/mixins/validation_mixins.dart';
import 'package:cable_chat_app/src/services/authentication.dart';
import 'package:cable_chat_app/src/widgets/app_button.dart';
import 'package:cable_chat_app/src/widgets/app_error_message.dart';
import 'package:cable_chat_app/src/widgets/app_icon.dart';
import 'package:cable_chat_app/src/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {

  static const String routeName = '/login';

  @override
  _LoginScreenState createState() => new _LoginScreenState();
 }
class _LoginScreenState extends State<LoginScreen> with ValidationMixins{

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FocusNode _focusNode;
  bool showSpinner = false;
  bool _autovalidate = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _errorMessage = "";

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void setSpinnerStatus(bool status){
    setState(() {
      showSpinner = status;
    });
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: ModalProgressHUD(
       inAsyncCall: showSpinner,
       child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formkey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  AppIcon(),
                  SizedBox(height: 30.0,),
                  _emailField(),
                  SizedBox(height: 8.0,),
                  _passwordField(),  
                  SizedBox(height: 8.0,),
                  _showErrorMessage(),
                  _submitButton()
                ],
          )
        )
      ),
     )
   );

  }


  Widget _emailField(){
    return  AppTextField(
        focusNode: _focusNode,
        controller: _emailController,
        validator: validateEmail,
        autovalidate: _autovalidate,
        inputText: "Email",
        onSaved: (value){},
        );
  }
  Widget _passwordField(){
    return  AppTextField(
        controller: _passwordController,
        validator: validatePassword,
        autovalidate: _autovalidate,
        inputText: "Contraseña",
        onSaved: (value){},
        obscureText: true,
        );   
  }
  Widget _submitButton(){
    return  AppButton(
      color: Colors.blueGrey[600],
      value: "Log in",
      onPressed: ()async{
        if(_formkey.currentState.validate()){
          setSpinnerStatus(true);
          var auth = await Authentication().loginUser(email: _emailController.text,password: _passwordController.text);
          if (auth.success) {
            Navigator.pushNamed(context, '/chat');               
            FocusScope.of(context).requestFocus(_focusNode);
            _emailController.text="";
            _passwordController.text="";
          }else{
            setState(() {
              _errorMessage = auth.errorMessage;
            });
          }
          setSpinnerStatus(false);
        }else{
          setState( () => _autovalidate= true );
        }
      },
    );    
  }

  Widget _showErrorMessage(){
    if(_errorMessage.length > 0 && _errorMessage != null){
      return ErrorMessage(errorMessage: _errorMessage);
    }else{
      return Container(
        height: 0.0,
      );
    }

  }


}