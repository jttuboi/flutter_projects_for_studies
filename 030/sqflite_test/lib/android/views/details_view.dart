import 'package:flutter/material.dart';
import 'package:sqflite_test/android/views/address_view.dart';
import 'package:sqflite_test/android/views/crop_picture_view.dart';
import 'package:sqflite_test/android/views/editor_contact_view.dart';
import 'package:sqflite_test/android/views/home_view.dart';
import 'package:sqflite_test/android/views/loading_view.dart';
import 'package:sqflite_test/android/views/take_picture_view.dart';
import 'package:sqflite_test/models/contact_model.dart';
import 'package:sqflite_test/repositories/contact_repository.dart';
import 'package:sqflite_test/shared/widgets/contact_details_description.dart';
import 'package:sqflite_test/shared/widgets/contact_details_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:camera/camera.dart';

class DetailsView extends StatefulWidget {
  final int id;

  DetailsView({
    required this.id,
  });

  @override
  _DetailsViewState createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  final _repository = ContactRepository();

  onDelete() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(title: Text("Exclusão de Contato"), content: Text("Deseja excluir este contato?"), actions: [
          FlatButton(
            child: Text("Cancelar"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text("Excluir"),
            onPressed: delete,
          ),
        ]);
      },
    );
  }

  delete() {
    _repository.delete(widget.id).then((_) {
      onSuccess();
    }).catchError((err) {
      onError(err);
    });
  }

  onSuccess() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeView(),
      ),
    );
  }

  onError(err) {
    print(err);
  }

  takePicture() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TakePictureView(
          camera: firstCamera,
        ),
      ),
    ).then((imagePath) {
      cropPicture(imagePath);
    });
  }

  cropPicture(path) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CropPictureView(
          path: path,
        ),
      ),
    ).then((imagePath) {
      updateImage(imagePath);
    });
  }

  updateImage(path) async {
    _repository.updateImage(widget.id, path).then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _repository.getContact(widget.id),
      builder: (ctx, snp) {
        if (snp.hasData) {
          ContactModel contact = snp.data! as ContactModel;
          return page(context, contact);
        } else {
          return LoadingView();
        }
      },
    );
  }

  Widget page(BuildContext context, ContactModel model) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contato"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
            width: double.infinity,
          ),
          ContactDetailsImage(
            image: model.image,
          ),
          SizedBox(
            height: 10,
          ),
          ContactDetailsDescription(
            name: model.name,
            email: model.email,
            phone: model.phone,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  launch("tel://${model.phone}");
                },
                color: Theme.of(context).primaryColor,
                shape: CircleBorder(
                  side: BorderSide.none,
                ),
                child: Icon(
                  Icons.phone,
                  color: Theme.of(context).accentColor,
                ),
              ),
              FlatButton(
                onPressed: () {
                  launch("mailto://${model.email}");
                },
                color: Theme.of(context).primaryColor,
                shape: CircleBorder(
                  side: BorderSide.none,
                ),
                child: Icon(
                  Icons.email,
                  color: Theme.of(context).accentColor,
                ),
              ),
              FlatButton(
                onPressed: takePicture,
                color: Theme.of(context).primaryColor,
                shape: CircleBorder(
                  side: BorderSide.none,
                ),
                child: Icon(
                  Icons.camera_enhance,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          ListTile(
            title: Text(
              "Endereço",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  model.addressLine1 ?? "Nenhum endereço cadastrado",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  model.addressLine2 ?? "",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            isThreeLine: true,
            trailing: FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddressView(
                      model: model,
                    ),
                  ),
                );
              },
              child: Icon(
                Icons.pin_drop,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Container(
              width: double.infinity,
              height: 50,
              color: Color(0xFFFF0000),
              child: FlatButton(
                child: Text(
                  "Excluir Contato",
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                  ),
                ),
                onPressed: onDelete,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditorContactView(
                model: model,
              ),
            ),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.edit,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}
