import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:monogram/Toast/errorToast.dart';

class Addpost extends StatefulWidget {
  const Addpost({super.key});

  @override
  State<Addpost> createState() => _AddpostState();
}

class _AddpostState extends State<Addpost> {
  final titleController = TextEditingController();
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Posts');
  final auth = FirebaseAuth.instance;
  
  File? _image;
  final picker = ImagePicker();
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  Future getGalleryImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("no image picked");
      }
    });
  }

  void uploadPost() async {
    if (titleController.text.isEmpty && _image == null) {
      Errortoast().showToast("Please enter text or select an image");
      return;
    }

    setState(() {
      loading = true;
    });

    String id = DateTime.now().millisecondsSinceEpoch.toString();
    String? imageUrl;

    try {
      if (_image != null) {
        firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('/monogram/' + id);
        firebase_storage.UploadTask uploadTask = ref.putFile(_image!.absolute);
        await Future.value(uploadTask);
        imageUrl = await ref.getDownloadURL();
      }

      await databaseRef.child(id).set({
        'id': id,
        'title': titleController.text.toString(),
        'email': auth.currentUser?.email.toString(),
        'uid': auth.currentUser?.uid.toString(),
        'time': id,
        'postImage': imageUrl ?? "",
      });

      setState(() {
        loading = false;
      });
      Errortoast().SuccessToast("Post Uploaded Successfully");
      Navigator.pop(context);
    } catch (e) {
      setState(() {
        loading = false;
      });
      Errortoast().showToast(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color primaryColor = Colors.blueAccent;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Create Post",
          style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: ElevatedButton(
              onPressed: loading ? null : uploadPost,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 0,
              ),
              child: loading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Text("Post", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (loading) const LinearProgressIndicator(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage("images/google.png"),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          auth.currentUser?.email?.split('@')[0] ?? "User",
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: titleController,
                          maxLines: null,
                          style: GoogleFonts.roboto(fontSize: 18),
                          decoration: InputDecoration(
                            hintText: "What's on your mind?",
                            hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 18),
                            border: InputBorder.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Image Preview
            if (_image != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Stack(
                  children: [
                    Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: FileImage(_image!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _image = null;
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.black.withOpacity(0.5),
                          child: const Icon(Icons.close, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            const Divider(),
            ListTile(
              leading: const Icon(Icons.image, color: Colors.green),
              title: const Text("Photo/Video"),
              onTap: getGalleryImage,
            ),
            const Divider(height: 1, indent: 70),
            ListTile(
              leading: const Icon(Icons.location_on, color: Colors.red),
              title: const Text("Add Location"),
              onTap: () {},
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
