class FrequencyCounter {
  static int frequencyCounter(String sentance, {required String keyword}) {
    int count = 0;

    final allMatches = sentance.allMatches(keyword, 0).toList();

    print('All matches $allMatches');

    List words = sentance.split(' ');
    List keywords = keyword.split(' ');
    print('Keyword -- $keywords');

    print('Words -- $words');

    for (var item in words) {
      if (keyword.contains(item)) {
        count++;
      }
    }

    // for (var element in words) {
    //   if (element == keyword) {
    //     print('Word mathc $element');
    //     count++;
    //   }
    // }
    return count;
  }
}
