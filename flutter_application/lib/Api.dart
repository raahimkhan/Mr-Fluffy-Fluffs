import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;

/**
 * This is the main API class that you guys should use to talk to backend server
 *
 * You can use any of GET,POST,PUT, and PATCH methods.
 */

class Api {

  final String backend_base_url = "https://mr-fluffy-fluffs.herokuapp.com";
  final Map<String,String> headers = {"Content-type":"application/json"};

  /**
   * @param Uri -- target URL
   * @return  -- returns a Map object either containing status failed or contents requested
   */
  Future<Map<String, dynamic>> get(String uri) async {

    try {

      final res = await http.get(backend_base_url + uri);

      if(res.statusCode == 200) {

        return json.decode(res.body);

      }
      else {
        print('Status code: $res.statusCode');
      }

    } catch(Error) {

      print(Error);
    }

  }

  /**
   * @param Uri -- target URL
   * @param data -- data to send
   * @return  -- returns a Map object containing status failed or passed
   */
  Future<Map<String, dynamic>> post(String uri, Map<String, dynamic> data) async {

    try {
      final res = await http.post(backend_base_url + uri, headers: headers, body: json.encode(data));

      if(res.statusCode == 200) {

        return json.decode(res.body);
      }
      else {
        print()
      }
    } catch(Error) {
      print(Error);
    }

  }

  /**
   * @param Uri -- target URL
   * @param data -- data to send
   * @return  -- returns a Map object containing status failed or passed
   */
  Future<Map<String, dynamic>> put(String uri, Map<String, dynamic> data) async {

    try {
      final res = await http.put(backend_base_url + uri, headers: headers, body: json.encode(data));

      if(res.statusCode == 200) {

        return json.decode(res.body);
      }
      else {
        print()
      }
    } catch(Error) {
      print(Error);
    }

  }

  /**
   * @param Uri -- target URL
   * @param data -- data to send
   * @return  -- returns a Map object containing status failed or passed
   */
  Future<Map<String, dynamic>> patch(String uri, Map<String, dynamic> data) async {

    try {
      final res = await http.patch(backend_base_url + uri, headers: headers, body: json.encode(data));

      if(res.statusCode == 200) {

        return json.decode(res.body);
      }
      else {
        print()
      }
    } catch(Error) {
      print(Error);
    }

  }

  /**
   * @param Uri -- target URL
   * @return  -- returns a Map object containing status failed or passed
   */
  Future<Map<String, dynamic>> delete(String uri) async {

    try {
      final res = await http.delete(backend_base_url + uri);

      if(res.statusCode == 200) {

        return json.decode(res.body);
      }
      else {
        print()
      }
    } catch(Error) {
      print(Error);
    }

  }

}
