import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PlantingProject{
  final CollectionReference _plantingProjectCollectionReference = FirebaseFirestore.instance.collection('projects');
}
Future createProject() async{

}