//
//  ResponseObject.h
//  TTmall
//
//  Created by wangyuanfei on 3/13/16.
//  Copyright © 2016 Footway tech. All rights reserved.
/**
    访问服务器成功时返回的数据转换成模型对象
 */

#import <Foundation/Foundation.h>
typedef enum {
    //登陆
     LOGIN_SUCCESS = 10,           //登录成功
     LOGINOUT_SUCESS = 11,          //退出成功!
    //注册
     REGIST_SUCESS = 20,           //注册成功!
    
    //用户信息
     GET_USERINFO_SUCESS = 30 ,       //查看用户信息成功
     PUT_USERINFO_SUCESS = 40 ,          //修改用户信息成功!
    
    //修改头像
      API_HEADIMG_SUCESS = 50 ,      //修改头像成功!
    
    //收货地址
      GET_ADDRESS_SUCESS = 60 ,        //查看收货地址成功
      PUT_ADDRESS_SUCESS = 61 ,        //收货人地址修改成功！
    
    //购物车
      GET_SHOPCAR_SUCESS = 70 ,  //查看购物车成功
      POST_SHOPCAR_ADD_SUCESS = 71 ,//添加购物车成功
      DELE_SHOPCAR_SUCESS = 72 ,   //删除购物车成功
    
    //订单
      GET_ORDER_SUCESS = 80 ,         //获取订单成功
      POST_ORDER_MAKE_SUCESS = 81 ,   //生成订单
    
      DELETE_ORDER_DELETE_SUCESS = 82 ,//删除订单成功
    
    //商品收藏
      GET_GOODS_COLLECT_SUCESS = 90 ,           //查询收藏商品信息成功!
      POST_GOODS_COLLECT_SUCESS = 91 ,         //添加收藏商品成功!
      DELETE_GOODS_COLLECT_SUCESS = 92 ,      //取消商品收藏成功
    
    //店铺收藏
      GET_SHOPCOLLECT_SUCESS = 100 ,             //查询商品收藏信息成功
      POST_SHOPCOLLECT_FAVORITE_SUCESS = 101 ,   //收藏店铺成功!
      DELSHOPCOLLECT_SUCESS = 102 ,              //取消店铺成功!
    
    //找回密码
      PASSWORD_FIND_SUCESS = 110 ,           //找回密码成功!
    
    //上传图像
      UPLOAD_IMG_SUCESS = 120 ,              //上传头像成功
    
    //发送短信
      SHORTMESSAGE_SUCESS = 130 ,            //发送短信成功

//    LOGINOUT_SUCESS = 140 ,              //退出成功 跟状态码11重复
    
    //首页数据
      GET_INDEX_PAGE_SUCESS = 150 ,          //获取首页数据成功
    
    //商品信息
      GET_GOODSITEM_SUCESS = 160 ,           //查看商品信息成功
    
    //商品分类
      GET_CLASSIFY_TREE_SUCESS = 170 ,      //查看商品分类成功
    
    //初始化
      GET_INIT_GETKEY_SUCESS = 180 ,        //获取key成功
      POST_INIT_VERSIONUPGRADE_SUCESS = 181 , //版本升级信息获取失败
    
    //错误日志
      ADD_ERRORLOG_SUCESS = 190 ,            //加入错误日志成功
    //一般请求成功的状态吗
    //猜你喜欢
    QUERY_SUCCESS1 = 200 ,
    QUERY_SUCCESS2 = 400 ,
    //猜你喜欢
      GUESS_LIKE_SUCESS = 201 ,               //查看猜你喜欢成功;(最新返回的成功的状态码是200)
    
    //以下为异常
    //登陆
      LOGIN_USERNAME_EMPTY = -11 ,            //用户名不能为空！
      LOGIN_PASSWORD_EMPTY = -12 ,            //密码不能为空！
      LOGIN_WRONG_USERNAME_PWD = -13 ,        //用户名不存在或密码不正确!
      LOGINOUT_FAIL = -14 ,                   //退出失败!
    //注册
      RGISTER_NAME_EMPTY = -21 ,               //用户名为空
      RGISTER_PASSWORD_EMPTY = -22 ,         //密码为空
      RGISTER_MOBILECODE_EMPTY   = -23 ,     //验证码为空!
      RGISTER_CODE_TIMEOUT = -24 ,                   //验证码已过期，请重新验证!
      RGISTER_CODE_WRONG  = -25 ,                    //手机验证码不正确 ，请重新填写!
      RGISTER_USERNAME_EMPTY      = -26 ,            //用户名不能为空 ，请重新填写!
      RGISTER_PASSWORD_NOMATCH      = -27 ,          //两次密码不一致 ，请重新填写!
      RGISTER_USERNAME_EXISTS      = -28 ,           //该用户名已存在 ，请重新填写!
      REGIST_FAIL       =  -29 ,                     //注册失败
    
    
    //查看用户信息
      GET_USERINFO_MEMBERID_EMPTY  = -31 ,        //用户ID为空
      GET_USERINFO_FAIL  = -32 ,                  //查询不到用户信息
    //修改用户信息
      PUT_USERINFO_MEMBERID_EMPTY = -41 ,              //用户ID为空！
      PUT_USERINFO_NICKNAME_EMPTY = -42 ,              //昵称不能为空！
      PUT_USERINFO_SEX_EMPTY = -43 ,                   //性别不能为空！
      PUT_USERINFO_TRUENAME_EMPTY = -44 ,              //真实姓名不能为空！
    
    //修改头像
      API_HEADIMG  = -51 ,                          //修改头像
    
    //收货地址
      GET_ADDRESS_MEMBERID_EMPTY = -61 ,           //用户id为空
      GET_ADDRESS_FAIL = -62 ,                     //收货地址查询失败
    
      PUT_ADDRESS_MEMBERID_EMPTY  =  -63 ,          //用户ID为空
      PUT_ADDRESS_CONTINENT_EMPTY = -64 ,           //洲为空
      PUT_ADDRESS_COUNTRY_EMPTY = -65 ,             //国家为空
      PUT_ADDRESS_PROVINCE_EMPTY = -66 ,            //省为空
      PUT_ADDRESS_AREA_EMPTY = -67 ,                //区为空
      PUT_ADDRESS_ADDRESS_EMPTY = -68 ,             //收货地址为空
      PUT_ADDRESS_POSTCODE_EMPTY = -69 ,            //邮政编码不能为空
      PUT_ADDRESS_NAME_EMPTY = -1061 ,              //收货人姓名不能为空！
      PUT_ADDRESS_TELEEORCELL_NOEMPTY = -1062 ,     //电话号码、手机号码至少有一项不能为空！
      PUT_ADDRESS_FAIL = -1062 ,                    //收货人地址修改失败！
      PUT_ADDRESS_POINTITEM = 1063 ,                //无法确定修改那条记录
    
    
    //购物车
      GET_SHOPCAR_UID_EMPTY = -71 ,         //用户id为空
    
      POST_SHOPCAR_MEMBERID_EMPTY = -72 ,   //用户ID为空
      POST_SHOPCAR_GOODSID_EMPTY = -73 ,    //商品ID为空
      POST_SHOPCAR_MYNUM_EMPTY = -74 ,      //商品数量为空
      POST_SHOPCAR_NQ100ITEMS = -75 ,       //最多只能添加100条商品
      POST_SHOPCAR_ADD_FAIL = -76 ,         //添加购物车失败
    
      DELE_SHOPCAR_MEMBERID_EMPTY = -77 ,  //用户ID为空
      DELE_SHOPCAR_GOODSID_EMPTY = -78 ,   //商品ID为空
      DELE_SHOPCAR_FAIL = -79 ,            //删除购物车失败
    
    //订单
      GET_ORDER_MEMBERID_EMPTY = -81 ,    //用户ID为空
      GET_ORDER_EMPTY = -82 ,             //用户没有订单
      GET_ORDER_WRONG = -83 ,             //订单中没有商品
    
      POST_ORDER_MAKE_MEMBERID_EMPTY = -84 ,             //用户ID为空
      POST_ORDER_MAKE_FAIL = -85 ,                       //订单生成失败
    
      DELETE_ORDER_MEMBERID_EMPTY = -87 ,                  //用户ID为空
      DELETE_ORDER_ORDERId_EMPTY = -86 ,                 //订单ID为空
      DELETE_ORDER_ORDERITEM_EMPTY = -88 ,               //订单查询不到商品
      DELETE_ORDER_DELETE_FAIL = -89 ,                     //删除订单失败
    
    
    //商品收藏
      GET_GOODS_COLLECT_MEMBERID_EMPTY = -91 ,          //用户id为空!
    
      POST_GOODS_COLLECT_CATID_EMPTY = -92 ,           //类别id不能为空!
      POST_GOODS_COLLECT_GOODSID_EMPTY = -93 ,         //商品id不能为空!
      POST_GOODS_COLLECT_MEMBERID_EMPTY = -94 ,        //用户id为空
      POST_GOODS_COLLECT_REPEAT = -95 ,                //请勿重复收藏!
      POST_GOODS_COLLECT_FAIL = -96 ,                  //收藏商品失败!
    
      DELETE_GOODS_COLLECT_GOODSID_EMPTY = -97 ,      //商品id不能为空!
      DELETE_GOODS_COLLECT_MEMBERID_EMPTY = -98 ,     //用户id不能为空!
      DELETE_GOODS_COLLECT_FAIL = -99 ,               //取消商品收藏失败!
    
    //店铺收藏
      GET_SHOPCOLLECT_UID_EMPTY = -101 ,             //商品id不能为空!
      GET_SHOPCOLLECT_SHOPID_EMPTY = -102 ,          //店铺id为空
      GET_SHOPCOLLECT_FAIL = -103 ,                  //查询店铺收藏信息失败
    
      POST_SHOPCOLLECT_SHOPID_EMPTY = -104 ,            //店铺id不能为空!
      POST_SHOPCOLLECT_MEMBERID_EMPTY = -105 ,          //用户id不能为空!
      POST_SHOPCOLLECT_FAIL = -106 ,            //收藏店铺失败!
      POST_SHOPCOLLECT_REPEAT = -107 ,          //请勿重复收藏!
    
      DELSHOPCOLLECT_SHOPID_EMPTY = -108 ,      //店铺id不能为空!
      DELSHOPCOLLECT_UID_EMPTY = -109 ,         //用户id不能为空!
      DELSHOPCOLLECT_FAIL = -10101 ,            //取消店铺失败!
      DELSHOPCOLLECT_SHOP_NOTCOLLECT = -10102 , //没有收藏该店铺!'
    
    //找回密码
      PASSWORD_FIND_MEMBERID_EMPTY = -112 ,     //用户ID为空!
      PASSWORD_FIND_NEWPASSWORD_EMPTY = -113 ,  //新密码为空!
      PASSWORD_FIND_FAIL = -114 ,               //找回密码失败!
    
    //上传图像
      UPLOAD_IMG_MEMBERID_EMPTY = -121 ,        //用户名为空
      UPLOAD_IMG_FAIL = -122 ,                  //保存头像失败
      UPLOAD_FILES_FAIL = -123 ,                //上传头像失败
    
    //发送短信
      SHORTMESSAGE_MOBILE_EMPTY = -131 ,       //接收手机为空
      SHORTMESSAGE_TYPE_EMPTY = -132 ,         //短信类型为空
      SHORTMESSAGE_FAIL = -133 ,               //短信发送失败
    
    //退出
//      LOGINOUT_FAIL = -141 ,                  //退出失败   跟状态码-14重复
    //   LOGINOUT_NOLOGIN = -142 ,               //
    
    //首页数据
      GET_INDEX_GOODSCLASSIFYTREE_FAIL = -151 , //读取商品分类树失败
      GET_INDEX_NEWS_FAIL = -152 ,             //读取新闻动态失败
      GET_INDEX_GOODSCATE_FAIL = -153 ,        //读取楼层分类失败
      GET_INDEX_INDEXARTICLE_FAIL = -154 ,     //读取楼层分类失败
      GET_INDEX_CHANNELMENU_FAIL = -155 ,      //读取频道失败
    
    //商品信息
      GET_GOODSITEM_GOODSID_EMPTY = -161 ,     //商品ID为空
      GET_GOODSITEM_FAIL = -162 ,              //读取商品信息失败
    
    //商品分类
      GET_CLASSIFY_TREE_FAIL = -171 ,         //查看商品分类树失败
    
    //初始化
      GET_INIT_GETKEY_FAIL = -181 ,          //获取key失败
      POST_INIT_VERSIONUPGRADE_FAIL = -182 , //版本升级信息获取失败
      API_INVALID_ARGS = -183 ,              //非法参数
      API_NO_APP_ID = -184 ,                 //app_id不存在
      API_NO_AUTH = -185 ,                   //没有权限
    
    //错误日志
      ERRORLOG_EMPTY = -191 ,                //错误日志为空
      ADD_ERRORLOG_FAIL = -192 ,             //加入错误日志失败
    
    //猜你喜欢
      GUESS_LIKE_MEMBERID_EMPTY = -201 ,    //用户id为空
      GUESS_LIKE_FAIL = -202          //查看猜你喜欢失败

} ResponseStatus ;



