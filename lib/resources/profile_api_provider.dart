import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/REST/app_exceptions.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/photo_model.dart';
import 'package:coupled/models/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileApiProvider {
  Future<ProfileResponse> getUserProfile(String otherUserId) async {
    print('profile api calling-------------');
    try {
      ProfileResponse profile = ProfileResponse(
          usersBasicDetails: UsersBasicDetails(),
          mom: Mom(),
          info: Info(maritalStatus: BaseSettings(options: [])),
          preference: Preference(complexion: BaseSettings(options: [])),
          officialDocuments: OfficialDocuments(),
          address: Address(),
          photoData: [],
          photos: [],
          family: Family(
              fatherOccupationStatus: BaseSettings(options: []),
              cast: BaseSettings(options: []),
              familyType: BaseSettings(options: []),
              familyValues: BaseSettings(options: []),
              gothram: BaseSettings(options: []),
              motherOccupationStatus: BaseSettings(options: []),
              religion: BaseSettings(options: []),
              subcast: BaseSettings(options: [])),
          educationJob: EducationJob(
              educationBranch: BaseSettings(options: []),
              experience: BaseSettings(options: []),
              highestEducation: BaseSettings(options: []),
              incomeRange: BaseSettings(options: []),
              industry: BaseSettings(options: []),
              profession: BaseSettings(options: [])),
          membership: Membership.fromMap({}),
          userCoupling: [],
          dp: Dp(
              photoName: '',
              imageType: BaseSettings(options: []),
              imageTaken: BaseSettings(options: []),
              userDetail:
                  UserDetail(membership: Membership(paidMember: false))),
          blockMe: Mom(),
          reportMe: Mom(),
          freeCoupling: [],
          recomendCause: [],
          shortlistByMe: Mom(),
          shortlistMe: Mom(),
          photoModel: PhotoModel(),
          currentCsStatistics: CurrentCsStatistics(),
          siblings: []);
      Map<String, dynamic> res = await RestAPI()
          .get(Uri.encodeFull("${APis.getProfile}/$otherUserId"));

      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (otherUserId != '') {
        await prefs.setString('user_gender', res["response"]['gender']);
      }
      print('..Otyher........${res["response"]}');
      profile = ProfileResponse.fromMap(res["response"]);

      return profile;
    } on RestException catch (e) {
      throw (e.message);
    }
  }
}
