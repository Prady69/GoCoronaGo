import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_karuna_go/models/NewsHeadline_Model.dart';
import 'package:go_karuna_go/repository/newsheadline_repository.dart';
import 'package:go_karuna_go/themes/dark_color.dart';
import 'package:go_karuna_go/widgets/news_card.dart';
import 'package:go_karuna_go/widgets/utilities_widgets/corona_loader.dart';
import 'package:http/http.dart' as http;

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  _ListPageState();
  Card makeCard(NewsHeadline news) => Card(
        elevation: 0.1,
        color: DarkColor.background,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Container(
          child: NewsCard(news),
        ),
      );

  Container createNewsList(List newsList) => Container(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: newsList.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: Duration(milliseconds: 500),
              child: SlideAnimation(
                horizontalOffset: index % 2 == 0 ? 100 : -100,
                verticalOffset: 0.0,
                child: FadeInAnimation(
                  child: makeCard(newsList[index]),
                ),
              ),
            );
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<NewsHeadline>>(
        future: getNews(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? createNewsList(snapshot.data)
              : Center(child: CoronaLoader());
        },
      ),
    );
  }
}
