import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

@JsonSerializable()
class Login {
  String email;
  String senha;

  Login(this.email, this.senha);

  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);

  Map<String, dynamic> toJson() => _$LoginToJson(this);
}

@JsonSerializable()
class RespostaLogin {
  int statusCode;
  String message;
  String access_token;

  RespostaLogin(
      {required this.statusCode,
      required this.message,
      required this.access_token});

  factory RespostaLogin.fromJson(Map<String, dynamic> json) =>
      _$RespostaLoginFromJson(json);

  Map<String, dynamic> toJson() => _$RespostaLoginToJson(this);
}
