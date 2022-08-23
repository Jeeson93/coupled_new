import 'package:coupled/REST/app_exceptions.dart';

import 'package:coupled/models/common_response_model.dart';

import '../REST/RestAPI.dart';

class ShareProfileApi {
  /*Future<CommonResponseModel> shareProfile(memberShipCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _token = prefs.getString('accessToken');
    print("api called------");
//    String token2 =
//        "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjE3NTQzMTYwNTQ5YzM4ZDVlNzlmZjE4MDBkZTM2MWM4YTIzYTZiNGQ2YmM5OGI0OWU1NWRlYTA0Yzk0MWIyNjc2ZjE1MTk1NzMwOGY0MGQ3In0.eyJhdWQiOiIyIiwianRpIjoiMTc1NDMxNjA1NDljMzhkNWU3OWZmMTgwMGRlMzYxYzhhMjNhNmI0ZDZiYzk4YjQ5ZTU1ZGVhMDRjOTQxYjI2NzZmMTUxOTU3MzA4ZjQwZDciLCJpYXQiOjE1NzAxNjY5NDgsIm5iZiI6MTU3MDE2Njk0OCwiZXhwIjoxNjAxNzg5MzQ3LCJzdWIiOiI0Iiwic2NvcGVzIjpbXX0.nRTbGcRxPlDC9aFpEF_BV8zGT7wBskqfiLtNt5rAoAS3MdpwKdxr3WuVSOiApbEWQDxCqteHFkO86ygRQpeUNP18-Gpr7pMhcJm0y9V_-bZ3k5w-i2V0GE-5BiVrbRQuFpau5yEfBXrZrQzAu5hawV_bI3PLUUhbbI1F5nMmzjdId41zn0zn5Kb1ZgHWqPv7TfqZFGKFY3USolYJ6t1XMLssIk-uGUoeAW9Bb1TNQsQZShMmkNP_dbSVa-SdDOuXUpidtFCv7OjtnZunUMO1U3gC1NauRKxoopZJZCYQKvh6vUDvJKqPpxw3OLi2LjLmLxhBjWpChIbITu5efXZSg8qR3wvDzC7kclRizRy7psVc9ffp_8yQQPrvkBFFqGxlxzigkhXEssP0-4G8hNsFVI3MEaIK0G9jdbtQDcuMrI_ZD5T5CWfYbZ3A1QoCJ9x6DHScqJ1Wgdubs2Rt2RnUp9x8p6VYgfsQYe6Ms84QLNUu7XootkySv1NoNu-fz2lYmyFZSrgN7D_S12kQDHM9JheXjqXe5RvR0mBQpKs2qs3rlilhKQSkZwimAtlCwgOXoSLFPhIE2knoqttUeMJfFitZLh4zmJPqbsEF9JLCOX-dHnVPsGCKKJCzIj5euOObwVty9PiwvLqTz4skb9IiVZQOAt-jrAF9khjLpaqKMMw";
//    final response = await http.post(Uri.encodeFull('${APis.shareProfile}$memberShipCode',),

*/ /*   RestAPI().post(APis.shareProfile,params: {'membership_code': '$memberShipCode'}).then((value) {

     CommonResponseModel.fromJson(json.decode(value.body));
    });*/ /*




    RestAPI().post(APis.shareProfile, params: {'membership_code': '$memberShipCode'},).then((onValue){
      return CommonResponseModel.fromJson(json.decode(onValue));

    }).catchError((onError){


    });



   */ /* final response = await http.post(http.patch(APis.shareProfile), body: {
      'membership_code': '$memberShipCode'
    }, headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $_token"
    });*/ /*
    */ /*if (res. == 200) {
      return CommonResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception(response.body);
    }*/ /*
  }*/

  Future<CommonResponseModel> shareProfile(memberShipCode) async {
    try {
      dynamic response = await RestAPI().post<Map>(APis.shareProfile,
          params: {'membership_code': '$memberShipCode'});
      return CommonResponseModel.fromJson(response);
    } on RestException catch (e) {
      throw e;
    }
  }
}
