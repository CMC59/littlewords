
import 'package:freezed_annotation/freezed_annotation.dart';

part 'version_dto.g.dart';

// flutter pub run build_runner build --delete-conflicting-outputs
@JsonSerializable()
class VersionDTO{
  VersionDTO(this.version);

    final String version;

    VersionDTO fromJson(json) => _$VersionDTOFromJson(json);
}