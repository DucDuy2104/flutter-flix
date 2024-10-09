class Review {
  final String? content;
  final String? createdAt;
  final int? id;
  final Author? author;

  Review({this.content, this.createdAt, this.id, this.author});

  factory Review.fromJson(Map<String, dynamic> json) {
    Author author = Author.fromJson(json['author_details']);
    return Review(
      content: json['content'],
      // id: json['id'],
      createdAt: json['created_at'],
      author: author
    );
  }
}

class Author {
  final String? username;
  final double? rating;
  final String? avatarPath;

  Author({this.username, this.rating, this.avatarPath});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      username: json['username'],
      avatarPath: json['avatar_path'],
      rating: json['rating']
    );
  }
}