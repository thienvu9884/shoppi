import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:shoppi/model/local/hive/user_model.dart';
import 'package:shoppi/repositories/local/user_repository.dart';
import 'package:shoppi/services/base_service.dart';

@injectable
class UserService extends BaseService {
  final UserRepository _userRepository;

  UserService(this._userRepository);

  ValueListenable<Box<UserModel>> listenable() {
    return userBox.listenable();
  }

  Future<void> addUser(UserModel user) async {
    _userRepository.addUser(user);
  }

  void enableUser(int index) {
    _userRepository.enableUser(index);
  }

  void deleteUser(int index) {
    _userRepository.deleteUser(index);
  }
}
