class Contact {
  final String name;
  final String phone;
  const Contact({
    required this.name,
    required this.phone,
  });
}

class ContactBook {
// A singleton is a design pattern that restricts the instantiation of a
// class to one single instance. This is useful when exactly one object is
// needed to coordinate actions across the system. The singleton pattern ensures
// that a class has only one instance and provides a global point of access to
// that instance.
  ContactBook._sharedInstance();
  static final ContactBook _shared = ContactBook._sharedInstance();
  factory ContactBook() => _shared;

  final List<Contact> _contacts = [
    const Contact(name: 'Ram', phone: '9807899877'),
    const Contact(name: 'Hari', phone: '9807899877'),
  ];
  int get length => _contacts.length;

  // Optional contact method
  // A fuction to retrive contacts with index
  Contact? contact({required int atIndex}) =>
      _contacts.length > atIndex ? _contacts[atIndex] : null;

  void addContact({required Contact contact}) {
    _contacts.add(contact);
  }

  void removeContact({required Contact contact}) {
    _contacts.remove(contact);
  }
}
