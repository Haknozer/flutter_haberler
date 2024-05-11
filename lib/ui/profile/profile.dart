import 'package:flutter/material.dart';
import 'package:flutter_haberler/product/constants/color_constants.dart';
import 'package:flutter_haberler/product/constants/icon_constants.dart';
import 'package:flutter_haberler/product/constants/string_constants.dart';
import 'package:flutter_haberler/product/widgets/appbar_widget.dart';
import 'package:flutter_haberler/product/widgets/bottom_navigation_bar_widget.dart';
import 'package:flutter_haberler/product/widgets/listtile_widget.dart';
import 'package:flutter_haberler/product/widgets/text_widgets/title_text_widget.dart';
import 'package:flutter_haberler/ui/login/login_current_user.dart';
import 'package:flutter_haberler/ui/profile/proofil_firebase.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // ignore: prefer_typing_uninitialized_variables
  bool switchController = true;
  // ignore: prefer_typing_uninitialized_variables
  var userEmail;
  @override
  void initState() {
    super.initState();
    userEmail = CurrentUser().getCurrentUserEmail();
    print(userEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: body(context),
      bottomNavigationBar: BottomNavigationBarWidget(selectedIndex: 3),
    );
  }

  SingleChildScrollView body(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleText(title: StringConstants.profileTitle),
            profilHeader(context),
            profilNotifications(context),
            ListTileWidget(leadingText: StringConstants.profileLanguage),
            ListTileWidget(leadingText: StringConstants.profileChangePassword),
            ListTileWidget(leadingText: StringConstants.profilePrivacy),
            ListTileWidget(leadingText: StringConstants.profileTermsConditions),
            profilSignOut(context)
          ],
        ),
      ),
    );
  }

  ListTile profilSignOut(BuildContext context) {
    return ListTile(
        contentPadding: const EdgeInsets.all(8),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
        tileColor: ColorConstants.grayLighter,
        leading: Text(
          StringConstants.profileSignOut,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: ColorConstants.grayDaker),
        ),
        trailing: IconButton(
            onPressed: () {
              ProfilFirebase().signOutUser();
              Navigator.popAndPushNamed(context, "/login");
            },
            icon: const Icon(Icons.exit_to_app_outlined)));
  }

  ListTile profilNotifications(BuildContext context) {
    return ListTile(
        contentPadding: const EdgeInsets.all(8),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
        tileColor: ColorConstants.grayLighter,
        leading: Text(
          StringConstants.profileNotifications,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: ColorConstants.grayDaker),
        ),
        trailing: Switch(
          activeColor: ColorConstants.purplePrimary,
          value: switchController,
          onChanged: (value) {
            setState(() {
              switchController == true ? switchController = false : switchController = true;
            });
          },
        ));
  }

  Padding profilHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            maxRadius: 40,
            backgroundImage: AssetImage(IconConstants.user.getIcon),
          ),
          const SizedBox(
            width: 15,
          ),
          Text(userEmail, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: ColorConstants.blackPrimary)),
        ],
      ),
    );
  }
}
