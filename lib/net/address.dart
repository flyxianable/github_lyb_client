import '../common/config/config.dart';
import '../common/config/ignoreConfig.dart';

class Address {
  static const String host = "https://api.github.com/";

  static getOAuthUrl() {
    return "https://github.com/login/oauth/authorize?client_id"
        "=${NetConfig.CLIENT_ID}&state=app&"
        "scope=user,repo,gist,notifications,read:org,workflow&"
        "redirect_uri=gsygithubapp://authed";
  }

  static getLoginUrl(String code) {
    return "https://github.com/login/oauth/access_token?"
        "client_id=${NetConfig.CLIENT_ID}"
        "&client_secret=${NetConfig.CLIENT_SECRET}"
        "&code=${code}";
  }

  /**
   * 用户收到的事件信息 get
   */
  static getEventReceived(userName) {
    return "${host}users/$userName/received_events";
  }

  /**
   * 处理分页参数
   */
  static getPageParams(tab, page, [pageSize = Config.PAGE_SIZE]) {
    if (page != null) {
      if (pageSize != null) {
        return "${tab}page=$page&per_page=$pageSize";
      } else {
        return "${tab}page=$page";
      }
    } else {
      return "";
    }
  }

  /**
   * 我的用户信息 GET
   */
  static getMyUserInfo() {
    return "${host}user";
  }
}
