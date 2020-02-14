import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monies/data/models/category.dart';

void main() {
  group('JSON parsing', () {
    test('toJsonString returns valid json string', () {
      final category = ExpenseCategory("1", "test_title", 3, Colors.black.value, Icons.battery_alert.codePoint);

      final jsonString = category.toJsonString();

      expect(jsonString, isNotNull);
      expect(jsonString, isA<String>());
      expect(jsonString, equals(r'{"id":"1","title":"test_title","order":3,"colorCode":4278190080,"iconCode":57756}'));
    });

    test('fromJsonString returns valid object', () {
      final jsonString = r'{"id":"1","title":"test_title","order":3,"colorCode":4278190080,"iconCode":57756}';

      final category = ExpenseCategory.fromJsonString(jsonString);

      expect(category, isNotNull);
      expect(category, isA<ExpenseCategory>());
      expect(category.id, equals("1"));
      expect(category.title, equals("test_title"));
      expect(category.colorCode, equals(Colors.black.value));
      expect(category.iconCode, equals(57756));
    });

    test('fromJsonString throws FormatException when called with malformed string', () {
      final jsonString = r'{malformed_json_string}';

      try {
        ExpenseCategory.fromJsonString(jsonString);
      } on FormatException {
        expect(true, isTrue);
        return;
      }

      fail("FormatException should be raised");
    });
  });

  test('.empty() returns correctly initialized object', () {
    final category = ExpenseCategory.empty();

    expect(category, isNotNull);
    expect(category.id, isNot(equals("")));
    expect(category.title, equals(""));
    expect(category.order, equals(0));
    expect(category.colorCode, isNull);
    expect(category.iconCode, isNull);
  });

  test('Returns correct color', () {
    final category = ExpenseCategory("1", "test_title", 3, Colors.yellow.shade700.value, Icons.battery_alert.codePoint);

    expect(category, isNotNull);
    expect(category.color, equals(Colors.yellow.shade700));
  });

  test('Returns default color when colorCode is not set', () {
    final category = ExpenseCategory("1", "test_title", 3, null, Icons.battery_alert.codePoint);

    expect(category, isNotNull);
    expect(category.colorCode, isNull);
    expect(category.color, equals(ExpenseCategory.defaultColor));
  });

   test('Returns default icon when iconCode is not set', () {
    final category = ExpenseCategory("1", "test_title", 3, Colors.black.value, null);

    expect(category, isNotNull);
    expect(category.iconCode, isNull);
    expect(category.icon, equals(ExpenseCategory.defaultIcon));
  }); 
}