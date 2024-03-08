String? passwordValidation({String enteredText = "", bool isPasswordValid = false}) {
  if (enteredText.length < 6 && enteredText.isNotEmpty) {
    return "enter password with special character,small letter,capital letter";
  }
  if (!RegExp('[a-z]').hasMatch(enteredText) && isPasswordValid) {
    return 'enter small letter';
  }
  if (!RegExp('[A-Z]').hasMatch(enteredText) && isPasswordValid) {
    return 'enter captial letter';
  }
  if (!RegExp('[0-9]').hasMatch(enteredText) && isPasswordValid) {
    return 'enter number ';
  }
  if (!RegExp('[-+_!@#%^&*., ?]').hasMatch(enteredText) && isPasswordValid) {
    return 'enter special character ';
  } else {
    return null;
  }
}
bool emailValidation({String enteredText = ""}){
  var emailValidation = RegExp(r'\S+@\S+\.\S+');
  return emailValidation.hasMatch(enteredText);

}