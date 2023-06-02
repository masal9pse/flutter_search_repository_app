import 'package:flutter_engineer_codecheck/presentation/view/pages/counter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test singleton class', (){
    // final a = Manager();
    expect(Manager.instance.count, 0);
    Manager.instance.count++;
    expect(Manager.instance,Manager.instance);
  });

  test('test singleton class2', (){
    // final a = Manager();
    expect(Manager.instance.count, 1);
    expect(Manager.instance,Manager.instance);
  });
}