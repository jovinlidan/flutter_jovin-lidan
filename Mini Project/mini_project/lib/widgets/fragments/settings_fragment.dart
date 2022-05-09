import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mini_project/model/user_model.dart';
import 'package:mini_project/view_models/file_upload_view_model.dart';
import 'package:mini_project/view_models/token_view_model.dart';
import 'package:mini_project/view_models/update_profile_picture_view_model.dart';
import 'package:mini_project/view_models/user_view_model.dart';
import 'package:mini_project/widgets/components/common/setting_tile.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class SettingsFragment extends StatefulWidget {
  const SettingsFragment({Key? key}) : super(key: key);

  @override
  State<SettingsFragment> createState() => _SettingsFragmentState();
}

class _SettingsFragmentState extends State<SettingsFragment> {
  bool isLoading = false;
  void handleLogout() async {
    await Provider.of<TokenViewModel>(context, listen: false).revokeToken();
    Navigator.pushNamed(context, '/');
  }

  void handleEditPicture() async {
    try {
      if (isLoading) return;
      setState(() {
        isLoading = true;
      });
      final picker = ImagePicker();
      final XFile? pickedImage = await picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 64,
        maxWidth: 64,
      );
      if (pickedImage != null) {
        FormData formData = FormData.fromMap({
          'file': await MultipartFile.fromFile(pickedImage.path),
        });
        final res = await Provider.of<FileUploadViewModel>(context, listen: false)
            .uploadFile(formData: formData);
        if (res.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res.message ?? "")));
          return;
        }
        final user = Provider.of<UserViewModel>(context, listen: false).user?.data;
        final UpdateProfilePictureInput input =
            UpdateProfilePictureInput(pictureUrl: res.data?.url ?? "");
        await Provider.of<UpdateProfilePictureViewModel>(context, listen: false)
            .updateProfilePicture(id: user?.sId ?? "", input: input);
        await Provider.of<UserViewModel>(context, listen: false).getMe();
      }
    } catch (e) {
      if (e is PlatformException) {
        if (e.code == "photo_access_denied") {
          openAppSettings();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? "")));
        }
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
    // final pickedImageFile = File(pickedImage!.path);
    // setState(() {
    //   imagePicked = pickedImageFile;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 40,
        ),
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  context.read<UserViewModel>().user?.data?.pictureUrl ?? "",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                isLoading
                    ? Container(
                        width: 80,
                        height: 80,
                        color: const Color.fromRGBO(0, 0, 0, 0.6),
                        child: const CircularProgressIndicator(strokeWidth: 8),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
        Center(child: TextButton(onPressed: handleEditPicture, child: const Text("Edit Picture"))),
        const SizedBox(height: 40),
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            "Settings",
            style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 40),
        SettingTile(
          text: "Logout",
          icon: Icons.logout_outlined,
          onTap: handleLogout,
        ),
      ],
    );
  }
}
