import 'package:json_annotation/json_annotation.dart';
part "help_entity.g.dart";
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class HelpEntity {
  HelpEntity({
    required this.content,
  });

  final List<Content> content;

  factory HelpEntity.fromJson(Map<String, dynamic> json) =>
      _$HelpEntityFromJson(json);

}

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class Content {
  Content({
     this.name,
     this.content,
     this.code,
     this.icon,
     this.child,
  });

   String? name;
   String? content;
   String? code;
   String? icon;
   String? rawSwg;
   List<Content>? child;


  @override
  String toString() {
    return 'Content{name: $name, content: $content, code: $code, icon: $icon, rawSwg: $rawSwg, child: $child}';
  }

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);
}
