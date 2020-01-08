// To parse this JSON data, do
//
//     final userCommentsResponse = userCommentsResponseFromJson(jsonString);

import 'dart:convert';

UserCommentsResponse userCommentsResponseFromJson(String str) => UserCommentsResponse.fromJson(json.decode(str));

String userCommentsResponseToJson(UserCommentsResponse data) => json.encode(data.toJson());

class UserCommentsResponse {
    List<Comment> comments;

    UserCommentsResponse({
        this.comments,
    });

    factory UserCommentsResponse.fromJson(Map<String, dynamic> json) => UserCommentsResponse(
        comments: json["comments"] == null ? null : List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "comments": comments == null ? null : List<dynamic>.from(comments.map((x) => x.toJson())),
    };
}

class Comment {
    String name;
    String comment;
    String time;
    int likes;
    List<Comment> replies;

    Comment({
        this.name,
        this.comment,
        this.time,
        this.likes,
        this.replies,
    });

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        name: json["name"] == null ? null : json["name"],
        comment: json["comment"] == null ? null : json["comment"],
        time: json["time"] == null ? null : json["time"],
        likes: json["likes"] == null ? null : json["likes"],
        replies: json["replies"] == null ? null : List<Comment>.from(json["replies"].map((x) => Comment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "comment": comment == null ? null : comment,
        "time": time == null ? null : time,
        "likes": likes == null ? null : likes,
        "replies": replies == null ? null : List<dynamic>.from(replies.map((x) => x.toJson())),
    };
}
