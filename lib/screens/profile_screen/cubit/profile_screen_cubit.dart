import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_project/models/user_model.dart';
import 'package:user_project/screens/profile_screen/cubit/profile_screen_states.dart';
import 'package:user_project/shared/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProfileScreenCubit extends Cubit<ProfileScreenState> {
  IconData iconData = Icons.edit;
  String? uid;
  File? profileImage;
  UserModel ? userModel;
  File? coverImage;
  var picker = ImagePicker();

  final User? _user = FirebaseAuth.instance.currentUser;

  var isBottomSheetShowing = false;

  ProfileScreenCubit() : super(InitialState());

  static ProfileScreenCubit get(context) => BlocProvider.of(context);

  void changeBottomSheetState({required bool isShow, required IconData icon}) {
    isBottomSheetShowing = isShow;
    this.iconData = icon;
    emit(ChangeBottomSheetState());
  }

  Future getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      uploadProfileImage();
      emit(SelectImageStateSucess());
    } else {
      print('No Image Selected');
      emit(SelectImageStateFaluire());
    }
  }

  void uploadProfileImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
        '${USERS}/profile/${Uri
            .file(profileImage!.path)
            .pathSegments
            .last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        FirebaseFirestore.instance
            .collection(USERS)
            .doc(_user!.uid)
            .update({'image': value});
      });
    }).catchError((error) {
      print(error.toString());
    });
  }

  Future getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      _uploadCoverImage();
      emit(SelectImageCoverStateSucess());
    } else {
      print('No Image Selected');
      emit(SelectImageCoverStateFaluire());
    }
  }
  void _uploadCoverImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('${USERS}/cover/${Uri
        .file(coverImage!.path)
        .pathSegments
        .last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        FirebaseFirestore.instance
            .collection(USERS)
            .doc(_user!.uid)
            .update({'cover': value});
      });
    }).catchError((error) {
      print(error.toString());
    });
  }

  Future updateUserInfo(Map<String, dynamic> map) async {
    await FirebaseFirestore.instance
        .collection(USERS)
        .doc(_user!.uid)
        .update(map).then((value){
      getUserInfo();
    });
  }
  void signOut(){
    FirebaseAuth.instance.signOut();
  }
  void getUserInfo() {
    FirebaseFirestore.instance
        .collection(USERS)
        .doc(_user!.uid)
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(GetUserMainInfoSuccess());
    }).catchError((error) {
      emit(GetUserMainInfoFailure());
    });
  }
}
