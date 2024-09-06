import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_weight_app/model/condition_box/condition_box.dart';
import 'package:my_weight_app/model/reocrd_box/record_box.dart';
import 'package:my_weight_app/model/user_box/user_box.dart';

class InitHive {
  Future<void> initializeHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter(UserBoxAdapter());
    Hive.registerAdapter(RecordBoxAdapter());
    Hive.registerAdapter(ConditionBoxAdapter());

    await Hive.openBox<UserBox>(InitHiveBox.userBox);
    await Hive.openBox<RecordBox>(InitHiveBox.recordBox);
    await Hive.openBox<ConditionBox>(InitHiveBox.conditionBox);
  }
}

class InitHiveBox {
  static const String userBox = 'userBox';
  static const String recordBox = 'recordBox';
  static const String conditionBox = 'conditionBox';
}