@interface ResponseObject : NSObject <NSCopying>

/** 状态码 */
@property(nonatomic,assign)ResponseStatus  status ;
/** 返回信息描述 */
@property(nonatomic,copy)NSString * msg ;
/**是否更新的时间戳*/
@property (nonatomic, assign) NSInteger modify_time;
/** 返回数据 */
@property(nonatomic,strong) id data  ;
-(instancetype)initWithDict:(NSDictionary *)dict;
-(void)save;
+(instancetype )read;
@end


static const NSString * STATUSLOGIN_SUCCESS = @"登录成功";
static const NSString * STATUSLOGINOUT_SUCESS = @"退出  成功!";
//注册
static const NSString * STATUSREGIST_SUCESS = @"注册  成功!";

//用户信息
static const NSString * STATUSGET_USERINFO_SUCESS = @"查看用户信息成功";
static const NSString * STATUSPUT_USERINFO_SUCESS = @"修改用户信息成功!";

//修改头像
static const NSString * STATUSAPI_HEADIMG_SUCESS = @"修改头像成功!";

//收货地址
static const NSString * STATUSGET_ADDRESS_SUCESS = @"查看收货地址成功";
static const NSString * STATUSPUT_ADDRESS_SUCESS = @"收货人地址修改成功！";

//购物车
static const NSString * STATUSGET_SHOPCAR_SUCESS = @"查看购物车成功";
static const NSString * STATUSPOST_SHOPCAR_ADD_SUCESS = @"添加购物车成功";
static const NSString * STATUSDELE_SHOPCAR_SUCESS = @"删除购物车成功";

