// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'user_model.g.dart';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

@JsonSerializable()
class Users {
  @JsonKey(name: "page")
  int? page;
  @JsonKey(name: "per_page")
  int? perPage;
  @JsonKey(name: "total")
  int? total;
  @JsonKey(name: "total_pages")
  int? totalPages;
  @JsonKey(name: "data")
  List<Data>? data;
  @JsonKey(name: "support")
  Support? support;

  Users({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
    this.support,
  });

  Users copyWith({
    int? page,
    int? perPage,
    int? total,
    int? totalPages,
    List<Data>? data,
    Support? support,
  }) =>
      Users(
        page: page ?? this.page,
        perPage: perPage ?? this.perPage,
        total: total ?? this.total,
        totalPages: totalPages ?? this.totalPages,
        data: data ?? this.data,
        support: support ?? this.support,
      );

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);

  Map<String, dynamic> toJson() => _$UsersToJson(this);
}

@Collection()
@JsonSerializable()
class Data {
  @JsonKey(name: "id")
  Id? id;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "first_name")
  String? firstName;
  @JsonKey(name: "last_name")
  String? lastName;
  @JsonKey(name: "avatar")
  String? avatar;

  Data({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  Data copyWith({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? avatar,
  }) =>
      Data(
        id: id ?? this.id,
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        avatar: avatar ?? this.avatar,
      );

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@Embedded()
@JsonSerializable()
class Support {
  @JsonKey(name: "url")
  String? url;
  @JsonKey(name: "text")
  String? text;

  Support({
    this.url,
    this.text,
  });

  Support copyWith({
    String? url,
    String? text,
  }) =>
      Support(
        url: url ?? this.url,
        text: text ?? this.text,
      );

  factory Support.fromJson(Map<String, dynamic> json) => _$SupportFromJson(json);

  Map<String, dynamic> toJson() => _$SupportToJson(this);
}
