import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'source.dart';

part 'article.g.dart';

@JsonSerializable()
class Article extends Equatable {

  final Source source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  const Article({
    required this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  @override
  List<Object?> get props {
    return [
      source,
      author,
      title,
      description,
      url,
      urlToImage,
      publishedAt,
      content,
    ];
  }

  @override
  bool get stringify => true;

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);
}
