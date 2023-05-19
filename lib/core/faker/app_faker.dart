import 'package:faker/faker.dart';

class AppFaker {
  const AppFaker._();

  static final faker = Faker();

  static int randomInt(int max, {int min = 1}) =>
      faker.randomGenerator.integer(max, min: min);
  static int get randomId => randomInt(100);
  static double get randomDouble => faker.randomGenerator.decimal();
  static bool get randomBool => faker.randomGenerator.boolean();
  static String get email => faker.internet.disposableEmail();
  static String get name => faker.person.name();
  static String get phoneNumber => faker.phoneNumber.us();
  static String get sentence => faker.lorem.sentence();
  static String get word => faker.lorem.word();
  static String get words => faker.lorem.words(randomInt(15)).join();
  static DateTime get dateTime => faker.date.dateTime();
  static DateTime get dateOnly {
    final date = faker.date.dateTime();
    return DateTime(date.year, date.month, date.day);
  }

  static String get randomImage =>
      'https://picsum.photos/100/100?random=$randomId';
  // 'https://source.unsplash.com/900x900/?${faker.lorem.word()}'
  static List<int> get randomIdList => List.generate(
        AppFaker.randomInt(10),
        (index) => randomId,
      );
}
