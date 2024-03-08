class LoginDto {
  final String? uid;
  final String? email;
  final String? displayName;
  final String tokenID;
  final String? refreshToken;
  final String? profileImage;

  LoginDto({this.uid,this.email,this.displayName,required this.tokenID,this.refreshToken,this.profileImage});
}