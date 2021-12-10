class ContactModel {
  ContactModel({
    this.id = 0,
    this.name = '',
    this.email = '',
    this.phone = '',
    this.image = 'assets/images/profile-picture.png',
    this.addressLine1 = '',
    this.addressLine2 = '',
    this.latLng = '',
  });

  int id;
  String name;
  String email;
  String phone;
  String image;
  String addressLine1;
  String addressLine2;
  String latLng;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'image': image,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'latLng': latLng,
    };
  }
}