//订单
static const NSString * STATUSGET_ORDER_SUCESS = @"获取订单成功";
static const NSString * STATUSPOST_ORDER_MAKE_SUCESS =@"生成订单";

static const NSString * STATUSDELETE_ORDER_DELETE_SUCESS =@"删除订单成功";

//商品收藏
static const NSString * STATUSGET_GOODS_COLLECT_SUCESS = @"查询收藏商品信息成功!";
static const NSString * STATUSPOST_GOODS_COLLECT_SUCESS = @"添加收藏商品成功!";
static const NSString * STATUSDELETE_GOODS_COLLECT_SUCESS = @"取消商品收藏成功";

//店铺收藏
static const NSString * STATUSGET_SHOPCOLLECT_SUCESS = @"查询商品收藏信息成功";
static const NSString * STATUSPOST_SHOPCOLLECT_FAVORITE_SUCESS = @"收藏店铺成功!";
static const NSString * STATUSDELSHOPCOLLECT_SUCESS = @"取消店铺成功!";

//找回密码
static const NSString * STATUSPASSWORD_FIND_SUCESS = @"找回密码成功!";

//上传图像
static const NSString * STATUSUPLOAD_IMG_SUCESS =@"上传头像成功";

//发送短信
static const NSString * STATUSSHORTMESSAGE_SUCESS = @"发送短信成功";

