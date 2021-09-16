import 'dart:convert';
import 'dart:io';

import 'package:farm_buddy/model/plant/Crop.dart';
import 'package:farm_buddy/model/plant/OnGoingProject.dart';
import 'package:farm_buddy/model/plant/Prediction.dart';
import 'package:farm_buddy/model/plant/Project.dart';
import 'package:farm_buddy/model/shop/Shop.dart';
import 'package:farm_buddy/services/authenticate_service.dart';
import 'package:farm_buddy/utils/custom_widgets/toastMessage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
class APIService{
  Future <List<Crop>> getViableCropData(String state) async {
    List<Crop> cropDataList = [];
    var url = Uri.parse('https://us-central1-farmbuddy-2021.cloudfunctions.net/onRequestViableCropList');
    var response = await http.post(url, body: {
    'geoLocation' : {
      'state': "western",
      'longitude': '7.086574',
      'latitude': '80.009682'
    }
    });


    if(response.statusCode == 200){
      var cropsJson = json.decode(response.body);
      for(var crop in cropsJson){
        cropDataList.add(Crop.fromJson(crop));
      }
    }else{
      // Fluttertoast.showToast(
      //     msg: "Error Occurred While Retrieving",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0
      // );
    }

    return cropDataList;
  }
  Future<List<Project>> fetchOnGoingProjectList()async{

    List<Project> projectList = <Project>[];
    AuthService authService = new AuthService();
    User user = await authService.getCurrentUser() as User;
    var url = Uri.parse('https://us-central1-farmbuddy-2021.cloudfunctions.net/onRequestUserProjectList');
    Map data = {
      "uID": user.uid
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: body
    );

    if(response.statusCode == 200){
      var projects = json.decode(response.body);

      for(var project in projects){
        projectList.add(Project.fromJson(project));
      }
    }else{
      ToastMessage.showErrorToast("Error Occurred While Retrieving");
    }
    if(projectList.isEmpty){
      ToastMessage.showErrorToast("No Records Found");
    }
    return projectList;
  }
  Future<List<Crop>> fetchViableCropList(String state) async {

    var url = Uri.parse('https://us-central1-farmbuddy-2021.cloudfunctions.net/onRequestViableCropList');

    Map data = {
      'geoLocation' : {
        'state' : state,
        'longitude' : '7.086574',
        'latitude' : '80.009682'
      }
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: body
    );

    List <Crop> cropItemList = [];
    if(response.statusCode == 200){
      var items = json.decode(response.body);
      for(var item in items){
        print(item);
        cropItemList.add(Crop.fromJson(item));
      }

    }else{
      Fluttertoast.showToast(
          msg: "Error Occurred While Retrieving",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    return cropItemList;
  }
  Future<Prediction> fetchCropWeatherPrediction() async {

    var url = Uri.parse('https://us-central1-farmbuddy-2021.cloudfunctions.net/onRequestPredictionData');

    Map data = {
      'geoLocation' : {
        'longitude' : '7.086574',
        'latitude' : '80.009682'
      }
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: body
    );

    var prediction;
    if(response.statusCode == 200){
      var item = json.decode(response.body);
      print(item);
      prediction = Prediction.fromJson(item);

    }else{
      ToastMessage.showErrorToast("Error Occurred While Retrieving");
    }
    return prediction;
  }
  Future<bool> createPlantingProject(String cropID, String projectName) async {
    AuthService authService = new AuthService();
    User user = await authService.getCurrentUser() as User;
    var url = Uri.parse('https://us-central1-farmbuddy-2021.cloudfunctions.net/onRequestToCreateProject');

    Map data = {
      "name" : projectName,
      "cropID": cropID,
      "uID": user.uid,
      "geoLocation":{
        "longitude" : "7.086574",
        "latitude" : "80.009682"
      }
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: body
    );

    if(response.statusCode == 200){
      return true;

    }else{
      ToastMessage.showErrorToast("Error Occurred While Retrieving");
      return false;
    }
  }

  Future<OngoingProject> fetchSpecificOngoingProject(String projectID)async{

    var url = Uri.parse('https://us-central1-farmbuddy-2021.cloudfunctions.net/onRequestSpecificProjectStageData');
    Map data = {
      "projectID" : projectID
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: body
    );
    var onGoingProjectData;
    if(response.statusCode == 200){
      onGoingProjectData = OngoingProject.fromJson(json.decode(response.body));

    }else{
      ToastMessage.showErrorToast("Error Occurred While Retrieving");
    }
    return onGoingProjectData;
  }

  Future<bool> updatingProjectQuestion(String projectID, String questionID) async {
    AuthService authService = new AuthService();
    var url = Uri.parse('https://us-central1-farmbuddy-2021.cloudfunctions.net/onRequestToUpdateQuestionAnswer');

    Map data = {
      "projectID" : projectID,
      "questionID" : questionID
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: body
    );

    if(response.statusCode == 200){
      return true;

    }else{
      return false;
    }
  }
  Future<List<Shop>> fetchShopList()async{

    List<Shop> shopList = [];
    var url = Uri.parse('https://us-central1-farmbuddy-2021.cloudfunctions.net/onRequestAllShopList');


    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
    );

    if(response.statusCode == 200){
      var shops = json.decode(response.body);

      for(var shop in shops){
        shopList.add(Shop.fromJson(shop));
      }
    }else{
      ToastMessage.showErrorToast("Error Occurred While Retrieving");
    }
    if(shopList.isEmpty){
      ToastMessage.showErrorToast("No Records Found");
    }
    return shopList;
  }
  Future<bool> requestToProceedToStepOne(String projectID) async {
    var url = Uri.parse('https://us-central1-farmbuddy-2021.cloudfunctions.net/onRequestToCompletePhaseOne');

    Map data = {
      "projectID" : projectID,
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: body
    );

    if(response.statusCode == 200){
      return true;

    }else{
      return false;
    }
  }
  Future<bool> requestToProceedToStepTwo(String projectID) async {
    var url = Uri.parse('https://us-central1-farmbuddy-2021.cloudfunctions.net/onRequestToCompletePhaseTwo');

    Map data = {
      "projectID" : projectID,
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: body
    );

    if(response.statusCode == 200){
      return true;

    }else{
      return false;
    }
  }
}