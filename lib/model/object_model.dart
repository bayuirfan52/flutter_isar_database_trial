import 'package:isar/isar.dart';
import 'package:isardb_trial/helper/hash_helper.dart';
import 'package:json_annotation/json_annotation.dart';

part 'object_model.g.dart';

@Collection()
@JsonSerializable()
class Object {
  @JsonKey(name: "id")
  String? id;
  Id get ids => fastHash(id!);
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "data")
  Data? data;

  Object({
    this.id,
    this.name,
    this.data,
  });

  Object copyWith({
    String? id,
    String? name,
    Data? data,
  }) =>
      Object(
        id: id ?? this.id,
        name: name ?? this.name,
        data: data ?? this.data,
      );

  factory Object.fromJson(Map<String, dynamic> json) => _$ObjectFromJson(json);

  Map<String, dynamic> toJson() => _$ObjectToJson(this);
}

@Embedded()
@JsonSerializable()
class Data {
  @JsonKey(name: "price")
  double? dataPrice;
  @JsonKey(name: "color")
  String? color;
  @JsonKey(name: "generation")
  String? dataGeneration;
  @JsonKey(name: "Capacity")
  String? capacity;
  @JsonKey(name: "Screen size")
  double? screenSize;
  @JsonKey(name: "Generation")
  String? generation;
  @JsonKey(name: "Price")
  String? price;

  Data({
    this.dataPrice,
    this.color,
    this.dataGeneration,
    this.capacity,
    this.screenSize,
    this.generation,
    this.price,
  });

  Data copyWith({
    double? dataPrice,
    String? color,
    String? dataGeneration,
    String? capacity,
    double? screenSize,
    String? generation,
    String? price,
  }) =>
      Data(
        dataPrice: dataPrice ?? this.dataPrice,
        color: color ?? this.color,
        dataGeneration: dataGeneration ?? this.dataGeneration,
        capacity: capacity ?? this.capacity,
        screenSize: screenSize ?? this.screenSize,
        generation: generation ?? this.generation,
        price: price ?? this.price,
      );

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