//    LOGINOUT_SUCESS = 140 ,              //退出成功 跟状态码11重复

//首页数据
static const NSString * STATUSGET_INDEX_PAGE_SUCESS =@"获取首页数据成功";

//商品信息
static const NSString * STATUSGET_GOODSITEM_SUCESS = @"查看商品信息成功";

//商品分类
static const NSString * STATUSGET_CLASSIFY_TREE_SUCESS = @"查看商品分类成功";

//初始化
static const NSString * STATUSGET_INIT_GETKEY_SUCESS =@"获取key成功";
static const NSString * STATUSPOST_INIT_VERSIONUPGRADE_SUCESS = @"版本升级信息获取失败";

//错误日志
static const NSString * STATUSADD_ERRORLOG_SUCESS = @"加入错误日志成功";

//猜你喜欢
static const NSString * STATUSGUESS_LIKE_SUCESS = @"查看猜你喜欢成功;";

//以下为异常
//登陆
static const NSString * STATUSLOGIN_USERNAME_EMPTY = @"用户名不能为空！";
static const NSString * STATUSLOGIN_PASSWORD_EMPTY = @"密码不能为空！";
static const NSString * STATUSLOGIN_WRONG_USERNAME_PWD = @"用户名不存在或密码不正确!";
static const NSString * STATUSLOGINOUT_FAIL = @"退出失败!";
//注册
static const NSString * STATUSRGISTER_NAME_EMPTY = @"用户名为空";
static const NSString * STATUSRGISTER_PASSWORD_EMPTY = @"密码为空";
static const NSString * STATUSRGISTER_MOBILECODE_EMPTY   = @"验证码为空!";
static const NSString * STATUSRGISTER_CODE_TIMEOUT = @"验证码已过期，请重新验证!";
static const NSString * STATUSRGISTER_CODE_WRONG  = @"手机验证码不正确 ，请重新填写!";
static const NSString * STATUSRGISTER_USERNAME_EMPTY      = @"用户名不能为空 ，请重新填写!";
static const NSString * STATUSRGISTER_PASSWORD_NOMATCH      = @"两次密码不一致 ，请重新填写!";
static const NSString * STATUSRGISTER_USERNAME_EXISTS      = @"该用户名已存在 ，请重新填写!";
static const NSString * STATUSREGIST_FAIL       =  @"注册失败";


