class DataModel {
  final String title;
  final String imageName;
  DataModel(
    this.title,
    this.imageName,
  );
}

List<DataModel> eList = [
  DataModel("Happy", "assets/Happy.png"),
  DataModel("Sad", "assets/Sad.png"),
  DataModel("Poker", "assets/Poker.png"),
  DataModel("Angry", "assets/Angry.png"),
];

List<DataModel> sList = [
  DataModel("Hello", "assets/helloSign.jpg"),
  DataModel("I Love You", "assets/ilySign.jpg"),
  DataModel("Yes", "assets/yesSign.jpg"),
  DataModel("No", "assets/noSign.jpg"),
];
