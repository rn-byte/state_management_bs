import 'package:flutter/material.dart';
import 'package:state_mgmt_contacts_book/models/contact_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String phone = '';

  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  @override
  void initState() {
    nameController = TextEditingController();
    phoneController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contactBook = ContactBook();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final contact = contactBook.contact(atIndex: index)!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              child: ListTile(
                title: Text(contact.name.toString()),
                subtitle: Text(contact.phone),
              ),
            ),
          );
        },
        itemCount: contactBook.length,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: _displayInputAlertDialog,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _displayInputAlertDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Add Contact',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      label: Text("Name"),
                      hintText: 'Name',
                    ),
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Add Name of Contact';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (newValue) => name = newValue.toString(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      label: Text("Phone"),
                      hintText: 'Phone',
                    ),
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Add Phone Number';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (newValue) => phone = newValue.toString(),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  color: Colors.blue,
                  onPressed: () {
                    //Navigator.pop(context);
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                MaterialButton(
                  color: Colors.blue,
                  onPressed: () {
                    final isValid = _formKey.currentState!.validate();
                    if (isValid) {
                      _formKey.currentState!.save();
                      final contact = Contact(name: name, phone: phone);
                      ContactBook().addContact(contact: contact);
                      //Navigator.pop(context);
                      Navigator.of(context).pop();
                    } else {
                      return debugPrint('Error in Saving Value');
                    }
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
