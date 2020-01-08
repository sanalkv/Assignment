import 'package:assignment/UI/widgets/comment_box_widget.dart';
import 'package:assignment/UI/widgets/user_comment_widget.dart';
import 'package:assignment/model/comments_page_model.dart';
import 'package:flutter/material.dart';

class CommentsPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Comments",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder<UserCommentsResponse>(
        future: loadJsonData(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(height: 20),
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 15,
                    ),
                    itemCount: snapshot.data.comments.length,
                    itemBuilder: (BuildContext context, int index) =>
                        UserCommentWidget(
                      scaffoldKey: _scaffoldKey,
                      comment: snapshot.data.comments[index],
                    ),
                  ),
                ),
                CommentBoxWidget()
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<UserCommentsResponse> loadJsonData(BuildContext context) async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/json/comments_page_response.json");
    return userCommentsResponseFromJson(data);
  }
}
