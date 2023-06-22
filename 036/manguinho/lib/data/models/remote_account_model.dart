import '../../domain/entities/entities.dart';
import '../data.dart';

class RemoteAccountModel {
  RemoteAccountModel(this.accessToken);

  final String accessToken;

  factory RemoteAccountModel.fromMap(Map map) {
    if (!map.containsKey('accessToken')) {
      throw HttpError.invalidData;
    }

    return RemoteAccountModel(
      map['accessToken'],
    );
  }

  AccountEntity toEntity() => AccountEntity(accessToken);
}
