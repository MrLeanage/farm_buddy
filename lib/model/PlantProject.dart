 import 'package:flutter/foundation.dart';
class PlantingProject{
  final String pID;
  final String pName;
  final String pStartDate;
  final String pEndDate;
  final String createdAt;
  final String updatedAt;

  PlantingProject({
    required this.pID,
    required this.pName,
    required this.pStartDate,
    required this.pEndDate,
    required this.createdAt,
    required this.updatedAt,

  });

  Map<String, dynamic> toMap(){
    return{
      'pID': pID,
      'pName' : pName,
      'pStartDate' : pStartDate,
      'pEndDate' : pEndDate,
      'createdAt' : createdAt,
      'updatedAt' : updatedAt ,
    };
  }

}