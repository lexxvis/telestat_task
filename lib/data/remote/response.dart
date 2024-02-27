import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'article.dart';

part 'response.g.dart';


@JsonSerializable()
class Response extends Equatable {
  final String status;
  final int totalResults;
  final List<Article>? articles;

  const Response({
    required this.status,
    required this.totalResults,
    this.articles
  });

  @override
  List<Object?> get props => [status, totalResults, articles];

  @override
  bool get stringify => true;

  factory Response.fromJson(Map<String, dynamic> json) => _$ResponseFromJson(json);

}

