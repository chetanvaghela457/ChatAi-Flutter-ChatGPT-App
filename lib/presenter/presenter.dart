import 'package:chatai/data/fetch_data.dart';
import 'package:chatai/models/response.dart';
import 'package:chatai/utils/api_helper.dart';

abstract class Contract {
  void onSuccess(Response response, EndPointItem request);

  void onFailed(String message, EndPointItem request);
}

class Presenter {
  Contract _view;
  FetchDataFromApi _repository = new FetchDataFromApi();

  Presenter(this._view);

  void postRequest(EndPointItem item, String jsonRequest,
      bool containsHeader, Map<String, String> _header) {
    _repository
        .postRequest(item, jsonRequest, containsHeader, _header)
        .then((value) => _view.onSuccess(value, item))
        .catchError((onError) => _view.onFailed(onError.toString(), item));
  }

  void getRequest(EndPointItem item) {
    _repository
        .getRequest(item)
        .then((value) => _view.onSuccess(value, item))
        .catchError((onError) => _view.onFailed(onError.toString(), item));
  }
}
