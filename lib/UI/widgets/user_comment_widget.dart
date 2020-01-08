import 'package:assignment/UI/widgets/comment_box_widget.dart';
import 'package:assignment/model/comments_page_model.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:stopper/stopper.dart';

class UserCommentWidget extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool showReplyButton;
  final bool showLikeButton;
  final Comment comment;
  const UserCommentWidget(
      {Key key,
      this.scaffoldKey,
      this.showReplyButton = true,
      @required this.comment,
      this.showLikeButton = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image(
                image: AssetImage("assets/usericon.jpg"),
                height: 40,
                width: 40,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        comment.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        comment.time,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(comment.comment)
                ],
              ),
            )
          ],
        ),
        SizedBox(height: 5),
        Row(
          children: <Widget>[
            SizedBox(
              width: 50,
            ),
            showReplyButton
                ? InkWell(
                    child: Text(
                      "Reply",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    onTap: () => openBottomSheet(context),
                  )
                : Container(),
            showReplyButton ? SizedBox(width: 10) : Container(),
            showReplyButton
                ? Icon(
                    Icons.chat_bubble_outline,
                    size: 15,
                    color: Colors.grey,
                  )
                : Container(),
            showReplyButton ? SizedBox(width: 5) : Container(),
            showReplyButton
                ? Text(
                    comment.replies.length.toString(),
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  )
                : Container(),
            showReplyButton ? Spacer() : Container(),
            showLikeButton
                ? LikeButton(
                    countPostion: CountPostion.right,
                    likeCount: comment.likes,
                    bubblesColor: BubblesColor(
                      dotPrimaryColor: Colors.blue[400],
                      dotSecondaryColor: Colors.blue[400],
                    ),
                    circleColor: CircleColor(
                      start: Colors.blue[50],
                      end: Colors.blue[50],
                    ),
                    likeBuilder: (isLiked) {
                      return Icon(
                        Icons.thumb_up,
                        color: isLiked ? Colors.blue : Colors.grey,
                        size: 15,
                      );
                    },
                  )
                : Container()
          ],
        )
      ],
    );
  }

  openBottomSheet(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return showStopper(
        context: context,
        stops: [0.5 * height, height],
        builder: (context, scrollController, scrollPhysics, stop) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.grey, blurRadius: 6),
                ]),
            child: ListView(
              controller: scrollController,
              physics: scrollPhysics,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: UserCommentWidget(
                    showLikeButton: false,
                    showReplyButton: false,
                    comment: comment,
                  ),
                ),
                CommentBoxWidget(),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    "Comments..",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(height: 20),
                  itemCount: comment.replies.length,
                  padding: const EdgeInsets.all(15.0),
                  itemBuilder: (BuildContext context, int index) =>
                      UserCommentWidget(
                          comment: comment.replies[index],
                          showReplyButton: false,
                          showLikeButton: true),
                ),
              ],
            ),
          );
        });
  }
}
