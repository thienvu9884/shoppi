import 'package:hive_flutter/hive_flutter.dart';
import 'package:shoppi/di/di.dart';
import 'package:shoppi/model/local/hive/user_model.dart';

class BaseRepository {
  final userBox = di.get<Box<UserModel>>();
}
