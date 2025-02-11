import 'package:flutter_test/flutter_test.dart';
import 'package:sabian_tools/extensions/Strings+Sabian.dart';

void main() {
  test("Is a match extension returns expected results", () {
    String value = "Brian is the most awesome Person in the world";
    String keyWord = "person";
    assert(value.isAMatchByKeyWord(keyWord));
  });

  test("Is a match extension returns false when not in reverse", () {
    String value = "Person";
    String keyWord = "Brian is an awesome person";
    assert(!value.isAMatchByKeyWord(keyWord));
  });

  test("Is a match extension returns true when in reverse", () {
    String value = "Person";
    String keyWord = "Brian is an awesome person";
    assert(value.isAMatchByKeyWord(keyWord, reverseCheck: true));
  });

  test("json deserialization extension can convert json to direct list",(){
    const data = "[\"https://ukall-apps.azurewebsites.net/akida/36/1024/images/xOpi.png\"]";
    final list = data.fromJsonToDirectListOrNull((e) => e as String);
    assert(list != null && list.length == 1);
  });

  test("json deserialization extension can convert json to direct item",(){
    const data = "\"https://ukall-apps.azurewebsites.net/akida/36/1024/images/xOpi.png\"";
    final list = data.fromDirectJsonOrNull((e) => e as String);
    assert(list != null);
  });

  test("json deserialization extension can convert json to list ", () {
    String json = """[
    {
    "ID" : 123,
    "name" : "Lisa Orio"
    },
    {
    "ID" : 124,
    "name" : "Mike Posner"
    }    
]""";

    List<_TestObject> data =
        json.fromJsonToList((p0) => _TestObject.fromJson(p0));
    assert(data.length == 2);
    assert(data[0].name == "Lisa Orio");
  });

  test("json deserialization extension can convert json to object", () {
    String json = """
    {
    "ID" : 123,
    "name" : "Lisa Orio"
    }
""";

    _TestObject data = json.fromJson((p0) => _TestObject.fromJson(p0));
    assert(data.name == "Lisa Orio" && data.ID == 123);
  });

  test("json deserialization returns null on failure for list", () {
    String json = """"ID" : 123,"name" : "Lisa Orio"}""";
    List<_TestObject>? data =
        json.fromJsonToListOrNull((p0) => _TestObject.fromJson(p0));
    assert(data == null);
  });

  test("json deserialization returns null on failure for object", () {
    String json = """"ID" : 123,"name" : "Lisa Orio"}""";
    _TestObject? data = json.fromJsonOrNull((p0) => _TestObject.fromJson(p0));
    assert(data == null);
  });

  test("if blank works", () {
    String blank = "  ";
    String value = blank.ifBlank(() => "not blank");
    assert(value == "not blank");

    blank = "still not blank";
    value = blank.ifBlank(() => "not blank");
    assert(value == "still not blank");
  });

  test("if empty works", () {
    String blank = "";
    String value = blank.ifEmpty(() => "not blank");
    assert(value == "not blank");


    blank = "  ";
    value = blank.ifEmpty(() => "not blank");
    assert(value == "  ");

    blank = "still not blank";
    value = blank.ifEmpty(() => "not blank");
    assert(value == "still not blank");
  });


  test("if null works", () {
    String? blank;
    String value = blank.ifNullOrBlank(() => "not blank");
    assert(value == "not blank");

    blank = " ";
    value = blank.ifBlank(() => "not blank");
    assert(value == "not blank");
  });

  test("if null empty works", () {
    String? blank;
    String value = blank.ifNullOrEmpty(() => "not blank");
    assert(value == "not blank");


    blank = "  ";
    value = blank.ifEmpty(() => "not blank");
    assert(value == "  ");

    blank = "still not blank";
    value = blank.ifEmpty(() => "not blank");
    assert(value == "still not blank");
  });

  test("stripped spaces works",(){
    String withSpaces = " test all      spaces ";
    String stripped = withSpaces.noWhiteSpaces;
    assert(stripped == "testallspaces");
  });

  test("escape regex works",(){
    String specialString = "Brian //@Sabana@#<>";
    String escaped = specialString.replaceSpecialRegexChars(replacement : "").noWhiteSpaces;
    assert(escaped == "BrianSabana");

    specialString = "Lisa@::Brian //@Sabana@#<>";
    escaped = specialString.replaceSpecialRegexChars(replacement : "").noWhiteSpaces;
    assert(escaped == "LisaBrianSabana");
  });
}

class _TestObject {
  int? ID;
  String? name;

  _TestObject();

  factory _TestObject.fromJson(Map<String, dynamic> json) {
    _TestObject object = _TestObject()
      ..ID = json['ID'] as int?
      ..name = json["name"] as String?;
    return object;
  }
}
