import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:travel_app/ui/main_screen.dart';
import 'edit_profile_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  final String name;
  final String email;
  final String address;
  final String mobileNum;
  const EditProfileScreen(
      {Key? key,
      required this.name,
      required this.email,
      required this.mobileNum,
      required this.address})
      : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late EditProfileBloc _editProfileBloc;
  late TextEditingController _nameCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _mobileNoCtrl;
  late TextEditingController _addressCtrl;
  late GlobalKey<FormState> _editProfileFormKey;

  @override
  void initState() {
    _editProfileBloc = kiwi.KiwiContainer().resolve<EditProfileBloc>();
    _nameCtrl = TextEditingController(text: widget.name);
    _emailCtrl = TextEditingController(text: widget.email);
    _mobileNoCtrl = TextEditingController(text: widget.mobileNum);
    _addressCtrl = TextEditingController(text: widget.address);
    _editProfileFormKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _mobileNoCtrl.dispose();
    _addressCtrl.dispose();
    _editProfileBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>_editProfileBloc,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: const Text('Edit Profile'),
        ),
        body: BlocConsumer<EditProfileBloc, EditProfileState>(
            listener: (context, state) {
          if (state is EditProfileLoadSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MainScreen(
                  initialPageIndex: 3,
                ),
              ),
            );
          }
        }, builder: (context, state) {
          if (state is EditProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is EditProfileInitial) {
            return Form(
              key: _editProfileFormKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _nameCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your first name";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _mobileNoCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Mobile number',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your mobile number";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _addressCtrl,
                      maxLength: 250,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: 'Address',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your address";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_editProfileFormKey.currentState!.validate()) {
                            _editProfileBloc.add(SaveProfileDetail(
                                name: _nameCtrl.text,
                                email: _emailCtrl.text,
                                mobileNum: _mobileNoCtrl.text,
                                address: _addressCtrl.text));
                          }
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ),
              ),
            );
          } else if (State is EditProfileLoadFailed) {
            return const Center(
              child: Text('Error save profile'),
            );
          }
          return Container();
        },),
      ),
    );
  }
}
