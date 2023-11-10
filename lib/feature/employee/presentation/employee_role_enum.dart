enum EmployeeRole {
  none(id: '0', label: ''),
  productDesigner(id: '1', label: 'Product Designer'),
  flutterDeveloper(id: '2', label: 'Flutter Developer'),
  qATester(id: '3', label: 'QA Tester'),
  productOwner(id: '4', label: 'Product Owner');

  const EmployeeRole({required this.id, required this.label});

  factory EmployeeRole.fromId(String id) =>
      values.firstWhere((e) => e.id == id, orElse: () => none);

  static List<EmployeeRole> get forUi =>
      [productDesigner, flutterDeveloper, qATester, productOwner];

  final String id;
  final String label;
}
