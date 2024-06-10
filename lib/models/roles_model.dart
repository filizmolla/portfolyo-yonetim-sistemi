class Role {
  String? name;
  int? maxSlot;
  int? occupied;
  int? available;
  int? id;

  Role(
      {this.name, this.maxSlot, this.occupied, this.available, this.id});

  Role.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    maxSlot = json['maxSlot'];
    occupied = json['occupied'];
    available = json['available'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['maxSlot'] = this.maxSlot;
    data['occupied'] = this.occupied;
    data['available'] = this.available;
    data['id'] = this.id;
    return data;
  }
}
