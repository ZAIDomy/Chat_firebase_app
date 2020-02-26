class ValidationMixins{

  String validateEmail(String value){
    if (!value.contains('@')) {
      return "email invalido";
    }
    return null;
  }
  String validatePassword(String value){
    if (value.length < 6) {
      return "contraseña invalido";
    }
    return null;
  }

}