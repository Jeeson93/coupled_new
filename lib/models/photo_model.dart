import 'dart:io';

class PhotoModel {
  dynamic id;
  dynamic isProPic, isDelete = false;
  dynamic imgName;
  dynamic profileImageFile;
  dynamic networkImgUrl;
  dynamic photoType, photoTaken;
  dynamic photoTypeName, photoTakenName;
  dynamic createdAt;

  PhotoModel({
    this.id = -1,
    this.isProPic = false,
    this.imgName,
    this.profileImageFile,
    this.networkImgUrl = "",
    this.photoType = 0,
    this.photoTaken = 0,
    this.photoTypeName = "",
    this.photoTakenName = "",
    this.createdAt,
  });

  Map<String, dynamic> toJsonEdit() {
    final Map<String, dynamic> data = Map();
    data['type'] = "edit";
    data['id'] = this.id;
    data['image_type'] = this.photoType;
    data['dp_status'] = this.isProPic ? 1 : 0;
    data['image_taken'] = this.photoTaken;
    print("image_type------------------------");
    print(data);
    return data;
  }

  Map<String, dynamic> toJsonAdd({bool isFacebook = false}) {
    final Map<String, dynamic> data = Map();
    final Map<String, String> fields = Map();
    fields['type'] = "add";
    fields['from_type'] = isFacebook ? "facebook" : "gallery";
    fields['dp_status'] = this.isProPic ? "1" : "0";
    fields['image_type'] = this.photoType.toString();
    fields['image_taken'] = this.photoTaken.toString();
    data["fields"] = fields;
    data["file"] = {"photo": this.profileImageFile};
    print("image_type------------------------");
    print(data);
    return data;
  }

  String getPhotoT() {
    if (photoType == 0) {
      return 'Add Picture';
    } else {
      return photoTypeName;
    }
  }

  String getPhotoTn() {
    return photoTakenName;
  }

  @override
  String toString() {
    return 'PhotoModel{id: $id, isProPic: $isProPic, photoType: $photoType, photoTaken: $photoTaken, photoTypeName: $photoTypeName, photoTakenName: $photoTakenName}';
  }

/*, isProPic: $isProPic, isDelete: $isDelete, imgName: $imgName, imageFile: $profileImageFile, networkImgUrl: $networkImgUrl, photoT: $photoT, photoTn: $photoTn, photoT1: $photoT1, photoTn1: $photoTn1*/

/* *index: $index,*/
}
