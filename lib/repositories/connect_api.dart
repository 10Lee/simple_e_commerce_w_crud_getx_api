import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:simple_crud_getx_airsoft_api/constants.dart';
import 'package:simple_crud_getx_airsoft_api/models/_models.dart';

class ConnectApi {
  // GET PRODUCT DATA
  Future<List<AirsoftModel>> getApi(int page) async {
    String url = Constants.baseUrl + '/airsoft?page=$page';

    http.Response response = await http.get(Uri.parse(url), headers: {
      "Authorization": Constants.authorization,
    });

    if (response.body.isNotEmpty) {
      Map<String, dynamic> decoded = jsonDecode(response.body);
      List<dynamic> results = decoded['data']['results'];
      List<AirsoftModel> listOfModel =
          results.map((e) => AirsoftModel.fromMap(e)).toList();
      return listOfModel;
    } else {
      throw Exception();
    }
  }

  // GET TRANSACTION DATA
  Future<List<TransactionModel>> getTransactionApi() async {
    String url = Constants.listOfTransactionBaseUrl;

    http.Response response = await http.get(Uri.parse(url), headers: {
      "Authorization": Constants.authorization,
    });

    if (response.body.isNotEmpty) {
      Map<String, dynamic> decoded = jsonDecode(response.body);
      List<dynamic> results = decoded['data']['results'];
      List<TransactionModel> listOfModel =
          results.map((e) => TransactionModel.fromMap(e)).toList();
      return listOfModel;
    } else {
      throw Exception();
    }
  }

  // GET DETAIL TRANSACTION DATA
  Future<List<DetailTransactionModel>> getDetailTransactionApi(int id) async {
    String url = Constants.detailTransactionBaseUrl + '/${id.toString()}';

    http.Response response = await http.get(Uri.parse(url), headers: {
      "Authorization": Constants.authorization,
    });

    if (response.body.isNotEmpty) {
      Map<String, dynamic> decoded = jsonDecode(response.body);
      List<dynamic> results = decoded['data']['detail'];
      List<DetailTransactionModel> listOfModel =
          results.map((e) => DetailTransactionModel.fromMap(e)).toList();
      return listOfModel;
    } else {
      throw Exception();
    }
  }

  // UPLOAD IMAGE TO SERVER
  Future<UploadModel> uploadImage(File file, String caption) async {
    String url = Constants.baseUrl + '/test_upload';
    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.headers['Authorization'] = Constants.authorization;

    request.files.add(http.MultipartFile(
      'file',
      file.readAsBytes().asStream(),
      file.lengthSync(),
      filename: file.path.split('/').last,
    ));

    request.fields['caption'] = caption;

    http.StreamedResponse streamedResponse = await request.send();
    http.Response response = await http.Response.fromStream(streamedResponse);

    if (response.body.isNotEmpty) {
      final responseData = jsonDecode(response.body);
      return UploadModel.fromMap(responseData);
    } else {
      throw Exception();
    }
  }

  // POST NEW AIRSOFT
  Future<PostAirsoftModel> postApi(dynamic jsonData) async {
    String url = '${Constants.baseUrl}/airsoft/add';

    http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': Constants.authorization,
      },
      body: jsonData,
    );

    if (response.body.isNotEmpty) {
      final responseData = jsonDecode(response.body);
      return PostAirsoftModel.fromMap(responseData);
    } else {
      throw Exception();
    }
  }
}
