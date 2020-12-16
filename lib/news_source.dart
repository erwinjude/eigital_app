import 'networking.dart';

class Source {
  String api = '17471f29a07c4e91bdf5928830df1186';

  Future<List<dynamic>> getSourceList() async {
    NetworkHelper networkHelper = NetworkHelper(
        'http://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=$api');
    List sourceList = await networkHelper.getSourceData();
    return sourceList;
  }
}
