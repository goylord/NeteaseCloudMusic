import 'dart:convert';
import 'dart:io';

final String base_url = "you server url";
final int port = 3000;
final String schema = "http";

HttpClient httpClient = new HttpClient();

Future BashRequest({url = "", params}) async {
  Uri uri = Uri(
      scheme: schema,
      host: base_url,
      path: url,
      port: port,
      queryParameters: params);
  HttpClientRequest httpRequest = await httpClient.getUrl(uri);
  HttpClientResponse httpClientResponse = await httpRequest.close();
  return await httpClientResponse.transform(utf8.decoder).join();
}

Future GetPersonalizedList() async {
  return json
      .decode(await BashRequest(url: '/personalized', params: {"limit": "10"}));
}

Future GetMusicListByPlaylistId({int id}) async {
  return json.decode(await BashRequest(url: '/playlist/detail', params: {
    "limit": "10",
    "id": id.toString(),
  }));
}

Future GetMusicUrlById({int id}) async {
  return json.decode(await BashRequest(url: '/song/url', params: {
    "id": id.toString(),
  }));
}
