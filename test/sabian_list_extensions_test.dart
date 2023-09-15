import 'package:flutter_test/flutter_test.dart';
import 'package:sabian_tools/extensions/Lists+Sabian.dart';

void main(){
  test("list conversion from string works",(){
    String jsonList = '["A","B","C","D"]';
    List<String> list = jsonList.toPrimitiveList<String>();
    assert(list.isNotEmpty && list.length == 4);
  });


  test("list conversion from int works",(){
    String jsonList = '[1,2,3,4]';
    List<int> list = jsonList.toPrimitiveList<int>();
    assert(list.isNotEmpty && list.length == 4);
    int total = list.reduce((value, element) => value + element);
    assert(total == 10);
  });

}