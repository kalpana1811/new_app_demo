import 'package:dio/dio.dart';

class NewClient {
  final Dio _dio = Dio();

  getnewsdatafromapi() async {
    String newsurl =
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=e37706db883b4413ad53ea044c67b9a1";
    try {
      var resp = await _dio.get(newsurl);
      print("this is the news data from api ${resp.data}");
      return resp.data;
    } catch (error) {
      print("error in fetching data from api");
    }
  }
}
