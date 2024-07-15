import 'package:at_planning/generated/l10n.dart';

Map<String, String> ErrorMessageMap = {
//   "UserNotExist": S.current.USER_NOT_EXIST,
//   "BlogNotExist": S.current.BlogNotExist,
//   "AlbumNotExist": S.current.AlbumNotExist,
//   "MusicNotExist": S.current.MusicNotExist,
//   "YouCollect": S.current.YouCollect,
//   "YouAgrees": S.current.YouAgrees,
//   "CommentNotExist": S.current.CommentNotExist,
//   "PhoneExist": S.current.PhoneExist,
//   "BadPhone": S.current.BadPhone,
//   "BadLogin": S.current.BadLogin,
//   "BadOneClick": S.current.BadOneClick,
//   "NotAllowComment": S.current.NotAllowComment,
//   "NonsupportOperation": S.current.NonsupportOperation,
//   "OnlySelf": S.current.OnlySelf,
//   "OnlyTeam": S.current.OnlyTeam,
//   "FriendOnly": S.current.FriendOnly,
//   "FensOnly": S.current.FensOnly,
//   "HasBlack": S.current.HasBlack,
//   "NotPublicBlog": S.current.NotPublicBlog,
//   "BadArgs": S.current.BadArgs,
//   "NotReal": S.current.NotReal,
//   "YesReal": S.current.YesReal,
//   "BadRealInfo": S.current.BadRealInfo,
//   "BadRealAuth": S.current.BadRealAuth,
//   "NotExistCaptcha": S.current.NotExistCaptcha,
//   "BadCaptcha": S.current.BadCaptcha,
//   "BadPlatform": S.current.BadPlatform,
//   "RequestFrequent": S.current.RequestFrequent,
//   "BadIDCardFront": S.current.BadIDCardFront,
//   "BadIDCardBack": S.current.BadIDCardBack,
//   "TryRetry": S.current.TryRetry,
//   "VoteExpired": S.current.VoteExpired,
//   "AlreadyVote": S.current.AlreadyVote,
//   "BadOpsSelf": S.current.BadOpsSelf,
//   "BadRel": S.current.BadRel,
//   "Processing": S.current.Processing,
//   "BadRelUpdate": S.current.BadRelUpdate,
//   "BadSmsCaptcha": S.current.BadSmsCaptcha,
//   "ApplicationNotExist": S.current.ApplicationNotExist,
//   "LoginFrequently": S.current.LoginFrequently,
//   "RequestFrequently": S.current.RequestFrequently,
//   "BadEvent": S.current.BadEvent,
//   "BlogTagNotExist": S.current.BlogTagNotExist,
//   "TimeOut": S.current.TimeOut,
//   "NotCreateAlbums": S.current.NotCreateAlbums,
//   "ResourceIsEmpty": S.current.ResourceIsEmpty
};

class ErrorMessage {
  static String getErrorMessage(String name) {
    try {
      final s = ErrorMessageMap[name];
      if (s == null) {
        throw "未知的错误";
      }
      return s;
    } catch (e) {
      return e.toString();
    }
  }
}
