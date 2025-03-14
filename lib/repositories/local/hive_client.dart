import 'package:hive_flutter/hive_flutter.dart';
import 'package:shoppi/definition/constants.dart';
import 'package:shoppi/model/local/hive/user_model.dart';

class HiveClient {
  Future<void> initHiveClient() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    await Hive.openBox<UserModel>(Constants.hiveAccount);
  }
}
