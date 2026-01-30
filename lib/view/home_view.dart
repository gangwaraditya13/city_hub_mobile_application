import 'package:city_hub/data/response/status.dart';
import 'package:city_hub/model_view/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homeview extends StatefulWidget {
  const Homeview({super.key});

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  late HomeViewModel _homeViewModel;

  @override
  void initState() {
    _homeViewModel = context.read<HomeViewModel>();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().getUserDetail();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Expanded(
            flex: 2,
            child: Consumer<HomeViewModel>(
              builder: (context, value, child) {
                if (value.apiUserDetailResponse == null ||
                    value.apiUserDetailResponse!.status == Status.LOADING) {
                  return CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    child: Text("......"),
                  );
                }

                if (value.apiUserDetailResponse!.status == Status.ERROR) {
                  return const Text("Error loading user");
                }

                final user = value.apiUserDetailResponse!.data;

                return Row(
                  crossAxisAlignment: .center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 18),
                      child: CircleAvatar(
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.secondary,
                        radius: MediaQuery.of(context).size.height / 40,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.city ?? "No City",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          user?.roll?.join(", ") ?? "No Role",
                          style: const TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "CITY HUB",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: MediaQuery.of(context).size.height / 33,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
        actionsPadding: EdgeInsets.only(right: 10, left: 10),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await context.read<HomeViewModel>().reloadHome();
          },
          child: ListView(
            padding: const EdgeInsets.all(8.0),
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: Consumer<HomeViewModel>(
                  builder: (context, value, child) {
                    final updatesResponse = value.apiCityUpdatesResponse;

                    if (updatesResponse == null ||
                        updatesResponse.status == Status.LOADING) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (updatesResponse.status == Status.ERROR) {
                      return const Center(child: Text("Update is not loaded"));
                    }

                    final updates = updatesResponse.data?.cityUpdates ?? [];
                    if (updates.isEmpty) {
                      return const Center(child: Text("No updates available"));
                    }
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: updates.length,
                      itemBuilder: (context, index) {
                        final image = value
                            .apiCityUpdatesResponse!
                            .data!
                            .cityUpdates![index]
                            .profilePhotoURL;
                        final displayImage = (image == null || image.isEmpty)
                            ? "https://i.ytimg.com/vi/q7-bdajnYwc/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLA_LT7nvi7t9hvNaVhK3cqpk8W6bw"
                            : image;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.92,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: NetworkImage(displayImage),
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.low,
                                opacity: 0.35
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: .end,
                                crossAxisAlignment: .start,
                                children: [
                                  Row(
                                    mainAxisAlignment: .spaceBetween,
                                    children: [
                                      Text(
                                        "${updates[index].title}",
                                        style: TextStyle(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.surface,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.040,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "${updates[index].createdDate}",
                                        style: TextStyle(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.surface,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.040,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${updates[index].description}",
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.surface,
                                      fontWeight: FontWeight.w400,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                          0.040,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: MediaQuery.of(context).size.height * 0.20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: MediaQuery.of(context).size.height * 0.32,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Consumer<HomeViewModel>(builder: (context, value, child) {
                  final userDetail = value.apiUserDetailResponse;
                  if(userDetail == null || userDetail.status == Status.LOADING){
                    return Center(child: CircularProgressIndicator());
                  }
                  if(userDetail.status == Status.ERROR){
                    return Center(child: Text("NOT FOUND"));
                  }
                  final complaint = userDetail.data?.complaintList ?? [];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: .end,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.30,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              final image = complaint[index].profilePhotoURL;
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
                                    crossAxisAlignment: .start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: .spaceBetween,
                                        children: [
                                          Text("${complaint[index].complaintCategory}",style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                                          Row(
                                            children: [
                                              Text("${complaint[index].complaintStatus}",style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 5.0),
                                                child: Container(
                                                  height: 15,
                                                  width: 15,
                                                  decoration: BoxDecoration(
                                                    color: complaint[index].complaintStatus.toString() == "PENDING"?Colors.red:Colors.green,
                                                    borderRadius: BorderRadius.circular(50),
                                                    ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: MediaQuery.of(context).size.height * 0.12,
                                              width: MediaQuery.of(context).size.width * 0.4,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12),
                                                image: DecorationImage(image: NetworkImage(displayImage),fit: BoxFit.cover),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment: .start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 8.0),
                                                child: Text("${complaint[index].complaintTitle}",style: TextStyle(color: Theme.of(context).colorScheme.primary, decorationStyle: TextDecorationStyle.wavy),),
                                              ),
                                              Text("To, ${complaint[index].complaintToName}",style: TextStyle(color: Theme.of(context).colorScheme.primary),)
                                            ],
                                          )
                                        ],
                                      ),
                                      Text("${complaint[index].complaintDescription}",style: TextStyle(color: Theme.of(context).colorScheme.primary),)
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: complaint.length,
                            scrollDirection: Axis.vertical,
                          ),
                        ),
                      ],
                    ),
                  );
                },),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
