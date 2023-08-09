import 'package:flutter/material.dart';
import 'package:news_app/services/news_client.dart';
import 'package:news_app/services/news_model.dart';

class HOMEPAGE extends StatefulWidget {
  const HOMEPAGE({super.key});

  @override
  State<HOMEPAGE> createState() => _HOMEPAGEState();
}

class _HOMEPAGEState extends State<HOMEPAGE> {
  NewClient cClient = NewClient();
  // late Map<String, dynamic> newsmap;
  List<dynamic> nList = [];
  Future<dynamic> getNews() async {
    Map<String, dynamic> newsmap =
        await cClient.getnewsdatafromapi(); //complete json map
    List<dynamic> nlist = newsmap['articles'];
    List<NewsModel> newslist = genericToSpecificObject(nlist);
    return newslist;
  }

  genericToSpecificObject(List<dynamic> list) {
    List<NewsModel> newslist = list.map((singleObject) {
      NewsModel singlenews = NewsModel.extractFromJSON(singleObject);
      return singlenews;
    }).toList();
    return newslist;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 0, 90, 245),
          title: const Text("NEWS APP"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: const Icon(Icons.replay))
          ],
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Color.fromARGB(255, 0, 0, 0),
            child: FutureBuilder(
                future: getNews(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: ((context, index) {
                          // return ListTile(
                          //   title: Text(
                          //     snapshot.data![index].title,
                          //     textAlign: TextAlign.left,
                          //   ),
                          // );
                          // return Card(
                          //   color: const Color.fromARGB(255, 171, 202, 255),
                          //   shadowColor: Color.fromARGB(255, 0, 0, 0),
                          //   elevation: 100,
                          return SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            // height: MediaQuery.of(context).size.height * 0.4,
                            child: Card(
                              color: Color.fromARGB(255, 167, 175, 189),
                              shadowColor: Color.fromARGB(255, 0, 0, 0),
                              elevation: 500,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.network(
                                        snapshot.data[index].urlToImage),
                                    Text(
                                      snapshot.data![index].title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Text(
                                      snapshot.data![index].description,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color:
                                              Color.fromARGB(255, 66, 66, 66)),
                                    ),
                                    Text(
                                      snapshot.data![index].url,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.blueAccent),
                                    ),
                                    Text(
                                      snapshot.data![index].author,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.deepOrange),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }));
                  }
                  return Container();
                })),
      ),
    );
  }
}
