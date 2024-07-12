import "package:json/json.dart";

@JsonCodable()
class LoginParams {
  int id;

  LoginParams({required this.id});
}
