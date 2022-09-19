class MOU {
  final String mouId;
  final String docName;
  final String authName;
  // final String spocName;
  final String companyName;
  // final String companyWebsite;
  final String description;
  final String dueDate;
  final int appLvl;
  final bool isApproved;

  MOU(
      {required this.mouId,
      required this.docName,
      required this.authName,
      // required this.spocName,
      required this.companyName,
      // required this.companyWebsite,
      required this.description,
      required this.isApproved,
      required this.appLvl,
      required this.dueDate});
}
