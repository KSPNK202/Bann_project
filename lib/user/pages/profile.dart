import 'dart:io';
import 'package:baan_app/user/models/shared_pref.dart';
import 'package:baan_app/user/pages/login.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  // บันทึก Document ID
  Future<void> saveUserDocumentId(String documentId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_document_id', documentId);
  }

  // ดึง Document ID
  Future<String?> getUserDocumentId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_document_id');
  }

  // บันทึก Profile URL
  Future<void> saveUserProfile(String profileUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_profile', profileUrl);
  }

  // ดึง Profile URL
  Future<String?> getUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_profile');
  }
}

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? profile, name, email, phonenumber;
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    onThisLoad();
  }

  Future<void> getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage = File(image.path);
      setState(() {
        uploadItem();
      });
    }
  }

  Future<void> uploadItem() async {
    if (selectedImage != null) {
      String addId = randomAlphaNumeric(10);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("blogImages").child(addId);
      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);
      var downloadUrl = await (await task).ref.getDownloadURL();
      await SharedPreferenceHelper().saveUserProfile(downloadUrl);
      setState(() {});
    }
  }

  Future<void> getUserData() async {
    try {
      String documentId = "72o4039180"; // กำหนด Document ID ตรงนี้

      DocumentSnapshot doc = await firestore
          .collection('users')
          .doc(documentId)
          .get(); // ใช้ documentId ที่กำหนด
      if (doc.exists) {
        setState(() {
          name = doc['ชื่อ'];
          email = doc['อีเมล'];
          phonenumber = doc['หมายเลขโทรศัพท์'];
        });
      } else {
        print("Document does not exist!");
      }
    } catch (e) {
      print("Error getting user data: $e");
    }
  }

  Future<void> onThisLoad() async {
    await getUserData();
    await getthesharedpref();
  }

  Future<void> getthesharedpref() async {
    profile =
        await SharedPreferenceHelper().getUserProfile(); // แก้ไขชื่อฟังก์ชัน
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            // Header Profile
            Stack(
              children: [
                Container(
                  padding:
                      const EdgeInsets.only(top: 45.0, left: 20.0, right: 20.0),
                  height: MediaQuery.of(context).size.height / 4.3,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFCC00),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                          MediaQuery.of(context).size.width, 105.0),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 6.5),
                    child: Material(
                      elevation: 10.0,
                      borderRadius: BorderRadius.circular(60),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.asset(
                          "images/proz.png",
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 70.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "โปรไฟล์",
                        style: TextStyle(
                            fontFamily: 'kanit',
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Name
            _buildInfoTile(Icons.person, "ชื่อ", name ?? "ยังไม่มีข้อมูล"),
            const SizedBox(height: 20),
            // Email
            _buildInfoTile(Icons.email, "อีเมล", email ?? "ยังไม่มีข้อมูล"),
            const SizedBox(height: 20),
            // Phone Number
            _buildInfoTile(Icons.phone, "หมายเลขโทรศัพท์",
                phonenumber ?? "ยังไม่มีข้อมูล"),
            const SizedBox(height: 20),
            // Logout
            _buildLogoutTile(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 2.0,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.black),
              SizedBox(width: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'kanit',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600)),
                  Text(value,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'kanit',
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutTile() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 2.0,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LogIn()),
            );
          },
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(Icons.logout, color: Colors.black),
                SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("ออกจากระบบ",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'kanit',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
