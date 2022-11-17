import '../common/config/ignoreConfig.dart';

class Address{

  static getOAuthUrl() {
    return "https://github.com/login/oauth/authorize?client_id"
        "=${NetConfig.CLIENT_ID}&state=app&"
        "scope=user,repo,gist,notifications,read:org,workflow&"
        "redirect_uri=gsygithubapp://authed";
  }
}