class FrequencyCounter {
  static int frequencyCounter(String sentance, {required String keyword}) {
    int count = 0;

    List words = sentance.split(' ');
    print('Words -- $words');
    for (var element in words) {
      if (element == keyword) {
        print('Word mathc $element');
        count++;
      }
    }
    return count;
  }
}
