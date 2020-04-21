//Use these objects for saving your data (either taken from server or posting to
//Also create other models that you need to work with. Models should be the same as models in database

class Customer {

  final String FullName;
  final String Username;
  final String Email;
  final String Address;
  final Int MobileNo;

  Customer({
    this.FullName,
    this.Username,
    this.Email,
    this.Address,
    this.MobileNo
  });

  //returns Customer object made from JSON object
  factory Customer.fromJson(Map<String, dynamic> data) {

    return Customer(

      FullName : data['FullName'],
      UserName : data['Username'],
      Email    : data['Email'],
      Address  : data['Address'],
      MobileNo : data['MobileNo']

    );

  }

  //returns a JSON object of Customer object
  Map<String, dynamic> JSON() {

    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['FullName'] = this.FullName;
    data['UserName'] = this.Username;
    data['Email']    = this.Email;
    data['Address']  = this.Address;
    data['MobileNo'] = this.MobileNo;

    return data;
  }

}
