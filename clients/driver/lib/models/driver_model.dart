// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

class DriverModel {
  File? fileIdImgBefore;
  File? fileIdImgAfter;
  String? date;
  File? personImage;

  DriverModel(
      {this.fileIdImgBefore, this.fileIdImgAfter, this.date, this.personImage});
}
