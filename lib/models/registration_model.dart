class Registration {
  String? id;
  String clientName;
  String phoneNumber;
  String address;
  String visitDate;

  Registration({
    this.id,
    required this.clientName,
    required this.phoneNumber,
    required this.address,
    required this.visitDate,
  });

  factory Registration.fromJson(Map<String, dynamic> json) {
    return Registration(
      id: json['id'].toString(),
      clientName: json['client_name'].toString(),
      phoneNumber: json['phone_number'].toString(),
      address: json['address'].toString(),
      visitDate: json['visit_date'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'client_name': clientName,
      'phone_number': phoneNumber,
      'address': address,
      'visit_date': visitDate,
    };
  }
}