//查看用户信息
static const NSString * STATUSGET_USERINFO_MEMBERID_EMPTY  =@"用户ID为空";
static const NSString * STATUSGET_USERINFO_FAIL  = @"查询不到用户信息";
//修改用户信息
static const NSString * STATUSPUT_USERINFO_MEMBERID_EMPTY = @"用户ID为空！";
static const NSString * STATUSPUT_USERINFO_NICKNAME_EMPTY =@" 昵称不能为空！";
static const NSString * STATUSPUT_USERINFO_SEX_EMPTY = @"性别不能为空！";
static const NSString * STATUSPUT_USERINFO_TRUENAME_EMPTY =@" 真实姓名不能为空！";

//修改头像
static const NSString * STATUSAPI_HEADIMG  =@"修改头像";

//收货地址
static const NSString * STATUSGET_ADDRESS_MEMBERID_EMPTY = @"用户id为空";
static const NSString * STATUSGET_ADDRESS_FAIL = @"收货地址查询失败";

static const NSString * STATUSPUT_ADDRESS_MEMBERID_EMPTY  =  @"用户ID为空";
static const NSString * STATUSPUT_ADDRESS_CONTINENT_EMPTY =@" 洲为空";
static const NSString * STATUSPUT_ADDRESS_COUNTRY_EMPTY = @"国家为空";
static const NSString * STATUSPUT_ADDRESS_PROVINCE_EMPTY = @"省为空";
static const NSString * STATUSPUT_ADDRESS_AREA_EMPTY = @"区为空";
static const NSString * STATUSPUT_ADDRESS_ADDRESS_EMPTY =@" 收货地址为空";
static const NSString * STATUSPUT_ADDRESS_POSTCODE_EMPTY = @"邮政编码不能为空";
static const NSString * STATUSPUT_ADDRESS_NAME_EMPTY = @"收货人姓名不能为空！";
static const NSString * STATUSPUT_ADDRESS_TELEEORCELL_NOEMPTY =@"电话号码、手机号码至少有一项不能为空！";
static const NSString * STATUSPUT_ADDRESS_FAIL = @"收货人地址修改失败！";
static const NSString * STATUSPUT_ADDRESS_POINTITEM = @"无法确定修改那条记录";


