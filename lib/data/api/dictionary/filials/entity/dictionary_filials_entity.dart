import 'package:json_annotation/json_annotation.dart';

part 'dictionary_filials_entity.g.dart';

@JsonSerializable(createToJson: false)
class DictionaryFilialEntity {
  final List<DictionaryData> data;
  final Links links;
  final Meta meta;

  DictionaryFilialEntity({
    required this.data,
    required this.links,
    required this.meta,
  });

  factory DictionaryFilialEntity.fromJson(Map<String, dynamic> json) =>
      _$DictionaryFilialEntityFromJson(json);
}

@JsonSerializable(createToJson: false)
class DictionaryData {
  final int id;
  final String name;

  DictionaryData({
    required this.id,
    required this.name,
  });

  factory DictionaryData.fromJson(Map<String, dynamic> json) =>
      _$DictionaryDataFromJson(json);
}

@JsonSerializable(createToJson: false)
class Links {
  final String? first;
  final String? last;
  final String? prev;
  final String? next;

  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);
}

@JsonSerializable(createToJson: false)
class Meta {
  @JsonKey(name: 'current_page')
  final int currentPage;
  @JsonKey(name: 'last_page')
  final int lastPage;
  @JsonKey(name: 'per_page')
  final int perPage;
  final int total;
  final int? from;
  final int? to;
  final String path;
  final List<MetaLinks> links;

  Meta({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    this.from,
    this.to,
    required this.path,
    required this.links,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
}

@JsonSerializable(createToJson: false)
class MetaLinks {
  final String? url;
  final String? label;
  final bool? active;

  MetaLinks({
    required this.url,
    required this.label,
    required this.active,
  });

  factory MetaLinks.fromJson(Map<String, dynamic> json) =>
      _$MetaLinksFromJson(json);
}
