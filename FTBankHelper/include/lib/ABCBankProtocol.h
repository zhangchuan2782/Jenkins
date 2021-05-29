#import <Foundation/Foundation.h>

//错误码
#define  ABC_SUCCESS                    0x00000000  //操作成功
#define  ABC_OPERATION_FAILED           0x00000001  //操作失败
#define  ABC_NO_DEVICE                  0x00000002  //设备未连接
#define  ABC_DEVICE_BUSY                0x00000003  //设备忙
#define  ABC_INVALID_PARAMETER          0x00000004  //参数错误
#define  ABC_PASSWORD_INVALID           0x00000005  //密码错误
#define  ABC_USER_CANCEL                0x00000006  //用户取消操作
#define  ABC_OPERATION_TIMEOUT          0x00000007  //操作超时
#define  ABC_NO_CERT                    0x00000008  //没有证书
#define  ABC_CERT_INVALID               0x00000009  //证书格式不正确
#define  ABC_UNKNOW_ERROR               0x0000000A  //未知错误
#define  ABC_PIN_LOCK                   0x0000000B  //PIN码锁定
#define  ABC_OPERATION_INTERRUPT        0x0000000C  //操作被打断（如来电等）
#define  ABC_COMM_FAILED                0x0000000D  //通讯错误
#define  ABC_ENERGY_LOW                 0x0000000E  //设备电量不足，不能进行通讯

//算法
#define ABC_ALG_RSA                     0x00000000  //RSA算法
#define ABC_ALG_SM2                     0x00000001  //SM2算法

#define ABC_ALG_SHA1                    0x00000000  //SHA1算法
#define ABC_ALG_SHA256                  0x00000001  //SHA256算法
#define ABC_ALG_SM3                     0x00000002  //SM3算法

//厂家给手机银行发送的退出管理工具的通知
#define ABC_RET_NOTIFICATION @"ABCRetNotification"

//厂家给手机银行发送的返回主菜单通知
#define ABC_TO_MAIN_MENU_NOTIFICATION @"ABCBackToMainMenuNotification"

/**
 *  K宝接口
 */
@protocol ABCBankProtocol <NSObject>

@required

/**
 *  获取中间件版本号，规则:x.x.x.x
 *
 *  @param libVersion 返回版本号
 *
 *  @return 错误码
 */
+ (NSInteger)ABCGetLibVersion:(NSString **)libVersion;

/**
 *  管理工具，需要判断序列号，如果不匹配提示
 *
 *  @param SN 序列号
 *
 *  @return 管理工具，UIViewController
 */
+(id)ABCManagementTool:(NSString *)SN;

/**
 *  显示签名，
 *
 *  @param SignResult 签名结果
 *  @param DN         证书DN值
 *  @param SN         序列号
 *  @param SignData   签名报文
 *  @param SignAlg    非对称加密算法
 *  @param HashAlg    Hash算法
 *
 *  @return 错误码
 */
+ (NSInteger)ABCSign:(NSString **)SignResult
                  DN:(NSString *)DN
                  SN:(NSString *)SN
            SignData:(NSString *)SignData
             SignAlg:(NSInteger)SignAlg
             HashAlg:(NSInteger)HashAlg;

/**
 *  获取生成P10，读取出生证等信息
 *
 * @param sn     [IN] K宝序列号
 * @param random [IN] 随机数
 * @param dn     [IN] 证书dn
 * @param birthCert [OUT] K宝出生证
 * @param idSign    [OUT] idSign 如果是国密K宝，由”||”拼接，个数与传入的DN个数对应
 * @param P10       [OUT] P10 产生的公钥，如果是国密K宝，由”||”拼接，个数与传入的DN个数对应。注意：对于普通二代Key，应该返回2048位rsa公钥。
 *
 * @return 错误码
 */
+(NSInteger)ABCInitAndGetPubKey:(NSString*)sn
                         random:(NSUInteger)random
                             dn:(NSString*)dn
                      birthCert:(NSMutableString*)birthCert
                         idSign:(NSMutableString*)idSign
                            P10:(NSMutableString*)P10;


/**
 * 将证书写到K宝中
 *
 * @param cert          [in]证书，如果是国密Key宝，可能是“||”连接的多个证书
 *
 * @return 错误码
 */
+(NSInteger)ABCWriteCertToKey:(NSString*)cert;

@end