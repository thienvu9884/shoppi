import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:shoppi/definition/constants.dart';
import 'package:shoppi/di/di.config.dart';
import 'package:shoppi/repositories/local/hive_client.dart';

import '../model/local/hive/user_model.dart';

final di = GetIt.asNewInstance()..allowReassignment = true;

@InjectableInit(preferRelativeImports: true)
Future<void> setupDependency() async {
  // ---------------------- HIVE ------------------------
  HiveClient hiveClient = HiveClient();
  hiveClient.initHiveClient();
  // Register Account database
  di.registerSingleton<Box<UserModel>>(
    Hive.box<UserModel>(Constants.hiveAccount),
  );

  di.init();
}
