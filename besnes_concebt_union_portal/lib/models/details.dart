class Details {
  int ser;
  String title;
  String descriptions;

  Details({this.ser, this.title, this.descriptions});

  Details.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    title = json['title'];
    descriptions = json['descriptions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['title'] = this.title;
    data['descriptions'] = this.descriptions;
    return data;
  }
}
