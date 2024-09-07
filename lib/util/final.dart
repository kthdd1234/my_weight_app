import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_weight_app/common/CommonSegmented.dart';
import 'package:my_weight_app/repository/category_repository.dart';
import 'package:my_weight_app/repository/record_repository.dart';
import 'package:my_weight_app/repository/user_repository.dart';
import 'package:my_weight_app/util/class.dart';
import 'package:my_weight_app/util/enum.dart';
import 'package:table_calendar/table_calendar.dart';

String tSystem = Themes.system.toString();
String tLight = Themes.light.toString();
String tDark = Themes.dark.toString();

final indigo = ColorClass(
  colorName: '남색',
  original: Colors.indigo, // 63, 81, 181
  s50: Colors.indigo.shade50, // 232, 234, 246
  s100: Colors.indigo.shade100, // 197, 202, 233
  s200: Colors.indigo.shade200, // 159, 168, 218
  s300: Colors.indigo.shade300, // 255, 121, 134, 203
  s400: Colors.indigo.shade400,
);

final green = ColorClass(
  colorName: '녹색',
  original: Colors.green,
  s50: Colors.green.shade50,
  s100: Colors.green.shade100,
  s200: Colors.green.shade200, // 165, 214, 167
  s300: Colors.green.shade300,
  s400: Colors.green.shade400,
); //

final teal = ColorClass(
  colorName: '청록색',
  original: Colors.teal,
  s50: Colors.teal.shade50,
  s100: Colors.teal.shade100, // 178, 223, 219
  s200: Colors.teal.shade200, // 128, 203, 196
  s300: Colors.teal.shade300, // 255, 77, 182, 172
  s400: Colors.teal.shade400,
); //

final red = ColorClass(
  colorName: '빨간색',
  original: Colors.red,
  s50: Colors.red.shade50,
  s100: Colors.red.shade100, // 255, 205, 210
  s200: Colors.red.shade200, // 239, 154, 154
  s300: Colors.red.shade300, // 229, 115, 115
  s400: Colors.red.shade400,
); //

final pink = ColorClass(
  colorName: '핑크색',
  original: Colors.pink,
  s50: Colors.pink.shade50,
  s100: Colors.pink.shade100,
  s200: Colors.pink.shade200,
  s300: Colors.pink.shade300,
  s400: Colors.pink.shade400,
); //

final blue = ColorClass(
  colorName: '파란색',
  original: Colors.blue, // 33, 150, 243
  s50: Colors.blue.shade50, // 227, 242, 253
  s100: Colors.blue.shade100, // 187, 222, 251
  s200: Colors.blue.shade200, // 144, 202, 249
  s300: Colors.blue.shade300, // 100, 181, 246
  s400: Colors.blue.shade400, // 66, 165, 245
); //

final brown = ColorClass(
  colorName: '갈색',
  original: Colors.brown,
  s50: Colors.brown.shade50,
  s100: Colors.brown.shade100,
  s200: Colors.brown.shade200,
  s300: Colors.brown.shade300,
  s400: Colors.brown.shade400,
); //

final orange = ColorClass(
  colorName: '주황색',
  original: Colors.orange,
  s50: Colors.orange.shade50,
  s100: Colors.orange.shade100, // 255, 224, 178
  s200: Colors.orange.shade200, // 255, 204, 128
  s300: Colors.orange.shade300,
  s400: Colors.orange.shade400,
); //

final purple = ColorClass(
  colorName: '보라색',
  original: Colors.purple,
  s50: Colors.purple.shade50,
  s100: Colors.purple.shade100, // 225, 190, 231
  s200: Colors.purple.shade200, // 206, 147, 216
  s300: Colors.purple.shade300,
  s400: Colors.purple.shade400,
); //

final grey = ColorClass(
  colorName: '회색',
  original: Colors.grey.shade600,
  s50: Colors.grey.shade50,
  s100: Colors.grey.shade100,
  s200: Colors.grey.shade200,
  s300: Colors.grey.shade300,
  s400: Colors.grey.shade400,
); //

final lime = ColorClass(
  colorName: '라임색',
  original: Colors.lime,
  s50: Colors.lime.shade50,
  s100: Colors.lime.shade100,
  s200: Colors.lime.shade200,
  s300: Colors.lime.shade300,
  s400: Colors.lime.shade400,
); //

final cyan = ColorClass(
  colorName: '민트색',
  original: Colors.cyan,
  s50: Colors.cyan.shade50,
  s100: Colors.cyan.shade100,
  s200: Colors.cyan.shade200, // 128, 222, 234
  s300: Colors.cyan.shade300,
  s400: Colors.cyan.shade400, // 38, 198, 218
); //

