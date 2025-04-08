import 'package:json_annotation/json_annotation.dart';

part 'register_model.g.dart';

@JsonSerializable()
class RegisterRequestModel {
  final String username;
  final String password;
  final String email;

  RegisterRequestModel({
    required this.username,
    required this.password,
    required this.email
  });

  factory RegisterRequestModel.fromJson(Map<String,dynamic>json)=>
      _$RegisterRequestModelFromJson(json);

    Map<String,dynamic>toJson()=>_$RegisterRequestModelToJson(this);
}

@JsonSerializable()
class RegisterResponseModel{
  final int id;

  RegisterResponseModel({
    required this.id,
  });

  factory RegisterResponseModel.fromJson(Map<String,dynamic>json) =>
      _$RegisterResponseModelFromJson(json);

    Map<String,dynamic>toJson()=>_$RegisterResponseModelToJson(this);
}