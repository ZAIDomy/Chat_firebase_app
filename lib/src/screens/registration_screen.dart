import 'package:cable_chat_app/src/mixins/validation_mixins.dart';
import 'package:cable_chat_app/src/services/authentication.dart';
import 'package:cable_chat_app/src/widgets/app_button.dart';
import 'package:cable_chat_app/src/widgets/app_error_message.dart';
import 'package:cable_chat_app/src/widgets/app_icon.dart';
import 'package:cable_chat_app/src/widgets/app_textfield.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {

  static const String routeName = '/registration';

  @override
  _RegistrationScreenState createState() => new _RegistrationScreenState();
 }
class _RegistrationScreenState extends State<RegistrationScreen> with ValidationMixins{

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  FocusNode _focusNode;
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

  @override
  Widget build(BuildContext context) {
   return Scaffold(

       body: Form(
         key: _formKey,
       child: Container(
         padding: EdgeInsets.symmetric(horizontal: 20.0),
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
          ),
       )
       )

   );
  }

  Widget _emailField(){
    return  AppTextField(
               focusNode: _focusNode,
               validator: validateEmail,
               autovalidate: _autoValidate,
               controller: _emailController,
               inputText: "Ingresar email",
               onSaved: (value){},
             );

  }

  Widget _passwordField(){
    return  AppTextField(
               controller: _passwordController,
               validator: validatePassword,
               autovalidate: _autoValidate,
               inputText: "Ingresar contraseña",
               onSaved: (value){},
               obscureText: true,
             );
    
  }

  Widget _submitButton(){
    return  AppButton(
               color: Colors.blueGrey[600],
               value: "Registrer",
               onPressed: ()async{

                 if(_formKey.currentState.validate()){
                  var auth = await Authentication().createUser(email: _emailController.text,password: _passwordController.text);
                  if (auth.success) {
                    Navigator.pushNamed(context, '/chat');               
                    FocusScope.of(context).requestFocus(_focusNode);
                    _emailController.text ="";
                    _passwordController.text ="";
                  }else{
                    setState(() {
                      _errorMessage = auth.errorMessage;
                    });
                  }
                 }else{
                   setState(() => _autoValidate = true);
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
