const OK_CODE = 1; //ok
const INVALID_CREDENTIAL = 101; //验证登录失败,token不合法
const EXPIRED_CREDENTIAL = 102; //需要登录的接口表示token过期,如果是刷新token则表示提前刷新
const PERMISSION_LACKED = 103; // 无权限
const PERMISSION_DENIED = -103; // 包含不好的权限
const EXCEPT_CODE = 104; //业务异常,弹窗
const ERROR_CODE = 105; //服务器繁忙

const SERVER_NOT_RESPONSE = 502;
const NOT_FOUND = 404;
const NO_PERMISSION = 403;
const SERVER_ERROR = 400;
