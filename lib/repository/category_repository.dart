import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:my_weight_app/model/condition_box/condition_box.dart';
import 'package:my_weight_app/repository/init_hive.dart';

class ConditionRepository {
  Box<ConditionBox>? _conditionBox;

  Box<ConditionBox> get conditionBox {
    _conditionBox ??= Hive.box<ConditionBox>(InitHiveBox.conditionBox);
    return _conditionBox!;
  }

  List<ConditionBox> get conditionList {
    return conditionBox.values.toList();
  }

  void updateCondition({
    required dynamic key,
    required ConditionBox condition,
  }) async {
    await conditionBox.put(key, condition);
    log('[updateCondition] update (key:$key) $condition');
  }

  void deleteCondition(int key) async {
    await conditionBox.delete(key);
    log('[deleteCondition] delete (key:$key)');
  }
}
