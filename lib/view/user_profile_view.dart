import 'package:city_hub/data/response/status.dart';
import 'package:city_hub/model_view/user_profile_view_model.dart';
import 'package:city_hub/model_view/user_view_model.dart';
import 'package:city_hub/view/widgets/Component/app_owner_info.dart';
import 'package:city_hub/view/widgets/Component/complaint_edit.dart';
import 'package:city_hub/view/widgets/Component/edit_user_detail.dart';
import 'package:city_hub/view/widgets/Component/edit_user_profile_pic.dart';
import 'package:city_hub/view/widgets/Component/update_password.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  late UserProfileViewModel _profileViewModel;
  late UserViewModel _userViewModel;

  ValueNotifier<bool> _valueNotifier = ValueNotifier(false);

  @override
  void initState() {
    _profileViewModel = context.read<UserProfileViewModel>();
    _userViewModel = context.read<UserViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _userViewModel.getUserDetail();
    });
    super.initState();
  }

  @override
  void dispose() {
    _valueNotifier.dispose();
    super.dispose();
  }


  Future<void> onPressesLogout() async {
    final cleared = await _profileViewModel.logout();

    if (cleared) {
      Navigator.pushReplacementNamed(context, "login_view");
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Logout failed")));
    }
  }

  Future<void> onTapDelete(String complaintId)async{
    await _userViewModel.deleteUserComplaint(complaintId);
    if( _userViewModel.apiDeleteUserComplaintResponse?.status == Status.COMPLETED) {
     await _userViewModel.reloadUserDetail();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: onPressesLogout,
            icon: Icon(
              Icons.logout,
              size: MediaQuery.of(context).size.height / 33,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
        title: Consumer<UserViewModel>(
          builder: (context, value, child) {
            final userDetail = value.apiUserModelResponse;
            if (userDetail == null || userDetail.status == Status.LOADING) {
              return Center(
                child: CircleAvatar(radius: 10, child: Text("...")),
              );
            }
            if (userDetail.status == Status.ERROR) {
              return Text("Name Not Loaded");
            }
            return Text(
              "${userDetail.data?.name}",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: MediaQuery.of(context).size.height / 33,
                fontWeight: FontWeight.w600,
              ),
            );
          },
        ),
      ),
      drawer: Drawer(
        elevation: 4,
        child: Column(
          mainAxisAlignment: .spaceBetween,
          children: [
            Column(
              children: [
                DrawerHeader(
                  child: Consumer<UserViewModel>(
                    builder: (context, value, child) {
                      final imageProfilePic =
                          value.apiUserModelResponse?.data?.profilePhotoURL;

                      final profilePic =
                          (imageProfilePic == null || imageProfilePic.isEmpty)
                          ? "https://media.istockphoto.com/id/2151669184/vector/vector-flat-illustration-in-grayscale-avatar-user-profile-person-icon-gender-neutral.jpg"
                          : imageProfilePic;

                      return CircleAvatar(
                        radius: MediaQuery.of(context).size.height * 0.067,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.secondary,
                        foregroundImage: NetworkImage(profilePic),
                      );
                    },
                  ),
                ),
                ListTile(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => UpdatePassword(),
                    );
                  },
                  title: Text("Update Password"),
                  leading: Icon(Icons.password),
                ),
                ValueListenableBuilder(
                  valueListenable: _valueNotifier,
                  builder: (context, value, child) => ListTile(
                    title: Text("Mode"),
                    leading: Icon(
                      _valueNotifier.value ? Icons.dark_mode : Icons.light_mode,
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        if (_valueNotifier.value) {
                          _valueNotifier.value = false;
                        } else {
                          _valueNotifier.value = true;
                        }
                      },
                      icon: Icon(
                        _valueNotifier.value
                            ? Icons.toggle_on
                            : Icons.toggle_off,
                        size: 45,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  ///making dialogBox
                  onTap: () {
                    Navigator.pop(context); // close drawer
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (context) => const AppOwnerInfo(),
                    );
                  },
                  title: Text("App Owner Info"),
                  leading: Icon(Icons.info),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text("Version 0.0.1"),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Consumer<UserViewModel>(
          builder: (context, value, child) {
            final userDetail = value.apiUserModelResponse;
            final userComplaint =
                value.apiUserModelResponse?.data?.complaintList ?? [];
            final imageProfilePic =
                value.apiUserModelResponse?.data?.profilePhotoURL;
            final profilePic =
                (imageProfilePic == null || imageProfilePic.isEmpty)
                ? "https://media.istockphoto.com/id/2151669184/vector/vector-flat-illustration-in-grayscale-avatar-user-profile-person-icon-gender-neutral.jpg?s=612x612&w=0&k=20&c=UEa7oHoOL30ynvmJzSCIPrwwopJdfqzBs0q69ezQoM8="
                : imageProfilePic;
            if (userDetail == null || userDetail.status == Status.LOADING) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
              );
            }
            if (userDetail.status == Status.ERROR) {
              return Center(child: Text("NOT FOUND"));
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (context) => EditUserProfilePic(),
                          );
                        },
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.height * 0.07,
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.secondary,
                          foregroundImage: NetworkImage(profilePic),
                        ),
                      ),
                      Text(
                        "${userDetail.data!.email}",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.18,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Row(
                            crossAxisAlignment: .start,
                            mainAxisAlignment: .spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: .start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      "Name : ${userDetail.data!.name}",
                                      style: TextStyle(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      "Phone : ${userDetail.data!.phone}",
                                      style: TextStyle(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      "id proof : ${userDetail.data!.idProof}",
                                      style: TextStyle(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      "City : ${userDetail.data!.city}",
                                      style: TextStyle(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                ///edit user detail
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => EditUserDetail(
                                      name: userDetail.data!.name,
                                      email: userDetail.data!.email,
                                      phone: userDetail.data!.phone,
                                      address: userDetail.data!.address,
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "address : ${userDetail.data!.address}",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: MediaQuery.of(context).size.height * 0.32,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          final image = value
                              .apiUserModelResponse!
                              .data!
                              .complaintList![index]
                              .profilePhotoURL;
                          final displayImage = (image == null || image.isEmpty)
                              ? "https://imgs.search.brave.com/7PhHNvqYShphnIgWBlWDtBp2tYpkl8Cxx5gu_QZgVWw/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9wcm9v/ZmVkLmNvbS93cC1j/b250ZW50L3VwbG9h/ZHMvMjAyMS8xMC83/LUdyYXBoaWMtV29y/ZC1DaG9pY2UtQ29t/cGxhY2VudC12cy4t/Q29tcGxhaXNhbnQu/cG5n"
                              : image;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.30,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: .end,
                                  children: [
                                    Row(
                                      mainAxisAlignment: .spaceBetween,
                                      children: [
                                        Text(
                                          "${userComplaint[index].complaintCategory}",
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "${userComplaint[index].complaintStatus}",
                                              style: TextStyle(
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 5.0,
                                              ),
                                              child: Container(
                                                height: 15,
                                                width: 15,
                                                decoration: BoxDecoration(
                                                  color:
                                                      userComplaint[index]
                                                              .complaintStatus
                                                              .toString() ==
                                                          "PENDING"
                                                      ? Colors.red
                                                      : Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                0.12,
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.4,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  displayImage,
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment: .start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 8.0,
                                              ),
                                              child: Text(
                                                "${userComplaint[index].complaintTitle}",
                                                style: TextStyle(
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.primary,
                                                  decorationStyle:
                                                      TextDecorationStyle.wavy,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "To, ${userComplaint[index].complaintToName}",
                                              style: TextStyle(
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${userComplaint[index].complaintDescription}",
                                      style: TextStyle(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment: .end,
                                        children: [
                                          Consumer<UserViewModel>(
                                            builder: (context, value, child) {

                                              if(value.apiDeleteUserComplaintResponse?.status == Status.LOADING){
                                                return const CircularProgressIndicator();
                                              }

                                              if(value.apiDeleteUserComplaintResponse?.status == Status.ERROR){
                                                return Row(
                                                  children: [
                                                    Text("Something Went wrong",style: TextStyle(color: Colors.red),),
                                                    IconButton(onPressed: () => onTapDelete(userComplaint[index].sId.toString()),
                                                        icon: Icon(
                                                          Icons.refresh,
                                                          size: MediaQuery.of(context).size.width/21,)),
                                                  ],
                                                );
                                              }

                                              return IconButton(onPressed: () => onTapDelete(userComplaint[index].sId.toString()),
                                                  icon: Icon(
                                                    Icons.delete,
                                                    size: MediaQuery.of(context).size.width/21,));
                                            },
                                          ),
                                          IconButton(
                                            ///complaint edit
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) => PostEdit(
                                                  complaintId: userComplaint[index]
                                                      .sId,
                                                  imageUrl: userComplaint[index]
                                                      .profilePhotoURL,
                                                  title: userComplaint[index]
                                                      .complaintTitle,
                                                  category: userComplaint[index]
                                                      .complaintCategory,
                                                  complaintToName:
                                                      userComplaint[index]
                                                          .complaintToName,
                                                  description: userComplaint[index]
                                                      .complaintDescription,
                                                  imageId: userComplaint[index]
                                                      .profileProductId,
                                                ),
                                              );
                                            },
                                            icon: Icon(
                                              Icons.edit,
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: userComplaint.length,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
