import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_list/models/user.dart';
import 'package:user_list/provider/users.dart';

class UserForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {"id": ""};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Form"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              bool isValid = _form.currentState!.validate();
              if (isValid) {
                _form.currentState!.save();
                Provider.of<Users>(context, listen: false).put(User(
                  id: _formData["id"]!,
                  name: _formData["name"]!,
                  email: _formData["email"]!,
                  avatarUrl: _formData["avatarUrl"]!,
                ));
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "name can't be empty";
                  }
                  if (value.trim().length < 3) {
                    return "name is too small";
                  }
                  return null;
                },
                onSaved: (value) => _formData["name"] = value!,
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "e-mail can't be empty";
                  }
                  return null;
                },
                onSaved: (value) => _formData["email"] = value!,
                decoration: InputDecoration(labelText: "E-mail"),
              ),
              TextFormField(
                keyboardType: TextInputType.url,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "url can't be empty";
                  }
                  return null;
                },
                onSaved: (value) => _formData["avatarUrl"] = value!,
                decoration: InputDecoration(labelText: "Avatar URL"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
