//
//  新闻包.m
//  Http同步请求
//
//  Created by qianfeng on 14/3/17.
//  Copyright © 2014年 zhangying. All rights reserved.
//




//http://interfacev5.vivame.cn/x1-interface-v5/json/mylogin.json?platform=android&installversion=5.6.0.1&channelno=WDJTA2320480100&type=1&isAuth=false&mid=8c4bbef0e18cb39648129919639311e7&sid=a3f8c2b8-6ff9-4965-a7c9-d8bd3865e63d&visitorid=9007775


//http://interfacev5.vivame.cn/x1-interface-v5/json/newdatalist.json?uid=9007775&sid=cefaf5c3-27e6-4c3f-9d92-e77a27438139&type=-1&id=-4&category=-1&ot=0&nt=0
//GET http://interfacev5.vivame.cn/x1-interface-v5/json/newdatalist.json?platform=android&installversion=5.6.0.1&channelno=WDJTA2320480100&mid=8c4bbef0e18cb39648129919639311e7&uid=9007775&sid=cefaf5c3-27e6-4c3f-9d92-e77a27438139&type=-1&id=-4&category=-1&ot=0&nt=0
//GET http://interfacev5.vivame.cn/x1-interface-v5/json/task.json?platform=android&installversion=5.6.0.1&channelno=WDJTA2320480100&uid=9007775&mid=8c4bbef0e18cb39648129919639311e7
//GET http://interfacev5.vivame.cn/x1-interface-v5/json/viewsconf.json?platform=android&installversion=5.6.0.1&channelno=WDJTA2320480100&mid=8c4bbef0e18cb39648129919639311e7&uid=9007775&sid=a3f8c2b8-6ff9-4965-a7c9-d8bd3865e63d



//广告
//GET http://interfacev5.vivame.cn/x1-interface-v5/json/ad/feed.json?platform=android&installversion=5.6.0.1&channelno=WDJTA2320480100&mid=8c4bbef0e18cb39648129919639311e7&uid=9007775&sid=a3f8c2b8-6ff9-4965-a7c9-d8bd3865e63d

//GET http://interfacev5.vivame.cn/x1-interface-v5/json/ad/loading.json?platform=android&installversion=5.6.0.1&channelno=WDJTA2320480100&mid=8c4bbef0e18cb39648129919639311e7&uid=9007775&sid=a3f8c2b8-6ff9-4965-a7c9-d8bd3865e63d

//GET http://interfacev5.vivame.cn/x1-interface-v5/json/ad/shoppingguide.json?platform=android&installversion=5.6.0.1&channelno=WDJTA2320480100&mid=8c4bbef0e18cb39648129919639311e7&uid=9007775&sid=a3f8c2b8-6ff9-4965-a7c9-d8bd3865e63d


//时事接口
//http://interfacev5.vivame.cn/x1-interface-v5/json/newdatalist.json?platform=android&installversion=5.6.0.1&channelno=WDJTA2320480100&mid=8c4bbef0e18cb39648129919639311e7&uid=9007775&sid=cefaf5c3-27e6-4c3f-9d92-e77a27438139&type=1&id=-1&category=1&ot=0&nt=0
//http://interfacev5.vivame.cn/x1-interface-v5/json/newdatalist.json?platform=android&installversion=5.6.6.3&channelno=MZSDA2320480100&mid=8c4bbef0e18cb39648129919639311e7&uid=9007775&sid=1eda5331-bca5-4946-9708-0cc7d5cc6adf&type=1&id=-1&category=1&ot=0&nt=0

//娱乐接口
//http://interfacev5.vivame.cn/x1-interface-v5/json/newdatalist.json?platform=android&installversion=5.6.0.1&channelno=WDJTA2320480100&mid=8c4bbef0e18cb39648129919639311e7&uid=9007775&sid=cefaf5c3-27e6-4c3f-9d92-e77a27438139&type=1&id=3&category=1&ot=0&nt=0


