import 'package:flutter/material.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({super.key});

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  PageController backgroundController = PageController();
  PageController topController = PageController(viewportFraction: 0.75);
  int topIndex = 0;
  int currentPage = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    topController.addListener(() {
      setState(() {
        currentPage = topController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("ui"),
      ),
      body: Stack(
        children: [
          PageView.builder(
              reverse: true,
              controller: backgroundController,
              itemCount: moviesList.length,
              itemBuilder: (context, index) {
                return ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                            colors: [Colors.white, Colors.transparent],
                            begin: Alignment.center,
                            end: Alignment.bottomCenter)
                        .createShader(bounds);
                  },
                  child: Image.network(
                    moviesList[index].image,
                    fit: BoxFit.cover,
                  ),
                );
              }),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: size.height * 0.50,
                width: size.width,
                child: PageView.builder(
                    controller: topController,
                    onPageChanged: (topIndex) {
                      setState(() {
                        backgroundController.animateToPage(topIndex,
                            duration: Duration(microseconds: 400),
                            curve: Curves.linear);
                      });
                    },
                    itemCount: moviesList.length,
                    itemBuilder: (context, topIndex) {
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: currentPage == topIndex ? 0 : 40),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          moviesList[topIndex].image),
                                      fit: BoxFit.cover,
                                      alignment: Alignment.topCenter)),
                              height: size.height * 0.30,
                              width: size.width * 0.50,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                moviesList[topIndex].name,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w900),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (var val in moviesList[topIndex].type)
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: Colors.grey.shade300)),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: Text(
                                        val,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  )
                              ],
                            )
                          ],
                        ),
                      );
                    }),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.black),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Text(
                    "Buy Ticket",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class Movies {
  Movies({required this.image, required this.type, required this.name});

  final String image;
  final String name;
  final List<String> type;
}

List<Movies> moviesList = [
  Movies(
      image: "https://mfiles.alphacoders.com/753/753447.png",
      type: ["Anime", "Sci-fi"],
      name: "Pokemon"),
  Movies(
      image:
          "https://image.api.playstation.com/vulcan/ap/rnd/202009/3021/B2aUYFC0qUAkNnjbTHRyhrg3.png",
      type: ["Anime", "Action"],
      name: "Spiderman"),
  Movies(
      image:
          "https://static.wikia.nocookie.net/p__/images/f/fd/Batman_%28Prime_Earth%29.jpg/revision/latest?cb=20230718090804&path-prefix=protagonist",
      type: ["Action", "Dark"],
      name: "Batman"),
  Movies(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHb3bT8f1hgEG2jE_xLtP4DHpXHk1NaXsBgA&s",
      type: ["Anime", "Game"],
      name: "Super Mario"),
  Movies(
      image:
          "https://i.pinimg.com/236x/23/d8/22/23d8222627e03b011142fd0d064ee838.jpg",
      type: ["Anime", "Game"],
      name: "BGMI"),
];
