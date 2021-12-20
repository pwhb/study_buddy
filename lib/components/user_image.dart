import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class UserImage extends StatefulWidget {
  const UserImage({Key? key, this.imageUrl,required this.uid, required this.onUrlChange}) : super(key: key);
  final String? imageUrl;
  final String uid;
  final Function onUrlChange;

  @override
  _UserImageState createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  final ImagePicker _picker = ImagePicker();
  bool _showSpinner = false;

  Future _selectPhoto() async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => BottomSheet(
        onClosing: () {},
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Camera'),
              onTap: () {
                Navigator.of(context).pop();

                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.filter),
              title: const Text('Choose a file'),
              onTap: () {
                Navigator.of(context).pop();

                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future _pickImage(ImageSource source) async {
    final pickedFile =
        await _picker.pickImage(source: source, imageQuality: 50);

    if (pickedFile == null) {
      return;
    }
    setState(() {
      _showSpinner = true;
    });
    var file = await ImageCropper.cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1));
    if (file == null) {
      return;
    }
    file = await _compressImage(file.path, 35);
    await _uploadFile(file!.path);
    setState(() {
      _showSpinner = false;
    });
  }

  Future<File?> _compressImage(String path, int quality) async {
    final newPath = p.join((await getTemporaryDirectory()).path,
        '${DateTime.now()}.${p.extension(path)}');
    final result = await FlutterImageCompress.compressAndGetFile(path, newPath,
        quality: quality);
    return result;
  }

  Future _uploadFile(String path) async {
    final String uid = widget.uid;
    final ref = FirebaseStorage.instance
        .ref()
        .child('images')
        .child('$uid${p.basename(path)}');
    final result = await ref.putFile(File(path));
    final fileUrl = await result.ref.getDownloadURL();

    widget.onUrlChange(fileUrl);
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.imageUrl == null)
            const Icon(
              Icons.image,
              size: 160.0,
              color: Colors.grey,
            ),
          if (widget.imageUrl != null)
            CircleAvatar(
                radius: 80,
                backgroundColor: Colors.white,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(120),
                  child: Image.network(widget.imageUrl!),
                )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 100),
            child: MaterialButton(
              onPressed: () => _selectPhoto(),
              child: Text(widget.imageUrl == null ? 'Upload Photo' : 'Change Photo'),
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
