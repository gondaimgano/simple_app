class CommentItem {
  String _comment;
  String _key;
  String _dateCreated;
  String _username;

  CommentItem(
      {String comment, String key, String dateCreated, String username}) {
    this._comment = comment;
    this._key = key;
    this._dateCreated = dateCreated;
    this._username = username;
  }

  String get comment => _comment;
  set comment(String comment) => _comment = comment;
  String get key => _key;
  set key(String key) => _key = key;
  String get dateCreated => _dateCreated;
  set dateCreated(String dateCreated) => _dateCreated = dateCreated;
  String get username => _username;
  set username(String username) => _username = username;

  CommentItem.fromJson(Map<String, dynamic> json) {
    _comment = json['comment'];
    _key = json['key'];
    _dateCreated = json['date_created'];
    _username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment'] = this._comment;
    data['key'] = this._key;
    data['date_created'] = this._dateCreated;
    data['username'] = this._username;
    return data;
  }
}