final ember = ColorClass(
  colorName: '노랑색',
  original: Colors.amber,
  s50: Colors.amber.shade50,
  s100: Colors.amber.shade100,
  s200: Colors.amber.shade200,
  s300: Colors.amber.shade300,
  s400: Colors.amber.shade400,
); //

final blueGrey = ColorClass(
  colorName: '청회색',
  original: Colors.blueGrey,
  s50: Colors.blueGrey.shade50,
  s100: Colors.blueGrey.shade100, // 207, 216, 200
  s200: Colors.blueGrey.shade200, // 176, 190, 197
  s300: Colors.blueGrey.shade300,
  s400: Colors.blueGrey.shade400,
); //

final lightBlue = ColorClass(
  colorName: 'lightBlue',
  original: Colors.lightBlue,
  s50: Colors.lightBlue.shade50,
  s100: Colors.lightBlue.shade100,
  s200: Colors.lightBlue.shade200,
  s300: Colors.lightBlue.shade300,
  s400: Colors.lightBlue.shade400,
);

final colorList = [
  indigo,
  red,
  pink,
  green,
  teal,
  blue,
  brown,
  orange,
  purple,
  blueGrey
];

final calendarFormatInfo = {
  CalendarFormat.week.toString(): CalendarFormat.week,
  CalendarFormat.month.toString(): CalendarFormat.month,
};

final availableCalendarFormats = {
  CalendarFormat.week: 'week',
  CalendarFormat.month: 'month',
};

const nextCalendarFormats = {
  CalendarFormat.week: CalendarFormat.month,
  CalendarFormat.month: CalendarFormat.week
};

UserRepository userRepository = UserRepository();
RecordRepository recordRepository = RecordRepository();
ConditionRepository conditionRepository = ConditionRepository();

final valueListenables = [
  userRepository.userBox.listenable(),
  recordRepository.recordBox.listenable(),
  conditionRepository.conditionBox.listenable()
];

final daysInfo = {
  '일': 7,
  '월': 1,
  '화': 2,
  '수': 3,
  '목': 4,
  '금': 5,
  '토': 6,
  0: 7,
  1: 1,
  2: 2,
  3: 3,
  4: 4,
  5: 5,
  6: 6,
};

Map<TextAlign, TextAlign> nextTextAlign = {
  TextAlign.left: TextAlign.center,
  TextAlign.center: TextAlign.right,
  TextAlign.right: TextAlign.left
};

Map<TextAlign, String> textAlignName = {
  TextAlign.left: 'left',
  TextAlign.center: 'center',
  TextAlign.right: 'right'
};

List<Map<String, String>> fontFamilyList = [
  {
    "fontFamily": "Omyu",
    "name": "오뮤 다예쁨체",
  },
  {
    "fontFamily": "DongDong",
    "name": "카페24 동동",
  },
  {
    "fontFamily": "Hyemin",
    "name": "IM 혜민",
  },
  {
    "fontFamily": "Kyobo",
    "name": "교보 손글씨",
  },
  {
    "fontFamily": "LeeSeoyun",
    "name": "이서윤체",
  },
  {
    "fontFamily": "SingleDay",
    "name": "싱글데이",
  },
  {
    "fontFamily": "OpenSans",
    "name": "OpenSans",
  },
];

final languageList = [
  {'svgName': 'korea', 'lang': 'ko', 'name': '한국어'},
  {'svgName': 'usa', 'lang': 'en', 'name': 'English'},
  {'svgName': 'japan', 'lang': 'ja', 'name': '日本語'},
];

final textAlignInfo = {
  TextAlign.left.toString(): TextAlign.left,
  TextAlign.right.toString(): TextAlign.right,
  TextAlign.center.toString(): TextAlign.center,
};

final alignmentInfo = {
  TextAlign.left: Alignment.topLeft,
  TextAlign.center: Alignment.topCenter,
  TextAlign.right: Alignment.topRight,
};

final crossAxisAlignmentInfo = {
  TextAlign.left: CrossAxisAlignment.start,
  TextAlign.center: CrossAxisAlignment.center,
  TextAlign.right: CrossAxisAlignment.end,
};

final themesInfo = {tSystem: '시스템 설정', tLight: '화이트 모드', tDark: '다크 모드'};

final localeInfo = {'en': 'English', 'ko': '한국어', 'ja': '日本語'};