//购物车
static const NSString * STATUSGET_SHOPCAR_UID_EMPTY =@"用户id为空";

static const NSString * STATUSPOST_SHOPCAR_MEMBERID_EMPTY =@"用户ID为空";
static const NSString * STATUSPOST_SHOPCAR_GOODSID_EMPTY = @"商品ID为空";
static const NSString * STATUSPOST_SHOPCAR_MYNUM_EMPTY = @" 商品数量为空";
static const NSString * STATUSPOST_SHOPCAR_NQ100ITEMS = @" 最多只能添加100条商品";
static const NSString * STATUSPOST_SHOPCAR_ADD_FAIL = @"添加购物车失败";

static const NSString * STATUSDELE_SHOPCAR_MEMBERID_EMPTY = @"用户ID为空";
static const NSString * STATUSDELE_SHOPCAR_GOODSID_EMPTY =@"商品ID为空";
static const NSString * STATUSDELE_SHOPCAR_FAIL = @" 删除购物车失败";

//订单
static const NSString * STATUSGET_ORDER_MEMBERID_EMPTY =@"用户ID为空";
static const NSString * STATUSGET_ORDER_EMPTY = @"用户没有订单";
static const NSString * STATUSGET_ORDER_WRONG = @"订单中没有商品";

static const NSString * STATUSPOST_ORDER_MAKE_MEMBERID_EMPTY =@"用户ID为空";
static const NSString * STATUSPOST_ORDER_MAKE_FAIL = @"订单生成失败";

static const NSString * STATUSDELETE_ORDER_MEMBERID_EMPTY = @"用户ID为空";
static const NSString * STATUSDELETE_ORDER_ORDERId_EMPTY = @"订单ID为空";
static const NSString * STATUSDELETE_ORDER_ORDERITEM_EMPTY =@" 订单查询不到商品";
static const NSString * STATUSDELETE_ORDER_DELETE_FAIL = @"删除订单失败";


//商品收藏
static const NSString * STATUSGET_GOODS_COLLECT_MEMBERID_EMPTY =@"用户id为空!";

static const NSString * STATUSPOST_GOODS_COLLECT_CATID_EMPTY =@"类别id不能为空!";
static const NSString * STATUSPOST_GOODS_COLLECT_GOODSID_EMPTY =@"商品id不能为空!";
static const NSString * STATUSPOST_GOODS_COLLECT_MEMBERID_EMPTY = @" 用户id为空";
static const NSString * STATUSPOST_GOODS_COLLECT_REPEAT = @"请勿重复收藏!";
static const NSString * STATUSPOST_GOODS_COLLECT_FAIL =@"收藏商品失败!";

static const NSString * STATUSDELETE_GOODS_COLLECT_GOODSID_EMPTY = @"商品id不能为空!";
static const NSString * STATUSDELETE_GOODS_COLLECT_MEMBERID_EMPTY = @"用户id不能为空!";
static const NSString * STATUSDELETE_GOODS_COLLECT_FAIL =@"取消商品收藏失败!";

//店铺收藏
static const NSString * STATUSGET_SHOPCOLLECT_UID_EMPTY = @" 商品id不能为空!";
static const NSString * STATUSGET_SHOPCOLLECT_SHOPID_EMPTY = @"店铺id为空";
static const NSString * STATUSGET_SHOPCOLLECT_FAIL = @"查询店铺收藏信息失败";

