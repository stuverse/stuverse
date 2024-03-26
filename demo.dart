class Counter {
  int _count = 0;

  int get count => _count;
  void set count(int value) {
    if (value >= 0) {
      _count = value;
    }
  }
}

void main() {
  final counter1 = Counter();

  //Profile page

  print(counter1.count);
}