//精读
//http://interfacev5.vivame.cn/x1-interface-v5/json/newdatalist.json?platform=android&installversion=5.6.0.1&channelno=WDJTA2320480100&mid=8c4bbef0e18cb39648129919639311e7&uid=9007775&sid=cefaf5c3-27e6-4c3f-9d92-e77a27438139&type=1&id=31&category=1&ot=0&nt=0
//美女
//GET http://interfacev5.vivame.cn/x1-interface-v5/json/newdatalist.json?platform=android&installversion=5.6.0.1&channelno=WDJTA2320480100&mid=8c4bbef0e18cb39648129919639311e7&uid=9007775&sid=cefaf5c3-27e6-4c3f-9d92-e77a27438139&type=1&id=13&category=1&ot=0&nt=0
//历史
//GET http://interfacev5.vivame.cn/x1-interface-v5/json/newdatalist.json?platform=android&installversion=5.6.0.1&channelno=WDJTA2320480100&mid=8c4bbef0e18cb39648129919639311e7&uid=9007775&sid=cefaf5c3-27e6-4c3f-9d92-e77a27438139&type=1&id=45&category=1&ot=0&nt=0
//生活
//GET http://interfacev5.vivame.cn/x1-interface-v5/json/newdatalist.json?platform=android&installversion=5.6.0.1&channelno=WDJTA2320480100&mid=8c4bbef0e18cb39648129919639311e7&uid=9007775&sid=cefaf5c3-27e6-4c3f-9d92-e77a27438139&type=1&id=7&category=1&ot=0&nt=0
//军事
//GET http://interfacev5.vivame.cn/x1-interface-v5/json/newdatalist.json?platform=android&installversion=5.6.0.1&channelno=WDJTA2320480100&mid=8c4bbef0e18cb39648129919639311e7&uid=9007775&sid=cefaf5c3-27e6-4c3f-9d92-e77a27438139&type=1&id=11&category=1&ot=0&nt=0
//数码
//GET http://interfacev5.vivame.cn/x1-interface-v5/json/newdatalist.json?platform=android&installversion=5.6.0.1&channelno=WDJTA2320480100&mid=8c4bbef0e18cb39648129919639311e7&uid=9007775&sid=cefaf5c3-27e6-4c3f-9d92-e77a27438139&type=1&id=12&category=1&ot=0&nt=0
//汽车
//GET http://interfacev5.vivame.cn/x1-interface-v5/json/newdatalist.json?platform=android&installversion=5.6.0.1&channelno=WDJTA2320480100&mid=8c4bbef0e18cb39648129919639311e7&uid=9007775&sid=cefaf5c3-27e6-4c3f-9d92-e77a27438139&type=1&id=6&category=1&ot=0&nt=0
//星座
//GET http://interfacev5.vivame.cn/x1-interface-v5/json/newdatalist.json?platform=android&installversion=5.6.0.1&channelno=WDJTA2320480100&mid=8c4bbef0e18cb39648129919639311e7&uid=9007775&sid=cefaf5c3-27e6-4c3f-9d92-e77a27438139&type=1&id=10&category=1&ot=0&nt=0
//热读
//GET http://interfacev5.vivame.cn/x1-interface-v5/json/newdatalist.json?platform=android&installversion=5.6.0.1&channelno=WDJTA2320480100&mid=8c4bbef0e18cb39648129919639311e7&uid=9007775&sid=cefaf5c3-27e6-4c3f-9d92-e77a27438139&type=1&id=-5&category=1&ot=0&nt=0
//时尚
//GET http://interfacev5.vivame.cn/x1-interface-v5/json/newdatalist.json?platform=android&installversion=5.6.0.1&channelno=WDJTA2320480100&mid=8c4bbef0e18cb39648129919639311e7&uid=9007775&sid=cefaf5c3-27e6-4c3f-9d92-e77a27438139&type=1&id=4&category=1&ot=0&nt=0

//更多
//GET http://interfacev5.vivame.cn/x1-interface-v5/json/searchad.json?platform=android&installversion=5.6.0.1&channelno=WDJTA2320480100&mid=8c4bbef0e18cb39648129919639311e7&uid=9007775&sid=cefaf5c3-27e6-4c3f-9d92-e77a27438139
//GET http://interfacev5.vivame.cn/x1-interface-v5/json/discovery.json?platform=android&installversion=5.6.0.1&channelno=WDJTA2320480100&mid=8c4bbef0e18cb39648129919639311e7&uid=9007775&sid=cefaf5c3-27e6-4c3f-9d92-e77a27438139

//杂志
//获取订阅信息
//GET http://interfacev5.vivame.cn/x1-interface-v5/json/usersubscribe.json?platform=android&installversion=5.6.0.1&channelno=WDJTA2320480100&mid=8c4bbef0e18cb39648129919639311e7&uid=9007775&sid=cefaf5c3-27e6-4c3f-9d92-e77a27438139

//获取feed数据表
//GET http://interfacev5.vivame.cn/x1-interface-v5/json/newdatalist.json?platform=android&installversion=5.6.0.1&channelno=WDJTA2320480100&mid=8c4bbef0e18cb39648129919639311e7&uid=9007775&sid=cefaf5c3-27e6-4c3f-9d92-e77a27438139&type=1&id=-2&category=1&ot=0&nt=0
//获取品牌数据
//GET http://interfacev5.vivame.cn/x1-interface-v5/json/brand.json?platform=android&installversion=5.6.0.1&channelno=WDJTA2320480100&mid=8c4bbef0e18cb39648129919639311e7&uid=9007775&sid=cefaf5c3-27e6-4c3f-9d92-e77a27438139&resolution=1280*720&id=338

//获取品牌杂志列表
//GET http://interfacev5.vivame.cn/x1-interface-v5/json/maglist.json?platform=android&installversion=5.6.0.1&channelno=WDJTA2320480100&mid=8c4bbef0e18cb39648129919639311e7&uid=9007775&sid=cefaf5c3-27e6-4c3f-9d92-e77a27438139&resolution=1280*720&id=338&pageindex=0&pagesize=50


