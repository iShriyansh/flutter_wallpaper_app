
import 'package:get/get.dart';

class RestHelper extends GetConnect{
   Future<Response> fetch(String url, headers) => get(url, headers:  headers);
}