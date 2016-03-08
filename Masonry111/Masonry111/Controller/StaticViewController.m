//
//  ViewController.m
//  Masonry111
//
//  Created by shavekevin on 16/1/26.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "StaticViewController.h"
#import "Masonry.h"
#import "CustomListCell.h"
#import "YYFPSLabel.h"
#import "NewsViewController.h"

static  NSString *const cellIdentifier = @"cell";
#define PhoneBounds [UIScreen mainScreen].bounds

@interface StaticViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CustomListCell *tempCell;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation StaticViewController
- (IBAction)gotoNetworkVC:(id)sender {
    NewsViewController *newsVC = [[NewsViewController alloc]init];
    [self.navigationController pushViewController:newsVC animated:YES];
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
   // self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200;
    [self.tableView registerClass:[CustomListCell class] forCellReuseIdentifier:cellIdentifier];
    [self setupDatasource];
    YYFPSLabel *label = [YYFPSLabel new];
    label.frame = CGRectMake((CGRectGetWidth(PhoneBounds)- 100)/2.0f, 0, 100, 30);
    [self.navigationController.navigationBar  addSubview:label];
    [self addHeaderView];
}

//TableviewHeaderview不可以被加约束可是它的子视图可以加约束 这里给一个高度就好
- (void)addHeaderView {
    
    UIView *viewContview = [UIView new];
    viewContview.frame = CGRectMake(0, 0, 0, 100);
    viewContview.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = viewContview;

    UIView *viewCss = [UIView new];
    [viewContview addSubview:viewCss];
    viewCss.backgroundColor = [UIColor orangeColor];
    [viewCss mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
}

#pragma mark  - tableview delegate and datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //这个加上是为了解决约束冲突
    cell.frame = CGRectMake(0, 0, CGRectGetWidth(PhoneBounds), CGRectGetHeight(PhoneBounds));
    cell.contentView.frame = cell.frame;
    [cell customListBlindCell: _dataArray[indexPath.row]];
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

/**
 *   iOS8以后如果使用的是masonry 的话  返回高度的方法可以不用写 需要调用
 *   self.tableView.rowHeight = UITableViewAutomaticDimension;
 *   self.tableView.estimatedRowHeight = 200;
 *
 *  @return
 */

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    //从重用池取出去的cell 然后对cell进行赋值 通过赋值 来调用是否更新约束的方法
//    [self.tempCell customListBlindCell:_dataArray[indexPath.row]];
//    [self.tempCell setNeedsUpdateConstraints];
//    [self.tempCell updateConstraintsIfNeeded];
//    [self.tempCell setNeedsLayout];
//    [self.tempCell layoutIfNeeded];
//    return [self.tempCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1 ;
//}
//懒加载一个cell 用于计算高度(从重用池中取出)
- (CustomListCell *)tempCell {
    
    if (!_tempCell) {
        
        _tempCell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    return _tempCell;
}


#pragma mark  - 设置数据源
- (void)setupDatasource {
    
     self.dataArray = @[@"2",@"1",@"ewqeqweeqwqefeqqe ffewfwef wef weefweewewrewrewrewrewrwe",@"1",@"ewqeqweeqwqefeqqe ffewfwef wef weefweewewrewrewrewrewrweweqweqwewqewqeqwewqeqweqweqweqweqw",@"纠结 纠结",@"#温馨提示#旅客朋友们外出旅行时应尽量避免携带大量现金，要用的钱最好事先备好，在车上买饭或购物前，不要现场清点钱物。随身钞票最好零整分放，减少风险。在列车靠站时，人流量增多，要留心行李，防止有人顺手牵羊。发现可疑情况应及时与列车工作人员及乘警取得联系。",@"1",@"【今日大部转阴天】据@重庆天气 ，我市今天白天：阴天，沙坪坝、渝中、江北、南岸、九龙坡、大渡口、巴南，2℃-8℃；渝北、北碚，1℃-7℃。今晚到明天白天，各地阴天，部分地区有零星小雨。大部地区气温2～12℃，城口及东南部-3～11℃。主城区：阴天，4～8℃",@"#史上今日#【陆游说】纸上得来终觉浅，绝知此事要躬行。书到用时方恨少，事非经过不知难。山重水复疑无路，柳暗花明又一村。夜阑卧听风吹雨，铁马冰河人梦来。王师北定中原日，家祭无忘告乃翁。位卑未敢忘忧国。1211年的今天，爱国诗人陆游逝世，缅怀。",@"2",@"【这些地方很多人去过，但也一读就错】①浙江丽（lí）水 ；浙江台（tāi）州 ；②山东莒（jǔ）县；山东茌（chí）平；③河南柘（zhè）城；河南武陟（zhì） ；④湖南枨（chéng）冲；湖南筻（gàng）口；⑤安徽黟（yī）县；安徽濉（suī）溪；⑥四川珙（gǒng）县。",@"1",@"【原创诗歌】张塘银杏王",@"#温馨提示#注意道口安全，行人如要到达铁路另一边时，只有铁路道口和人行过道才能通过，不得穿越铁路，更不得翻越护栏横穿铁路，当行人通过铁路无人看守道口以及人行过道时，必须止步望，确认两端均无列车开来时，方能通行",@"a敬请关注a【安徽取消43项中央指定地方实施行政审批事项】近日，省政府下发文件，贯彻落实《国务院关于第一批取消62项中央指定地方实施行政审批事项的决定》，取消43项中央指定地方实施行政审批事项。各地、各部门要推进简政放权、放管结合、优化服务的部署要求，不得以任何形式变相审批",@"【越野车掉入湖面冰窟 铲车前来救援也“沦陷”】近日有网友曝光称，一辆黑色越野车开上北京颐和园后的野湖湖面后，不幸陷入冰窟。车主及时请来“救兵”铲车，结果“救兵”也不幸陷入冰窟。最终挖掘机出场才将两车救出。",@"2",@"纠结 纠结",@"#温馨提示#旅客朋友们外出旅行时应尽量避免携带大量现金，要用的钱最好事先备好，在车上买饭或购物前，不要现场清点钱物。随身钞票最好零整分放，减少风险。在列车靠站时，人流量增多，要留心行李，防止有人顺手牵羊。发现可疑情况应及时与列车工作人员及乘警取得联系。",@"【今日大部转阴天】据@重庆天气 ，我市今天白天：阴天，沙坪坝、渝中、江北、南岸、九龙坡、大渡口、巴南，2℃-8℃；渝北、北碚，1℃-7℃。今晚到明天白天，各地阴天，部分地区有零星小雨。大部地区气温2～12℃，城口及东南部-3～11℃。主城区：阴天，4～8℃",@"a史上今日a【陆游说】纸上得来终觉浅，绝知此事要躬行。书到用时方恨少，事非经过不知难。山重水复疑无路，柳暗花明又一村。夜阑卧听风吹雨，铁马冰河人梦来。王师北定中原日，家祭无忘告乃翁。位卑未敢忘忧国。1211年的今天，爱国诗人陆游逝世，缅怀。",@"【这些地方很多人去过，但也一读就错】①浙江丽（lí）水 ；浙江台（tāi）州 ；②山东莒（jǔ）县；山东茌（chí）平；③河南柘（zhè）城；河南武陟（zhì） ；④湖南枨（chéng）冲；湖南筻（gàng）口；⑤安徽黟（yī）县；安徽濉（suī）溪；⑥四川珙（gǒng）县。",@"【原创诗歌】张塘银杏王",@"#温馨提示#注意道口安全，行人如要到达铁路另一边时，只有铁路道口和人行过道才能通过，不得穿越铁路，更不得翻越护栏横穿铁路，当行人通过铁路无人看守道口以及人行过道时，必须止步望，确认两端均无列车开来时，方能通行",@"a敬请关注a【安徽取消43项中央指定地方实施行政审批事项】近日，省政府下发文件，贯彻落实《国务院关于第一批取消62项中央指定地方实施行政审批事项的决定》，取消43项中央指定地方实施行政审批事项。各地、各部门要推进简政放权、放管结合、优化服务的部署要求，不得以任何形式变相审批",@"【越野车掉入湖面冰窟 铲车前来救援也“沦陷”】近日有网友曝光称，一辆黑色越野车开上北京颐和园后的野湖湖面后，不幸陷入冰窟。车主及时请来“救兵”铲车，结果“救兵”也不幸陷入冰窟。最终挖掘机出场才将两车救出。",@"2",@"纠结 纠结",@"#温馨提示#旅客朋友们外出旅行时应尽量避免携带大量现金，要用的钱最好事先备好，在车上买饭或购物前，不要现场清点钱物。随身钞票最好零整分放，减少风险。在列车靠站时，人流量增多，要留心行李，防止有人顺手牵羊。发现可疑情况应及时与列车工作人员及乘警取得联系。",@"【今日大部转阴天】据@重庆天气 ，我市今天白天：阴天，沙坪坝、渝中、江北、南岸、九龙坡、大渡口、巴南，2℃-8℃；渝北、北碚，1℃-7℃。今晚到明天白天，各地阴天，部分地区有零星小雨。大部地区气温2～12℃，城口及东南部-3～11℃。主城区：阴天，4～8℃",@"a史上今日a【陆游说】纸上得来终觉浅，绝知此事要躬行。书到用时方恨少，事非经过不知难。山重水复疑无路，柳暗花明又一村。夜阑卧听风吹雨，铁马冰河人梦来。王师北定中原日，家祭无忘告乃翁。位卑未敢忘忧国。1211年的今天，爱国诗人陆游逝世，缅怀。",@"【这些地方很多人去过，但也一读就错】①浙江丽（lí）水 ；浙江台（tāi）州 ；②山东莒（jǔ）县；山东茌（chí）平；③河南柘（zhè）城；河南武陟（zhì） ；④湖南枨（chéng）冲；湖南筻（gàng）口；⑤安徽黟（yī）县；安徽濉（suī）溪；⑥四川珙（gǒng）县。",@"【原创诗歌】张塘银杏王",@"#温馨提示#注意道口安全，行人如要到达铁路另一边时，只有铁路道口和人行过道才能通过，不得穿越铁路，更不得翻越护栏横穿铁路，当行人通过铁路无人看守道口以及人行过道时，必须止步望，确认两端均无列车开来时，方能通行",@"a敬请关注a【安徽取消43项中央指定地方实施行政审批事项】近日，省政府下发文件，贯彻落实《国务院关于第一批取消62项中央指定地方实施行政审批事项的决定》，取消43项中央指定地方实施行政审批事项。各地、各部门要推进简政放权、放管结合、优化服务的部署要求，不得以任何形式变相审批",@"【越野车掉入湖面冰窟 铲车前来救援也“沦陷”】近日有网友曝光称，一辆黑色越野车开上北京颐和园后的野湖湖面后，不幸陷入冰窟。车主及时请来“救兵”铲车，结果“救兵”也不幸陷入冰窟。最终挖掘机出场才将两车救出。",@"2",@"纠结 纠结",@"#温馨提示#旅客朋友们外出旅行时应尽量避免携带大量现金，要用的钱最好事先备好，在车上买饭或购物前，不要现场清点钱物。随身钞票最好零整分放，减少风险。在列车靠站时，人流量增多，要留心行李，防止有人顺手牵羊。发现可疑情况应及时与列车工作人员及乘警取得联系。",@"【今日大部转阴天】据@重庆天气 ，我市今天白天：阴天，沙坪坝、渝中、江北、南岸、九龙坡、大渡口、巴南，2℃-8℃；渝北、北碚，1℃-7℃。今晚到明天白天，各地阴天，部分地区有零星小雨。大部地区气温2～12℃，城口及东南部-3～11℃。主城区：阴天，4～8℃",@"a史上今日a【陆游说】纸上得来终觉浅，绝知此事要躬行。书到用时方恨少，事非经过不知难。山重水复疑无路，柳暗花明又一村。夜阑卧听风吹雨，铁马冰河人梦来。王师北定中原日，家祭无忘告乃翁。位卑未敢忘忧国。1211年的今天，爱国诗人陆游逝世，缅怀。",@"【这些地方很多人去过，但也一读就错】①浙江丽（lí）水 ；浙江台（tāi）州 ；②山东莒（jǔ）县；山东茌（chí）平；③河南柘（zhè）城；河南武陟（zhì） ；④湖南枨（chéng）冲；湖南筻（gàng）口；⑤安徽黟（yī）县；安徽濉（suī）溪；⑥四川珙（gǒng）县。",@"【原创诗歌】张塘银杏王",@"#温馨提示#注意道口安全，行人如要到达铁路另一边时，只有铁路道口和人行过道才能通过，不得穿越铁路，更不得翻越护栏横穿铁路，当行人通过铁路无人看守道口以及人行过道时，必须止步望，确认两端均无列车开来时，方能通行",@"a敬请关注a【安徽取消43项中央指定地方实施行政审批事项】近日，省政府下发文件，贯彻落实《国务院关于第一批取消62项中央指定地方实施行政审批事项的决定》，取消43项中央指定地方实施行政审批事项。各地、各部门要推进简政放权、放管结合、优化服务的部署要求，不得以任何形式变相审批",@"【越野车掉入湖面冰窟 铲车前来救援也“沦陷”】近日有网友曝光称，一辆黑色越野车开上北京颐和园后的野湖湖面后，不幸陷入冰窟。车主及时请来“救兵”铲车，结果“救兵”也不幸陷入冰窟。最终挖掘机出场才将两车救出。",@"2",@"纠结 纠结",@"#温馨提示#旅客朋友们外出旅行时应尽量避免携带大量现金，要用的钱最好事先备好，在车上买饭或购物前，不要现场清点钱物。随身钞票最好零整分放，减少风险。在列车靠站时，人流量增多，要留心行李，防止有人顺手牵羊。发现可疑情况应及时与列车工作人员及乘警取得联系。",@"【今日大部转阴天】据@重庆天气 ，我市今天白天：阴天，沙坪坝、渝中、江北、南岸、九龙坡、大渡口、巴南，2℃-8℃；渝北、北碚，1℃-7℃。今晚到明天白天，各地阴天，部分地区有零星小雨。大部地区气温2～12℃，城口及东南部-3～11℃。主城区：阴天，4～8℃",@"a史上今日a【陆游说】纸上得来终觉浅，绝知此事要躬行。书到用时方恨少，事非经过不知难。山重水复疑无路，柳暗花明又一村。夜阑卧听风吹雨，铁马冰河人梦来。王师北定中原日，家祭无忘告乃翁。位卑未敢忘忧国。1211年的今天，爱国诗人陆游逝世，缅怀。",@"【这些地方很多人去过，但也一读就错】①浙江丽（lí）水 ；浙江台（tāi）州 ；②山东莒（jǔ）县；山东茌（chí）平；③河南柘（zhè）城；河南武陟（zhì） ；④湖南枨（chéng）冲；湖南筻（gàng）口；⑤安徽黟（yī）县；安徽濉（suī）溪；⑥四川珙（gǒng）县。",@"【原创诗歌】张塘银杏王",@"#温馨提示#注意道口安全，行人如要到达铁路另一边时，只有铁路道口和人行过道才能通过，不得穿越铁路，更不得翻越护栏横穿铁路，当行人通过铁路无人看守道口以及人行过道时，必须止步望，确认两端均无列车开来时，方能通行",@"a敬请关注a【安徽取消43项中央指定地方实施行政审批事项】近日，省政府下发文件，贯彻落实《国务院关于第一批取消62项中央指定地方实施行政审批事项的决定》，取消43项中央指定地方实施行政审批事项。各地、各部门要推进简政放权、放管结合、优化服务的部署要求，不得以任何形式变相审批",@"【越野车掉入湖面冰窟 铲车前来救援也“沦陷”】近日有网友曝光称，一辆黑色越野车开上北京颐和园后的野湖湖面后，不幸陷入冰窟。车主及时请来“救兵”铲车，结果“救兵”也不幸陷入冰窟。最终挖掘机出场才将两车救出。",@"2",@"纠结 纠结",@"#温馨提示#旅客朋友们外出旅行时应尽量避免携带大量现金，要用的钱最好事先备好，在车上买饭或购物前，不要现场清点钱物。随身钞票最好零整分放，减少风险。在列车靠站时，人流量增多，要留心行李，防止有人顺手牵羊。发现可疑情况应及时与列车工作人员及乘警取得联系。",@"【今日大部转阴天】据@重庆天气 ，我市今天白天：阴天，沙坪坝、渝中、江北、南岸、九龙坡、大渡口、巴南，2℃-8℃；渝北、北碚，1℃-7℃。今晚到明天白天，各地阴天，部分地区有零星小雨。大部地区气温2～12℃，城口及东南部-3～11℃。主城区：阴天，4～8℃",@"a史上今日a【陆游说】纸上得来终觉浅，绝知此事要躬行。书到用时方恨少，事非经过不知难。山重水复疑无路，柳暗花明又一村。夜阑卧听风吹雨，铁马冰河人梦来。王师北定中原日，家祭无忘告乃翁。位卑未敢忘忧国。1211年的今天，爱国诗人陆游逝世，缅怀。",@"【这些地方很多人去过，但也一读就错】①浙江丽（lí）水 ；浙江台（tāi）州 ；②山东莒（jǔ）县；山东茌（chí）平；③河南柘（zhè）城；河南武陟（zhì） ；④湖南枨（chéng）冲；湖南筻（gàng）口；⑤安徽黟（yī）县；安徽濉（suī）溪；⑥四川珙（gǒng）县。",@"【原创诗歌】张塘银杏王",@"#温馨提示#注意道口安全，行人如要到达铁路另一边时，只有铁路道口和人行过道才能通过，不得穿越铁路，更不得翻越护栏横穿铁路，当行人通过铁路无人看守道口以及人行过道时，必须止步望，确认两端均无列车开来时，方能通行",@"a敬请关注a【安徽取消43项中央指定地方实施行政审批事项】近日，省政府下发文件，贯彻落实《国务院关于第一批取消62项中央指定地方实施行政审批事项的决定》，取消43项中央指定地方实施行政审批事项。各地、各部门要推进简政放权、放管结合、优化服务的部署要求，不得以任何形式变相审批",@"【越野车掉入湖面冰窟 铲车前来救援也“沦陷”】近日有网友曝光称，一辆黑色越野车开上北京颐和园后的野湖湖面后，不幸陷入冰窟。车主及时请来“救兵”铲车，结果“救兵”也不幸陷入冰窟。最终挖掘机出场才将两车救出。",@"2",@"纠结 纠结",@"#温馨提示#旅客朋友们外出旅行时应尽量避免携带大量现金，要用的钱最好事先备好，在车上买饭或购物前，不要现场清点钱物。随身钞票最好零整分放，减少风险。在列车靠站时，人流量增多，要留心行李，防止有人顺手牵羊。发现可疑情况应及时与列车工作人员及乘警取得联系。",@"【今日大部转阴天】据@重庆天气 ，我市今天白天：阴天，沙坪坝、渝中、江北、南岸、九龙坡、大渡口、巴南，2℃-8℃；渝北、北碚，1℃-7℃。今晚到明天白天，各地阴天，部分地区有零星小雨。大部地区气温2～12℃，城口及东南部-3～11℃。主城区：阴天，4～8℃",@"a史上今日a【陆游说】纸上得来终觉浅，绝知此事要躬行。书到用时方恨少，事非经过不知难。山重水复疑无路，柳暗花明又一村。夜阑卧听风吹雨，铁马冰河人梦来。王师北定中原日，家祭无忘告乃翁。位卑未敢忘忧国。1211年的今天，爱国诗人陆游逝世，缅怀。",@"【这些地方很多人去过，但也一读就错】①浙江丽（lí）水 ；浙江台（tāi）州 ；②山东莒（jǔ）县；山东茌（chí）平；③河南柘（zhè）城；河南武陟（zhì） ；④湖南枨（chéng）冲；湖南筻（gàng）口；⑤安徽黟（yī）县；安徽濉（suī）溪；⑥四川珙（gǒng）县。",@"【原创诗歌】张塘银杏王",@"#温馨提示#注意道口安全，行人如要到达铁路另一边时，只有铁路道口和人行过道才能通过，不得穿越铁路，更不得翻越护栏横穿铁路，当行人通过铁路无人看守道口以及人行过道时，必须止步望，确认两端均无列车开来时，方能通行",@"a敬请关注a【安徽取消43项中央指定地方实施行政审批事项】近日，省政府下发文件，贯彻落实《国务院关于第一批取消62项中央指定地方实施行政审批事项的决定》，取消43项中央指定地方实施行政审批事项。各地、各部门要推进简政放权、放管结合、优化服务的部署要求，不得以任何形式变相审批",@"【越野车掉入湖面冰窟 铲车前来救援也“沦陷”】近日有网友曝光称，一辆黑色越野车开上北京颐和园后的野湖湖面后，不幸陷入冰窟。车主及时请来“救兵”铲车，结果“救兵”也不幸陷入冰窟。最终挖掘机出场才将两车救出。",@"2",@"纠结 纠结",@"#温馨提示#旅客朋友们外出旅行时应尽量避免携带大量现金，要用的钱最好事先备好，在车上买饭或购物前，不要现场清点钱物。随身钞票最好零整分放，减少风险。在列车靠站时，人流量增多，要留心行李，防止有人顺手牵羊。发现可疑情况应及时与列车工作人员及乘警取得联系。",@"【今日大部转阴天】据@重庆天气 ，我市今天白天：阴天，沙坪坝、渝中、江北、南岸、九龙坡、大渡口、巴南，2℃-8℃；渝北、北碚，1℃-7℃。今晚到明天白天，各地阴天，部分地区有零星小雨。大部地区气温2～12℃，城口及东南部-3～11℃。主城区：阴天，4～8℃",@"a史上今日a【陆游说】纸上得来终觉浅，绝知此事要躬行。书到用时方恨少，事非经过不知难。山重水复疑无路，柳暗花明又一村。夜阑卧听风吹雨，铁马冰河人梦来。王师北定中原日，家祭无忘告乃翁。位卑未敢忘忧国。1211年的今天，爱国诗人陆游逝世，缅怀。",@"【这些地方很多人去过，但也一读就错】①浙江丽（lí）水 ；浙江台（tāi）州 ；②山东莒（jǔ）县；山东茌（chí）平；③河南柘（zhè）城；河南武陟（zhì） ；④湖南枨（chéng）冲；湖南筻（gàng）口；⑤安徽黟（yī）县；安徽濉（suī）溪；⑥四川珙（gǒng）县。",@"【原创诗歌】张塘银杏王",@"#温馨提示#注意道口安全，行人如要到达铁路另一边时，只有铁路道口和人行过道才能通过，不得穿越铁路，更不得翻越护栏横穿铁路，当行人通过铁路无人看守道口以及人行过道时，必须止步望，确认两端均无列车开来时，方能通行",@"a敬请关注a【安徽取消43项中央指定地方实施行政审批事项】近日，省政府下发文件，贯彻落实《国务院关于第一批取消62项中央指定地方实施行政审批事项的决定》，取消43项中央指定地方实施行政审批事项。各地、各部门要推进简政放权、放管结合、优化服务的部署要求，不得以任何形式变相审批",@"【越野车掉入湖面冰窟 铲车前来救援也“沦陷”】近日有网友曝光称，一辆黑色越野车开上北京颐和园后的野湖湖面后，不幸陷入冰窟。车主及时请来“救兵”铲车，结果“救兵”也不幸陷入冰窟。最终挖掘机出场才将两车救出。",@"2",@"纠结 纠结",@"#温馨提示#旅客朋友们外出旅行时应尽量避免携带大量现金，要用的钱最好事先备好，在车上买饭或购物前，不要现场清点钱物。随身钞票最好零整分放，减少风险。在列车靠站时，人流量增多，要留心行李，防止有人顺手牵羊。发现可疑情况应及时与列车工作人员及乘警取得联系。",@"【今日大部转阴天】据@重庆天气 ，我市今天白天：阴天，沙坪坝、渝中、江北、南岸、九龙坡、大渡口、巴南，2℃-8℃；渝北、北碚，1℃-7℃。今晚到明天白天，各地阴天，部分地区有零星小雨。大部地区气温2～12℃，城口及东南部-3～11℃。主城区：阴天，4～8℃",@"a史上今日a【陆游说】纸上得来终觉浅，绝知此事要躬行。书到用时方恨少，事非经过不知难。山重水复疑无路，柳暗花明又一村。夜阑卧听风吹雨，铁马冰河人梦来。王师北定中原日，家祭无忘告乃翁。位卑未敢忘忧国。1211年的今天，爱国诗人陆游逝世，缅怀。",@"【这些地方很多人去过，但也一读就错】①浙江丽（lí）水 ；浙江台（tāi）州 ；②山东莒（jǔ）县；山东茌（chí）平；③河南柘（zhè）城；河南武陟（zhì） ；④湖南枨（chéng）冲；湖南筻（gàng）口；⑤安徽黟（yī）县；安徽濉（suī）溪；⑥四川珙（gǒng）县。",@"【原创诗歌】张塘银杏王",@"#温馨提示#注意道口安全，行人如要到达铁路另一边时，只有铁路道口和人行过道才能通过，不得穿越铁路，更不得翻越护栏横穿铁路，当行人通过铁路无人看守道口以及人行过道时，必须止步望，确认两端均无列车开来时，方能通行",@"a敬请关注a【安徽取消43项中央指定地方实施行政审批事项】近日，省政府下发文件，贯彻落实《国务院关于第一批取消62项中央指定地方实施行政审批事项的决定》，取消43项中央指定地方实施行政审批事项。各地、各部门要推进简政放权、放管结合、优化服务的部署要求，不得以任何形式变相审批",@"【越野车掉入湖面冰窟 铲车前来救援也“沦陷”】近日有网友曝光称，一辆黑色越野车开上北京颐和园后的野湖湖面后，不幸陷入冰窟。车主及时请来“救兵”铲车，结果“救兵”也不幸陷入冰窟。最终挖掘机出场才将两车救出。",@"2",@"纠结 纠结",@"#温馨提示#旅客朋友们外出旅行时应尽量避免携带大量现金，要用的钱最好事先备好，在车上买饭或购物前，不要现场清点钱物。随身钞票最好零整分放，减少风险。在列车靠站时，人流量增多，要留心行李，防止有人顺手牵羊。发现可疑情况应及时与列车工作人员及乘警取得联系。",@"【今日大部转阴天】据@重庆天气 ，我市今天白天：阴天，沙坪坝、渝中、江北、南岸、九龙坡、大渡口、巴南，2℃-8℃；渝北、北碚，1℃-7℃。今晚到明天白天，各地阴天，部分地区有零星小雨。大部地区气温2～12℃，城口及东南部-3～11℃。主城区：阴天，4～8℃",@"a史上今日a【陆游说】纸上得来终觉浅，绝知此事要躬行。书到用时方恨少，事非经过不知难。山重水复疑无路，柳暗花明又一村。夜阑卧听风吹雨，铁马冰河人梦来。王师北定中原日，家祭无忘告乃翁。位卑未敢忘忧国。1211年的今天，爱国诗人陆游逝世，缅怀。",@"【这些地方很多人去过，但也一读就错】①浙江丽（lí）水 ；浙江台（tāi）州 ；②山东莒（jǔ）县；山东茌（chí）平；③河南柘（zhè）城；河南武陟（zhì） ；④湖南枨（chéng）冲；湖南筻（gàng）口；⑤安徽黟（yī）县；安徽濉（suī）溪；⑥四川珙（gǒng）县。",@"【原创诗歌】张塘银杏王",@"#温馨提示#注意道口安全，行人如要到达铁路另一边时，只有铁路道口和人行过道才能通过，不得穿越铁路，更不得翻越护栏横穿铁路，当行人通过铁路无人看守道口以及人行过道时，必须止步望，确认两端均无列车开来时，方能通行",@"a敬请关注a【安徽取消43项中央指定地方实施行政审批事项】近日，省政府下发文件，贯彻落实《国务院关于第一批取消62项中央指定地方实施行政审批事项的决定》，取消43项中央指定地方实施行政审批事项。各地、各部门要推进简政放权、放管结合、优化服务的部署要求，不得以任何形式变相审批",@"【越野车掉入湖面冰窟 铲车前来救援也“沦陷”】近日有网友曝光称，一辆黑色越野车开上北京颐和园后的野湖湖面后，不幸陷入冰窟。车主及时请来“救兵”铲车，结果“救兵”也不幸陷入冰窟。最终挖掘机出场才将两车救出。",@"2",@"纠结 纠结",@"#温馨提示#旅客朋友们外出旅行时应尽量避免携带大量现金，要用的钱最好事先备好，在车上买饭或购物前，不要现场清点钱物。随身钞票最好零整分放，减少风险。在列车靠站时，人流量增多，要留心行李，防止有人顺手牵羊。发现可疑情况应及时与列车工作人员及乘警取得联系。",@"【今日大部转阴天】据@重庆天气 ，我市今天白天：阴天，沙坪坝、渝中、江北、南岸、九龙坡、大渡口、巴南，2℃-8℃；渝北、北碚，1℃-7℃。今晚到明天白天，各地阴天，部分地区有零星小雨。大部地区气温2～12℃，城口及东南部-3～11℃。主城区：阴天，4～8℃",@"a史上今日a【陆游说】纸上得来终觉浅，绝知此事要躬行。书到用时方恨少，事非经过不知难。山重水复疑无路，柳暗花明又一村。夜阑卧听风吹雨，铁马冰河人梦来。王师北定中原日，家祭无忘告乃翁。位卑未敢忘忧国。1211年的今天，爱国诗人陆游逝世，缅怀。",@"【这些地方很多人去过，但也一读就错】①浙江丽（lí）水 ；浙江台（tāi）州 ；②山东莒（jǔ）县；山东茌（chí）平；③河南柘（zhè）城；河南武陟（zhì） ；④湖南枨（chéng）冲；湖南筻（gàng）口；⑤安徽黟（yī）县；安徽濉（suī）溪；⑥四川珙（gǒng）县。",@"【原创诗歌】张塘银杏王",@"#温馨提示#注意道口安全，行人如要到达铁路另一边时，只有铁路道口和人行过道才能通过，不得穿越铁路，更不得翻越护栏横穿铁路，当行人通过铁路无人看守道口以及人行过道时，必须止步望，确认两端均无列车开来时，方能通行",@"a敬请关注a【安徽取消43项中央指定地方实施行政审批事项】近日，省政府下发文件，贯彻落实《国务院关于第一批取消62项中央指定地方实施行政审批事项的决定》，取消43项中央指定地方实施行政审批事项。各地、各部门要推进简政放权、放管结合、优化服务的部署要求，不得以任何形式变相审批",@"【越野车掉入湖面冰窟 铲车前来救援也“沦陷”】近日有网友曝光称，一辆黑色越野车开上北京颐和园后的野湖湖面后，不幸陷入冰窟。车主及时请来“救兵”铲车，结果“救兵”也不幸陷入冰窟。最终挖掘机出场才将两车救出。",@"2",@"纠结 纠结",@"#温馨提示#旅客朋友们外出旅行时应尽量避免携带大量现金，要用的钱最好事先备好，在车上买饭或购物前，不要现场清点钱物。随身钞票最好零整分放，减少风险。在列车靠站时，人流量增多，要留心行李，防止有人顺手牵羊。发现可疑情况应及时与列车工作人员及乘警取得联系。",@"【今日大部转阴天】据@重庆天气 ，我市今天白天：阴天，沙坪坝、渝中、江北、南岸、九龙坡、大渡口、巴南，2℃-8℃；渝北、北碚，1℃-7℃。今晚到明天白天，各地阴天，部分地区有零星小雨。大部地区气温2～12℃，城口及东南部-3～11℃。主城区：阴天，4～8℃",@"a史上今日a【陆游说】纸上得来终觉浅，绝知此事要躬行。书到用时方恨少，事非经过不知难。山重水复疑无路，柳暗花明又一村。夜阑卧听风吹雨，铁马冰河人梦来。王师北定中原日，家祭无忘告乃翁。位卑未敢忘忧国。1211年的今天，爱国诗人陆游逝世，缅怀。",@"【这些地方很多人去过，但也一读就错】①浙江丽（lí）水 ；浙江台（tāi）州 ；②山东莒（jǔ）县；山东茌（chí）平；③河南柘（zhè）城；河南武陟（zhì） ；④湖南枨（chéng）冲；湖南筻（gàng）口；⑤安徽黟（yī）县；安徽濉（suī）溪；⑥四川珙（gǒng）县。",@"【原创诗歌】张塘银杏王",@"#温馨提示#注意道口安全，行人如要到达铁路另一边时，只有铁路道口和人行过道才能通过，不得穿越铁路，更不得翻越护栏横穿铁路，当行人通过铁路无人看守道口以及人行过道时，必须止步望，确认两端均无列车开来时，方能通行",@"a敬请关注a【安徽取消43项中央指定地方实施行政审批事项】近日，省政府下发文件，贯彻落实《国务院关于第一批取消62项中央指定地方实施行政审批事项的决定》，取消43项中央指定地方实施行政审批事项。各地、各部门要推进简政放权、放管结合、优化服务的部署要求，不得以任何形式变相审批",@"【越野车掉入湖面冰窟 铲车前来救援也“沦陷”】近日有网友曝光称，一辆黑色越野车开上北京颐和园后的野湖湖面后，不幸陷入冰窟。车主及时请来“救兵”铲车，结果“救兵”也不幸陷入冰窟。最终挖掘机出场才将两车救出。",@"2",@"纠结 纠结",@"#温馨提示#旅客朋友们外出旅行时应尽量避免携带大量现金，要用的钱最好事先备好，在车上买饭或购物前，不要现场清点钱物。随身钞票最好零整分放，减少风险。在列车靠站时，人流量增多，要留心行李，防止有人顺手牵羊。发现可疑情况应及时与列车工作人员及乘警取得联系。",@"【今日大部转阴天】据@重庆天气 ，我市今天白天：阴天，沙坪坝、渝中、江北、南岸、九龙坡、大渡口、巴南，2℃-8℃；渝北、北碚，1℃-7℃。今晚到明天白天，各地阴天，部分地区有零星小雨。大部地区气温2～12℃，城口及东南部-3～11℃。主城区：阴天，4～8℃",@"a史上今日a【陆游说】纸上得来终觉浅，绝知此事要躬行。书到用时方恨少，事非经过不知难。山重水复疑无路，柳暗花明又一村。夜阑卧听风吹雨，铁马冰河人梦来。王师北定中原日，家祭无忘告乃翁。位卑未敢忘忧国。1211年的今天，爱国诗人陆游逝世，缅怀。",@"【这些地方很多人去过，但也一读就错】①浙江丽（lí）水 ；浙江台（tāi）州 ；②山东莒（jǔ）县；山东茌（chí）平；③河南柘（zhè）城；河南武陟（zhì） ；④湖南枨（chéng）冲；湖南筻（gàng）口；⑤安徽黟（yī）县；安徽濉（suī）溪；⑥四川珙（gǒng）县。",@"【原创诗歌】张塘银杏王",@"#温馨提示#注意道口安全，行人如要到达铁路另一边时，只有铁路道口和人行过道才能通过，不得穿越铁路，更不得翻越护栏横穿铁路，当行人通过铁路无人看守道口以及人行过道时，必须止步望，确认两端均无列车开来时，方能通行",@"a敬请关注a【安徽取消43项中央指定地方实施行政审批事项】近日，省政府下发文件，贯彻落实《国务院关于第一批取消62项中央指定地方实施行政审批事项的决定》，取消43项中央指定地方实施行政审批事项。各地、各部门要推进简政放权、放管结合、优化服务的部署要求，不得以任何形式变相审批",@"【越野车掉入湖面冰窟 铲车前来救援也“沦陷”】近日有网友曝光称，一辆黑色越野车开上北京颐和园后的野湖湖面后，不幸陷入冰窟。车主及时请来“救兵”铲车，结果“救兵”也不幸陷入冰窟。最终挖掘机出场才将两车救出。",@"2",@"纠结 纠结",@"#温馨提示#旅客朋友们外出旅行时应尽量避免携带大量现金，要用的钱最好事先备好，在车上买饭或购物前，不要现场清点钱物。随身钞票最好零整分放，减少风险。在列车靠站时，人流量增多，要留心行李，防止有人顺手牵羊。发现可疑情况应及时与列车工作人员及乘警取得联系。",@"【今日大部转阴天】据@重庆天气 ，我市今天白天：阴天，沙坪坝、渝中、江北、南岸、九龙坡、大渡口、巴南，2℃-8℃；渝北、北碚，1℃-7℃。今晚到明天白天，各地阴天，部分地区有零星小雨。大部地区气温2～12℃，城口及东南部-3～11℃。主城区：阴天，4～8℃",@"a史上今日a【陆游说】纸上得来终觉浅，绝知此事要躬行。书到用时方恨少，事非经过不知难。山重水复疑无路，柳暗花明又一村。夜阑卧听风吹雨，铁马冰河人梦来。王师北定中原日，家祭无忘告乃翁。位卑未敢忘忧国。1211年的今天，爱国诗人陆游逝世，缅怀。",@"【这些地方很多人去过，但也一读就错】①浙江丽（lí）水 ；浙江台（tāi）州 ；②山东莒（jǔ）县；山东茌（chí）平；③河南柘（zhè）城；河南武陟（zhì） ；④湖南枨（chéng）冲；湖南筻（gàng）口；⑤安徽黟（yī）县；安徽濉（suī）溪；⑥四川珙（gǒng）县。",@"【原创诗歌】张塘银杏王",@"#温馨提示#注意道口安全，行人如要到达铁路另一边时，只有铁路道口和人行过道才能通过，不得穿越铁路，更不得翻越护栏横穿铁路，当行人通过铁路无人看守道口以及人行过道时，必须止步望，确认两端均无列车开来时，方能通行",@"a敬请关注a【安徽取消43项中央指定地方实施行政审批事项】近日，省政府下发文件，贯彻落实《国务院关于第一批取消62项中央指定地方实施行政审批事项的决定》，取消43项中央指定地方实施行政审批事项。各地、各部门要推进简政放权、放管结合、优化服务的部署要求，不得以任何形式变相审批",@"【越野车掉入湖面冰窟 铲车前来救援也“沦陷”】近日有网友曝光称，一辆黑色越野车开上北京颐和园后的野湖湖面后，不幸陷入冰窟。车主及时请来“救兵”铲车，结果“救兵”也不幸陷入冰窟。最终挖掘机出场才将两车救出。",@"2",@"纠结 纠结",@"#温馨提示#旅客朋友们外出旅行时应尽量避免携带大量现金，要用的钱最好事先备好，在车上买饭或购物前，不要现场清点钱物。随身钞票最好零整分放，减少风险。在列车靠站时，人流量增多，要留心行李，防止有人顺手牵羊。发现可疑情况应及时与列车工作人员及乘警取得联系。",@"【今日大部转阴天】据@重庆天气 ，我市今天白天：阴天，沙坪坝、渝中、江北、南岸、九龙坡、大渡口、巴南，2℃-8℃；渝北、北碚，1℃-7℃。今晚到明天白天，各地阴天，部分地区有零星小雨。大部地区气温2～12℃，城口及东南部-3～11℃。主城区：阴天，4～8℃",@"a史上今日a【陆游说】纸上得来终觉浅，绝知此事要躬行。书到用时方恨少，事非经过不知难。山重水复疑无路，柳暗花明又一村。夜阑卧听风吹雨，铁马冰河人梦来。王师北定中原日，家祭无忘告乃翁。位卑未敢忘忧国。1211年的今天，爱国诗人陆游逝世，缅怀。",@"【这些地方很多人去过，但也一读就错】①浙江丽（lí）水 ；浙江台（tāi）州 ；②山东莒（jǔ）县；山东茌（chí）平；③河南柘（zhè）城；河南武陟（zhì） ；④湖南枨（chéng）冲；湖南筻（gàng）口；⑤安徽黟（yī）县；安徽濉（suī）溪；⑥四川珙（gǒng）县。",@"【原创诗歌】张塘银杏王",@"#温馨提示#注意道口安全，行人如要到达铁路另一边时，只有铁路道口和人行过道才能通过，不得穿越铁路，更不得翻越护栏横穿铁路，当行人通过铁路无人看守道口以及人行过道时，必须止步望，确认两端均无列车开来时，方能通行",@"a敬请关注a【安徽取消43项中央指定地方实施行政审批事项】近日，省政府下发文件，贯彻落实《国务院关于第一批取消62项中央指定地方实施行政审批事项的决定》，取消43项中央指定地方实施行政审批事项。各地、各部门要推进简政放权、放管结合、优化服务的部署要求，不得以任何形式变相审批",@"【越野车掉入湖面冰窟 铲车前来救援也“沦陷”】近日有网友曝光称，一辆黑色越野车开上北京颐和园后的野湖湖面后，不幸陷入冰窟。车主及时请来“救兵”铲车，结果“救兵”也不幸陷入冰窟。最终挖掘机出场才将两车救出。"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end