class Task {
  String text = "";
  DateTime date = DateTime.now();
  bool finished = false;

  Task(String text) {
    this.text = text;
    date = DateTime.now();
    finished = false;
  }
}
