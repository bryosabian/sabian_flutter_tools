class TestSubject {
  String name;
  String description;
  int ID;

  TestSubject(this.name, this.description, this.ID);

  TestSubject.name(this.name, {this.description = "", this.ID = 0});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestSubject &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}
