import 'package:flutter/material.dart';
import 'package:hlo/models/article_model.dart';
import 'package:hlo/models/category_model.dart';
import 'package:hlo/services/data.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hlo/services/slider_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../models/slider_model.dart';
import '../services/news.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<ArticleModel> articles = [];
  List<CategoryModel> categories = [];
  List<SliderModel> sliders = [];
  int activeIndex = 0;
  bool _loading = true;

  @override
  void initState() {
    categories = getCategories();
    sliders = getSliders();
    super.initState();
  }
  getNews() async{
    News newsClass = News();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Flutter"),
          Text(
            "News",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          )
        ]),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Column(children: [
          Container(
              margin: const EdgeInsets.only(left: 10.0),
              height: 70,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoryTile(
                        image: categories[index].image,
                        categoryName: categories[index].categoryName);
                  })),
          const SizedBox(height: 30.0),
          const Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Breaking News!",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0)),
                Text("View All",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0)),
              ],
            ),
          ),
          CarouselSlider.builder(
              itemCount: sliders.length,
              itemBuilder: (context, index, realIndex) {
                String? res = sliders[index].image;
                String? res1 = sliders[index].name;

                return buildImage(res!, index, res1!);
              },
              options: CarouselOptions(
                  autoPlayInterval: const Duration(milliseconds: 1000),
                  autoPlayAnimationDuration: const Duration(milliseconds: 900),
                  autoPlay: true,
                  height: 250,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  onPageChanged: (index, reason) {
                    setState(() {
                      activeIndex = index;
                    });
                  })),
          const SizedBox(height: 30.0),
          buildIndicator(),
          const SizedBox(height: 30.0),
          const Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Trending News!",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0)),
                Text("View All",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              elevation: 3.0,
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            "images/bussiness.jpg",
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                          )),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width / 1.7,
                            child: const Text(
                              "Rui seperated from her wife",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17),
                            )),
                        const SizedBox(
                          height: 7,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width / 1.7,
                            child: const Text(
                              "this is his wife",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ])),
      ),
    );
  }

  Widget buildIndicator() =>
      AnimatedSmoothIndicator(activeIndex: activeIndex, count: sliders.length);

  Widget buildImage(String image, int index, String name) => Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Stack(children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(image,
                fit: BoxFit.cover,
                height: 250,
                width: MediaQuery.of(context).size.width)),
        Container(
          height: 250,
          padding: const EdgeInsets.only(top: 20, left: 10.0),
          margin: const EdgeInsets.only(top: 170),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: Text(name,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500)),
        )
      ]));
}

class CategoryTile extends StatelessWidget {
  final image, categoryName;

  CategoryTile({super.key, this.image, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: Stack(
        //similar to box in compose
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(image,
                  width: 120, height: 250, fit: BoxFit.cover)),
          Container(
            width: 120,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.black26,
            ),
            child: Center(
              child: Text(categoryName,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }
}

