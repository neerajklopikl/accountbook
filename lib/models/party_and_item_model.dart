// Models for our data structures

class Party {
  final String id;
  final String name;
  final String? gstNumber;
  final String? address;

  Party({required this.id, required this.name, this.gstNumber, this.address});
}

class Item {
  final String id;
  final String name;
  double price;
  int quantity;

  Item({required this.id, required this.name, this.price = 0.0, this.quantity = 1});

  double get total => price * quantity;
}

// Models for Optional Details
class TransportDetails {
  String mode = 'Road';
  String? lrNumber;
  DateTime? lrDate;
  String? vehicleNumber;
}

class OtherDetails {
  String? poNumber;
  DateTime? poDate;
}

class BankDetails {
  String? bankName;
  String? accountNumber;
  String? ifscCode;
}
