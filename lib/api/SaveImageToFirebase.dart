import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:html';

saveImageToFirebase({
  required File file,
  required String Pid,
}) async {
  String downloadUrl = '';

  try {
    //String extension = file.path.split('.')[file.path.split('.').length - 1];
    Reference storageReference = FirebaseStorage.instance
        .ref('Products/')
        .child(Pid.toString() + file.name);

    UploadTask uploadTask = storageReference.putBlob(file);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

    // File uploaded successfully, you can access the download URL from taskSnapshot.ref
    downloadUrl = await taskSnapshot.ref.getDownloadURL();

    updateId(pid: Pid, url: downloadUrl);
  } catch (e) {
    print(e);
  }
  return downloadUrl;
}

updateId({required String pid, required String url}) async {
  try {
    await FirebaseFirestore.instance
        .collection('ProductsImages')
        .add({'Pid': pid, 'url': url});
  } catch (e) {}
}
