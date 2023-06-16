import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CatCardDetail extends StatefulWidget {
  const CatCardDetail({super.key, required this.catDescription, required this.imageUrl});

  final Map<String, dynamic> catDescription;
  final String imageUrl;

  @override
  CatCardDetailState createState() => CatCardDetailState();
}

class CatCardDetailState extends State<CatCardDetail> {

  late Map<String, dynamic> _catDescription;
  late String _imageUrl;

  @override
  void initState() {
    _catDescription = widget.catDescription;
    _imageUrl = widget.imageUrl;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

     extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: Text(_catDescription["name"]),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [

          Container(
            alignment: Alignment.center,
            child: Image.network(
              _imageUrl,
              height: 280,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return const Text('');
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: 
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                child: 
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "About ${_catDescription["name"]}:\n",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,// Example color customization
                        ),
                      ),
                      Text("${_catDescription["description"]}\n"),

                      buildProgressIndicator("Adaptability", double.parse(_catDescription['adaptability'].toString()), context),
                      buildProgressIndicator("Affection Level", double.parse(_catDescription['affection_level'].toString()), context),
                      buildProgressIndicator("Child Friendly", double.parse(_catDescription['child_friendly'].toString()), context),
                      buildProgressIndicator("Dog Friendly", double.parse(_catDescription['dog_friendly'].toString()), context),
                      buildProgressIndicator("Stranger Friendly", double.parse(_catDescription['stranger_friendly'].toString()), context),
                      
                      const SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: "Temperament: ",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: _catDescription["temperament"],
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: "Life Span: ",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: _catDescription["life_span"],
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
              ),
              )
            ),
          ),
        ],
      ),
    );
  }
}


Widget buildProgressIndicator(String labelText, double value, context) {
  return Column(
    children: [
      Row(children : [
        Text(
          labelText,
          style: const TextStyle(
            fontWeight: FontWeight.bold,// Example color customization
          ),
        ),
      ]),
      Padding(
        padding: const EdgeInsets.only(right: 0, top: 5, left: 20, bottom: 0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 6,
          child: LinearPercentIndicator(
            width: MediaQuery.of(context).size.width * 0.8,
            lineHeight: 3.0,
            percent: value / 5,
            backgroundColor: const Color.fromARGB(255, 189, 183, 205),
            progressColor: const Color.fromARGB(255, 47, 179, 255),
          ),
        ),
      ),
      const SizedBox(height: 10),
    ],
  );
}
