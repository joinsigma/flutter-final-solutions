import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_app/ui/authentication/authentication_screen.dart';
import 'package:travel_app/ui/edit_profile/edit_profile_screen.dart';
import 'package:travel_app/ui/profile/profile_bloc.dart';
import 'package:travel_app/ui/profile/widgets/profile_card.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileBloc _profileBloc;
  final profileImg =
      "https://media.formula1.com/content/dam/fom-website/drivers/2023Drivers/verstappen.jpg.img.640.medium.jpg/1677069646195.jpg";
  XFile? selectedImage;
  @override
  void initState() {
    _profileBloc = kiwi.KiwiContainer().resolve<ProfileBloc>();
    _profileBloc.add(LoadUserDetail());
    super.initState();
  }

  @override
  void dispose() {
    _profileBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _profileBloc,
      child: SafeArea(
        child:
            BlocConsumer<ProfileBloc, ProfileState>(listener: (context, state) {
          if (state is LoggedOut) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const AuthenticationScreen(),
              ),
            );
          }
        }, builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProfileLoadSuccess) {
            return Column(
              children: [
                Row(
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfileScreen(
                                      name: state.userDetail.name,
                                      email: state.userDetail.email,
                                      address: state.userDetail.address,
                                      mobileNum: state.userDetail.mobileNum)));
                        },
                        child: const Text('Edit'),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Stack(
                          children: [
                            state.selectedProfileImage != null
                                ? Container(
                                    width: 100.0,
                                    height: 150.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(
                                              state.selectedProfileImage!)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100.0)),
                                      color: Colors.white,
                                    ),
                                  )
                                : state.userDetail.imageUrl == ""
                                    ? const CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 50.0,
                                        backgroundImage:
                                            AssetImage("asset/user.png"),
                                      )
                                    : CircleAvatar(
                                        radius: 50.0,
                                        backgroundImage: NetworkImage(
                                            state.userDetail.imageUrl),
                                      ),
                            Align(
                              alignment: AlignmentDirectional.bottomEnd,
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.orange,
                                    shape: BoxShape.circle),
                                child: GestureDetector(
                                  onTap: () {
                                    ///Trigger profile image selection
                                    _selectUserProfileImage();

                                    ///Todo: Trigger bottom sheet
                                    // showDialog(
                                    //     context: context,
                                    //     builder: (context) {
                                    //
                                    //       return AlertDialog(
                                    //         content: CircleAvatar(
                                    //           radius: 50.0,
                                    //           backgroundImage:
                                    //               // NetworkImage(profileImg),
                                    //               FileImage(File(selectedImage!.path)),
                                    //         ),
                                    //         title: Text(
                                    //             'Change profile picture ?'),
                                    //         actions: [
                                    //           Text('Yes'),
                                    //           SizedBox(
                                    //             width: 10.0,
                                    //           ),
                                    //           Text('No')
                                    //         ],
                                    //       );
                                    //     });
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: ProfileCard(
                        title: 'Trips',
                        count: state.userDetail.numTrips.toString(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: ProfileCard(
                        title: 'Likes',
                        count: state.userDetail.numLikes.toString(),
                      ),
                    ),
                  ],
                ),
                ListTile(
                  title: const Text('Name'),
                  subtitle: Text(state.userDetail.name),
                ),
                const Divider(),
                ListTile(
                  title: const Text('Email'),
                  subtitle: Text(state.userDetail.email),
                ),
                const Divider(),
                ListTile(
                  title: const Text('Mobile No'),
                  subtitle: Text(state.userDetail.mobileNum),
                ),
                const Divider(),
                ListTile(
                  title: const Text('Address'),
                  subtitle: state.userDetail.address == ""
                      ? const Text("NA")
                      : Text(state.userDetail.address),
                ),
                state.isSaveProfileImgActive
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                _profileBloc.add(SaveNewImage());
                              },
                              child: const Text(
                                'Save New Image',
                                style: TextStyle(color: Colors.white),
                              )),
                          const SizedBox(
                            width: 50,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                _profileBloc.add(CancelNewImage());
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: Colors.white),
                              )),
                        ],
                      )
                    : SizedBox(
                        width: 150,
                        child: ElevatedButton(
                            onPressed: () {
                              _profileBloc.add(TriggerLogout());
                            },
                            child: const Text(
                              'Logout',
                              style: TextStyle(color: Colors.white),
                            )),
                      )
              ],
            );
          } else {
            return const Center(
              child: Text('Error profile load'),
            );
          }
        }),
      ),
    );
  }

  ///Helpers
  Future _selectUserProfileImage() async {
    XFile? selectedImage;

    selectedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
    );
    if (selectedImage == null) return;

    ///Add event to bloc
    _profileBloc.add(
      NewProfileImageSelected(
        newProfileImage: File(selectedImage!.path),
      ),
    );
  }
// Future selectUserProfileImage({
  //   required ImageSource imageSource,
  // }) async {
  //   // XFile? selectedImage;
  //
  //   // Gallery image
  //   if (imageSource == ImageSource.gallery) {
  //     selectedImage = await ImagePicker().pickImage(
  //       source: ImageSource.gallery,
  //       imageQuality: 25,
  //     );
  //     if (selectedImage == null) return;
  //   } else if (imageSource == ImageSource.camera) {
  //     // Camera image
  //     selectedImage = await ImagePicker().pickImage(
  //       source: ImageSource.camera,
  //       imageQuality: 25,
  //     );
  //     if (selectedImage == null) return;
  //   }
  //
  //   File? f =File(selectedImage!.path);
  //
  //   _profileBloc.add(
  //     NewProfileImageSelected(
  //       newProfileImage: File(selectedImage!.path),
  //     ),
  //   );
  //
  //   ///Todo: Remove this since BloC is used.
  //   // setState(() {
  //   //   userProfileImage = File(selectedImage!.path);
  //   //   isSaveChangesButtonEnabled = true;
  //   // });
  // }
}