static const NSString * STATUSPOST_SHOPCOLLECT_SHOPID_EMPTY = @"店铺id不能为空!";
static const NSString * STATUSPOST_SHOPCOLLECT_MEMBERID_EMPTY =@"用户id不能为空!";
static const NSString * STATUSPOST_SHOPCOLLECT_FAIL = @"收藏店铺失败!";
static const NSString * STATUSPOST_SHOPCOLLECT_REPEAT =@"请勿重复收藏!";

static const NSString * STATUSDELSHOPCOLLECT_SHOPID_EMPTY =@"店铺id不能为空!";
static const NSString * STATUSDELSHOPCOLLECT_UID_EMPTY =@"用户id不能为空!";
static const NSString * STATUSDELSHOPCOLLECT_FAIL = @" 取消店铺失败!";
static const NSString * STATUSDELSHOPCOLLECT_SHOP_NOTCOLLECT = @"没有收藏该店铺!";

//找回密码
static const NSString * STATUSPASSWORD_FIND_MEMBERID_EMPTY =@" 用户ID为空!";
static const NSString * STATUSPASSWORD_FIND_NEWPASSWORD_EMPTY =@"新密码为空!";
static const NSString * STATUSPASSWORD_FIND_FAIL = @" 找回密码失败!";

//上传图像
static const NSString * STATUSUPLOAD_IMG_MEMBERID_EMPTY = @"用户名为空";
static const NSString * STATUSUPLOAD_IMG_FAIL = @" 保存头像失败";
static const NSString * STATUSUPLOAD_FILES_FAIL =@"上传头像失败";

//发送短信
static const NSString * STATUSSHORTMESSAGE_MOBILE_EMPTY = @"接收手机为空";
static const NSString * STATUSSHORTMESSAGE_TYPE_EMPTY =@" 短信类型为空";
static const NSString * STATUSSHORTMESSAGE_FAIL = @"短信发送失败";

//退出
//      LOGINOUT_FAIL = -141 ,                 退出失败   跟状态码-14重复
//   LOGINOUT_NOLOGIN = -142 ,              

//首页数据
static const NSString * STATUSGET_INDEX_GOODSCLASSIFYTREE_FAIL =@"读取商品分类树失败";
static const NSString * STATUSGET_INDEX_NEWS_FAIL = @"读取新闻动态失败";
static const NSString * STATUSGET_INDEX_GOODSCATE_FAIL = @"读取楼层分类失败";
static const NSString * STATUSGET_INDEX_INDEXARTICLE_FAIL =@" 读取楼层分类失败";
static const NSString * STATUSGET_INDEX_CHANNELMENU_FAIL = @" 读取频道失败";

//商品信息
static const NSString * STATUSGET_GOODSITEM_GOODSID_EMPTY =@"商品ID为空";
static const NSString * STATUSGET_GOODSITEM_FAIL = @" 读取商品信息失败";

//商品分类
static const NSString * STATUSGET_CLASSIFY_TREE_FAIL = @"查看商品分类树失败";

//初始化
static const NSString * STATUSGET_INIT_GETKEY_FAIL = @"获取key失败";
static const NSString * STATUSPOST_INIT_VERSIONUPGRADE_FAIL =@"版本升级信息获取失败";
static const NSString * STATUSAPI_INVALID_ARGS = @" 非法参数";
static const NSString * STATUSAPI_NO_APP_ID = @"app_id不存在";
static const NSString * STATUSAPI_NO_AUTH = @" 没有权限";

//错误日志
static const NSString * STATUSERRORLOG_EMPTY = @"错误日志为空";
static const NSString * STATUSADD_ERRORLOG_FAIL =@"  加入错误日志失败";

//猜你喜欢
static const NSString * STATUSGUESS_LIKE_MEMBERID_EMPTY = @" 用户id为空";
static const NSString * STATUSGUESS_LIKE_FAIL = @" 查看猜你喜欢失败";

