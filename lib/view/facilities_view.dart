import 'package:city_hub/data/response/status.dart';
import 'package:city_hub/model/city_info_model.dart';
import 'package:city_hub/model_view/facility_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FacilitiesView extends StatefulWidget {
  const FacilitiesView({super.key});

  @override
  State<FacilitiesView> createState() => _FacilitiesViewState();
}

class _FacilitiesViewState extends State<FacilitiesView> {

  late FacilityViewModel _facilityViewModel;

  late List<CitySchools> _school;
  late List<CityHospitals> _hospital;
  late List<CityUtilities> _utility;
  late List<String> _hospitalFacilities;



  @override
  void initState() {
    _facilityViewModel = context.read<FacilityViewModel>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FacilityViewModel>().getOwnCityInfo();
    },);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FACILITIES", style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: MediaQuery.of(context).size.height/33, fontWeight: FontWeight.w600,),),
        centerTitle: true,
      ),
      body: SafeArea(child: Column(
        children: [
          Container(
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(onPressed: (){
                        _facilityViewModel.selectViewFacility = 0;
                      }, icon: Icon(Icons.local_hospital_outlined)),
                      IconButton(onPressed: (){
                        _facilityViewModel.selectViewFacility = 1;
                      }, icon: Icon(Icons.school)),
                      IconButton(onPressed: (){
                        _facilityViewModel.selectViewFacility = 2;
                      }, icon: Icon(Icons.real_estate_agent)),
                    ],
                  ),
                ],
              )),
          Consumer<FacilityViewModel>(
            builder: (context, value, child) {

              if(value.apiOwnCityInfoResponse?.status == Status.LOADING){
                return const CircularProgressIndicator();
              }

              if(value.apiOwnCityInfoResponse?.status == Status.ERROR){
                return Center(child: Text("Not Found"));
              }

              _school = value.apiOwnCityInfoResponse!.data!.citySchools ?? [];
              _hospital = value.apiOwnCityInfoResponse!.data!.cityHospitals ?? [];
              _utility = value.apiOwnCityInfoResponse!.data!.cityUtilities ?? [];

              ///hospital
              if(value.selectViewFacility == 0){
                return Container(
                  height: MediaQuery.of(context).size.height/1.326,
                  child: ListView.builder(
                    itemBuilder:
                        (context, index) {

                          _hospitalFacilities = value.apiOwnCityInfoResponse!.data!.cityHospitals![index].hospitalFacilities ?? [];

                      return Padding(
                          padding: const EdgeInsets.only(top: 8.0,left: 8.0,right: 8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height/6,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(12)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: .spaceBetween,
                                crossAxisAlignment: .start,
                                children: [
                                  Row(
                                    mainAxisAlignment: .spaceBetween,
                                    children: [
                                      Text(_hospital[index].hospitalName.toString(),style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                                      Text(_hospital[index].hospitalContact.toString(),style: TextStyle(color: Theme.of(context).colorScheme.surface),)
                                    ],
                                  ),
                                  Text("Address:\n${_hospital[index].hospitalAddress.toString()}",style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                                  Container(
                                    height: MediaQuery.of(context).size.height/18,
                                    decoration: BoxDecoration(
                                      color:Theme.of(context).colorScheme.primary,
                                      borderRadius: BorderRadius.circular(12)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: ListView.builder(itemBuilder: (context, index) => ListTile(
                                        title: Text(_hospitalFacilities[index].toString(),style: TextStyle(color: Theme.of(context).colorScheme.surface)),
                                      ),itemCount: _hospitalFacilities.length,),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                    },
                    itemCount: _hospital.length,),
                );
              }

              ///utility
              if(value.selectViewFacility == 2){
                return Container(
                  height: MediaQuery.of(context).size.height/1.326,
                  child: ListView.builder(
                    itemBuilder:
                        (context, index) => Padding(
                          padding: const EdgeInsets.only(top: 8.0,left: 8.0,right: 8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height/7,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(12)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: .spaceBetween,
                                crossAxisAlignment: .start,
                                children: [
                                  Row(
                                    mainAxisAlignment: .spaceBetween,
                                    children: [
                                      Text(_utility[index].utilityDepartment.toString(),style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                                      Text(_utility[index].utilityContact.toString(),style: TextStyle(color: Theme.of(context).colorScheme.surface),)
                                    ],
                                  ),
                                  Text("Address:\n${_utility[index].utilityAddress.toString()}",style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                                  Text("Department Officer: ${_utility[index].utilityDepartmentOfficer.toString()}",style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                                ],
                              ),
                            ),
                          ),
                        ),
                    itemCount: _utility.length,),
                );
              }

              ///school
              return Container(
                height: MediaQuery.of(context).size.height/1.326,
                child: ListView.builder(
                  itemBuilder:
                      (context, index) => Padding(
                        padding: const EdgeInsets.only(top: 8.0,left: 8.0,right: 8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height/6,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(12)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: .spaceBetween,
                              crossAxisAlignment: .start,
                              children: [
                                Row(
                                  mainAxisAlignment: .spaceBetween,
                                  children: [
                                    Text(_school[index].schoolName.toString(),style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                                    Text(_school[index].ownership.toString(),style: TextStyle(color: Theme.of(context).colorScheme.primary),)
                                  ],
                                ),
                                Text("Address:\n${_school[index].schoolAddress.toString()}",style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                                Row(
                                  mainAxisAlignment: .spaceBetween,
                                  children: [
                                    Text(_school[index].schoolContact.toString(),style: TextStyle(color: Theme.of(context).colorScheme.surface),),
                                    Text(_school[index].category.toString(),style: TextStyle(color: Theme.of(context).colorScheme.primary),)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                  itemCount: _school.length,),
              );
            },
          ),
        ],
      )),
    );
  }
}
