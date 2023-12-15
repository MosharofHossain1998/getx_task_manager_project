
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:module_12/ui/controllers/authentication_controller.dart';
import 'package:module_12/ui/controllers/photo_picker_controller.dart';
import 'package:module_12/ui/controllers/update_profile_controller.dart';
import 'package:module_12/ui/screen/main_buttom_nav_screen.dart';
import 'package:module_12/ui/widgets/body_background.dart';
import 'package:module_12/ui/widgets/profile_summary_card.dart';
import 'package:module_12/ui/widgets/snackbar_massage.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _phoneNumberTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _profileUpdateInProgress = false;

  UpdateProfileController updateProfileController = Get.find<UpdateProfileController>();
  AuthenticationController authenticationController = Get.find<AuthenticationController>();
  PhotoPickerController photoPickerController = Get.find<PhotoPickerController>();

  XFile? photo;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _emailTEController.text = authenticationController.user?.email ?? '';
      _firstNameTEController.text = authenticationController.user?.firstName ?? '';
      _lastNameTEController.text = authenticationController.user?.lastName ?? '';
      _phoneNumberTEController.text = authenticationController.user?.mobile ?? '';
    });
  }

  Future<void> updateProfile() async{
    final response = await updateProfileController.updateProfile(
        _emailTEController.text,
        _firstNameTEController.text,
        _lastNameTEController.text,
        _phoneNumberTEController.text,
        _phoneNumberTEController.text,
        photoPickerController.photo,
    );

    _profileUpdateInProgress = false;

    if(response){
      if(mounted){
        showSnackMassage(context, 'Profile Update Successfully');
        await Future.delayed(const Duration(seconds: 1))
            .whenComplete(() => Get.offAll(const MainButtomNavScreen()));
      }
    }
    else{
      if(mounted){
        showSnackMassage(context, 'Profile Update Failed, Please Try again');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(
              enableOnTap: false,
            ),
            Expanded(
              child: BodyBackground(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Update Profile',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),

                          const SizedBox(
                            height: 16,
                          ),
                          photoPickerField(),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: _emailTEController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              hintText: 'Email',
                            ),
                            validator: (String? value){
                              if(value!.trim().isEmpty ?? true){
                                return 'Enter Your Email';
                              }
                              else{
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: _firstNameTEController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              hintText: 'First Name',
                            ),
                            validator: (String? value){
                              if(value!.trim().isEmpty ?? true){
                                return 'Enter Your First Name';
                              }
                              else{
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: _lastNameTEController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              hintText: 'Last Name',
                            ),
                            validator: (String? value){
                              if(value!.trim().isEmpty ?? true){
                                return 'Enter Your Last name';
                              }
                              else{
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: _phoneNumberTEController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              hintText: 'Phone Number',
                            ),
                            validator: (String? value){
                              if(value!.trim().isEmpty ?? true){
                                return 'Enter Your Phone Number';
                              }
                              else{
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: _passwordTEController,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: const InputDecoration(
                              hintText: 'Password (Optional)',
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: GetBuilder<UpdateProfileController>(
                              builder: (updateProfileController) {
                                return Visibility(
                                  visible: updateProfileController.profileUpdateInProgress == false,
                                  replacement: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: (){
                                      if(_formKey.currentState!.validate()){
                                         updateProfile();
                                      }
                                    },
                                    child: const Icon(Icons.arrow_circle_right_outlined),
                                  ),
                                );
                              }
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container photoPickerField() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Photo',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: InkWell(
              onTap: () async{
                photoPickerController.photoPickerField(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: GetBuilder<PhotoPickerController>(
                  builder: (photoPickerController) {
                    return Visibility(
                      visible: photoPickerController.photo == null,
                      replacement: Text(photoPickerController.photo?.name ?? ''),
                      child: const Text('Select A Photo'),
                    );
                  }
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose(){
    super.dispose();
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _phoneNumberTEController.dispose();
    _passwordTEController.dispose();
  }
}
