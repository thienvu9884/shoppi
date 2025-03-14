import 'package:injectable/injectable.dart';
import 'package:shoppi/model/local/hive/user_model.dart';
import 'package:shoppi/repositories/base_repository.dart';

abstract class UserRepository {
  Future<void> addUser(UserModel user);

  Future<void> enableUser(int index);

  Future<void> deleteUser(int index);
}

@Injectable(as: UserRepository)
class UserLocalRepositoryImpl extends BaseRepository implements UserRepository {
  UserLocalRepositoryImpl();

  @override
  Future<void> addUser(UserModel user) async {
    userBox.add(user);
    return;
  }

  @override
  Future<void> enableUser(int index) async {
    final user = userBox.getAt(index);
    if (user != null) {
      userBox.putAt(
        index,
        UserModel(
          id: user.id,
          userName: user.userName,
          password: user.password,
          isCompleted: !user.isCompleted,
        ),
      );
    }
  }

  @override
  Future<void> deleteUser(int index) async {
    userBox.deleteAt(index);
    return;
  }
}
