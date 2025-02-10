void main() {
  classA obj = classA();
  print(obj.data); // 100 を出力
}

class classA extends classB {
  @override
  // TODO: implement data
  int get data => 10;
}

abstract class classB extends classC {
  classB() {
    print('classB');
  }
}

abstract class classC {
  int get data;

  classC();
}
