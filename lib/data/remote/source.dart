import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'source.g.dart';


@JsonSerializable()
class Source extends Equatable {
  final String? id;
  final String? name;

  const Source({
    this.id,
    this.name,
  });

  @override
  List<Object?> get props => [id, name];

  @override
  bool get stringify => true;

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);

}

