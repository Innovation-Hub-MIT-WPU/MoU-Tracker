class MOU {
  final int amount;
  final String docName;
  final String authName;
  final String description;
  final int day;
  final String month;
  final int year;
  final int index;
  bool isApproved;

  MOU({
    required this.docName,
    required this.authName,
    required this.amount,
    required this.description,
    required this.day,
    required this.month,
    required this.year,
    required this.index,
    required this.isApproved,
  });

  // String title;
  // String desc;
  // int day;
  // String month;
  // int year;
  // int amount;
  // MOU(
  //     {required this.title,
  //     required this.desc,
  //     required this.day,
  //     required this.month,
  //     required this.year,
  //     required this.amount});
}
