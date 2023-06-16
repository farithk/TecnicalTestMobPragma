import 'package:flutter/material.dart';
import 'package:pragmacats/Views/card_detail.dart';
import '../Services/cat_api_service.dart';
import '../Services/cat_images_api.dart';

class CatCards extends StatefulWidget {
  const CatCards({super.key});

  @override
  CatCardsState createState() => CatCardsState();
}

class CatCardsState extends State<CatCards> {
  List<dynamic> catBreeds = [];
  List<dynamic> catBreedsFiltered = [];
  late final TextEditingController _searchWord;
  ScrollController scrollController = ScrollController();
  int pagination = 4;
  int pageIndex = 1;
  int totalPages = 0;
  List<dynamic> actualCatBreeds = [];
  bool waitingData = true;

  String errorDataMessage = "";

  @override
  void initState() {
    fetchBreeds().then((value) {
      setState(() {
        catBreeds = value;
        catBreedsFiltered =value;
        actualCatBreeds = catBreeds.sublist(pagination - 4, pagination + 1);
        totalPages = (actualCatBreeds.length / 5).ceil();
      });
    });

    _searchWord = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchWord.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: const Color.fromARGB(255, 249, 249, 249),
            child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchWord,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: 'Type a breed to search',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Color.fromARGB(255, 91, 91, 91)),
                ),
              ),
              onChanged: (value) {
                setState(() {
                    pagination = 4;
                    pageIndex = 1;
                    catBreedsFiltered = catBreeds.where((element) => element["name"].toLowerCase().contains(value)).toList();
                    if(catBreedsFiltered.isEmpty){
                      errorDataMessage = "Data not found";
                    }
                });
              },
            ),
          ),
          ),
          const Divider(
            height: 0,
            thickness: 1,
            indent: 0,
            endIndent: 0,
            color: Color.fromARGB(255, 0, 67, 150),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<List<Widget>>(
                    future: handleCards(
                      searchWord: _searchWord.text,
                      actualCatBreeds: catBreedsFiltered,
                      pagination: pagination,
                      errorDataMessage: errorDataMessage,
                      context: context
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          height: 100,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Column(
                          children: snapshot.data!,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            height: 0,
            thickness: 1,
            indent: 0,
            endIndent: 0,
            color: Color.fromARGB(255, 0, 67, 150),
          ),
          Container(
            color: const Color.fromARGB(255, 249, 249, 249),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  if (pagination >= 9) {
                    setState(() {
                      pageIndex--;
                      pagination -= 5;
                    });
                  }
                },
                icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 16, 120, 238)),
              ),
              Text("page $pageIndex of ${(catBreedsFiltered.length / 5).ceil()}"),
              IconButton(
                onPressed: () {
                  if (pageIndex < (catBreedsFiltered.length / 5).ceil()) {
                    setState(() {
                      pageIndex++;
                      pagination += 5;
                    });
                  }
                },
                icon: const Icon(Icons.arrow_forward, color: Color.fromARGB(255, 16, 120, 238)),
              ),
            ],
          ),
          ),
        ],
      ),
    );
  }
}

Future<List<Widget>> handleCards({
  required String searchWord,
  required List<dynamic> actualCatBreeds,
  required int pagination,
  required String errorDataMessage,
  required context
}) async {
  if(actualCatBreeds.length > pagination){
    actualCatBreeds = actualCatBreeds.sublist(pagination - 4, pagination + 1);
  } else {
    actualCatBreeds = actualCatBreeds.sublist(pagination - 4, actualCatBreeds.length);
  }
  final items = <Widget>[];
  for (var item in actualCatBreeds) {
      var imageUrl = await fetchBreedsImages(item["reference_image_id"]);
      items.add(
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
          child: 
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 16, 120, 238),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(153, 162, 162, 0.2),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                        onError: (exception, stackTrace) async {
                          // Nothing to do
                        },
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(80)),
                    ),
                  ),
                  Expanded(
                    child: 
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(child: 
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: "Name: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: item["name"],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            )
                            
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(child: RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: "Origin: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: item["origin"],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300
                                    ),
                                  ),
                                ],
                              ),
                            ),),
                          ],
                        ),
                      ],
                    ),
                      
                  ),
                  IconButton(onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CatCardDetail(catDescription: item, imageUrl: imageUrl)
                        )
                    );
                  }, icon: const Icon(Icons.info_outline, color: Color(0xFF1078EE),),)
                ],
              ),
            ),

           
          
        ),

      );
  }

  if (items.isEmpty) {
    items.add(
      SizedBox(
        height: 100,
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                errorDataMessage,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 255, 141, 133),
                ),
              ),
              )
            ),
          ],
        ),
      ),
      

    );
  }
  
  return items;
}
