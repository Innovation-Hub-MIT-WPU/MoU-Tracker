class MOU {
  final String mouId;
  final String docName;
  final String tenure;
  final String authName;
  final String authDesignation;
  final String spocName;
  final String spocNo;
  final String spocDesignation;
  final String companyName;
  final String companyAddress;
  final String companyEmployees;
  final String companyDomain;
  final String companyTurnOver;
  final String companyWebsite;
  final String description;
  final String dueDate;
  final String createdDate;
  final int appLvl;
  final bool isApproved;
  final DateTime createdOn;
  final DateTime due;

  MOU({
    required this.createdOn,
    required this.due,
    required this.tenure,
    required this.authDesignation,
    required this.companyAddress,
    required this.companyEmployees,
    required this.companyDomain,
    required this.companyTurnOver,
    required this.mouId,
    required this.docName,
    required this.authName,
    required this.spocName,
    required this.spocNo,
    required this.spocDesignation,
    required this.companyName,
    required this.companyWebsite,
    required this.description,
    required this.isApproved,
    required this.appLvl,
    required this.dueDate,
    required this.createdDate,
  });
}