final premiumBenefitsClassList = [
  PremiumBenefitsClass(
    svgName: 'premium-free',
    title: '한 번만 결제하면 평생 이용할 수 있어요',
    subTitle: '깔끔하게 단 한번 결제!',
  ),
  PremiumBenefitsClass(
    svgName: 'premium-ads',
    title: '모든 화면에서 광고가 제거돼요',
    subTitle: '광고없이 쾌적하게 앱을 사용해보세요',
  ),
  PremiumBenefitsClass(
    svgName: 'category',
    title: '노트를 제한없이 추가할 수 있어요',
    subTitle: '다양한 노트를 제한없이 추가해보세요',
  ),
  PremiumBenefitsClass(
    svgName: 'gallery',
    title: '사진을 최대 6장까지 추가 할 수 있어요',
    subTitle: '보다 많은 노트 사진을 추가해보세요!',
  ),
  PremiumBenefitsClass(
    svgName: 'premium-backdrop',
    title: '다양한 배경 테마들을 제공해드려요',
    subTitle: '총 6종의 배경 테마들을 이용해보세요!',
  ),
];

final backgroundClassList = [
  [
    BackgroundClass(path: '1', name: '타입 1'),
    BackgroundClass(path: '2', name: '타입 2'),
  ],
  [
    BackgroundClass(path: '3', name: '타입 3'),
    BackgroundClass(path: '4', name: '타입 4'),
  ],
  [
    BackgroundClass(path: '5', name: '타입 5'),
    BackgroundClass(path: '6', name: '타입 6'),
  ],
];

List<ConditionInfoClass> initConditionInfoList = [
  ConditionInfoClass(id: '1', text: '최상', colorName: '파란색'),
  ConditionInfoClass(id: '2', text: '좋음', colorName: '남색'),
  ConditionInfoClass(id: '3', text: '보통', colorName: '청록색'),
  ConditionInfoClass(id: '4', text: '나쁨', colorName: '보라색'),
  ConditionInfoClass(id: '5', text: '최악', colorName: '빨간색'),
  ConditionInfoClass(id: '6', text: '꿀잠', colorName: '파란색'),
  ConditionInfoClass(id: '7', text: '늦잠', colorName: '파란색'),
  ConditionInfoClass(id: '8', text: '상쾌', colorName: '파란색'),
  ConditionInfoClass(id: '9', text: '폭식', colorName: '파란색'),
  ConditionInfoClass(id: '10', text: '슬픔', colorName: '파란색'),
  ConditionInfoClass(id: '11', text: '생리', colorName: '파란색'),
  ConditionInfoClass(id: '12', text: '감기', colorName: '빨간색'),
  ConditionInfoClass(id: '13', text: '스트레스', colorName: '빨간색'),
  ConditionInfoClass(id: '14', text: '두통', colorName: '빨간색'),
  ConditionInfoClass(id: '15', text: '살찜', colorName: '빨간색'),
  ConditionInfoClass(id: '16', text: '증량', colorName: '보라색'),
  ConditionInfoClass(id: '17', text: '체함', colorName: '보라색'),
  ConditionInfoClass(id: '18', text: '설사', colorName: '보라색'),
  ConditionInfoClass(id: '19', text: '변비', colorName: '보라색'),
];

categorySegmented(SegmentedTypes segmented) {
  Map<SegmentedTypes, Widget> segmentedData = {
    SegmentedTypes.weight: onSegmentedWidget(
      title: '체중',
      type: SegmentedTypes.weight,
      selected: segmented,
    ),
    SegmentedTypes.image: onSegmentedWidget(
      title: '사진',
      type: SegmentedTypes.image,
      selected: segmented,
    ),
  };

  return segmentedData;
}

Map<SegmentedTypes, int> rangeInfo = {
  SegmentedTypes.week: 6,
  SegmentedTypes.twoWeek: 13,
  SegmentedTypes.month: 29,
  SegmentedTypes.threeMonth: 89,
  SegmentedTypes.sixMonth: 179,
  SegmentedTypes.oneYear: 364,
};

String eGraphDefault = GraphEnum.default_.toString();

String eGraphCustom = GraphEnum.custom.toString();

String eGraphWeight = GraphEnum.weight.toString();

String eGraphSteps = GraphEnum.steps.toString();

String eWeightKg = WeightUnit.kg.toString();

String eWeightlb = WeightUnit.lb.toString();

String eWegihtId = CategoryOpenId.weight.toString();

String eImageId = CategoryOpenId.image.toString();

String eDietId = CategoryOpenId.diet.toString();

String eExerciseId = CategoryOpenId.exercise.toString();

String eConditionId = CategoryOpenId.condition.toString();

String eDiaryId = CategoryOpenId.diary.toString();
