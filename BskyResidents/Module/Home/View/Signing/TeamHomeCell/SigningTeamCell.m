//
//  SigningTeamCell.m
//  BskyResidents
//
//  Created by 何雷 on 2017/10/13.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "SigningTeamCell.h"
#import <YYText/YYText.h>
@interface SigningTeamCell()

@property (weak, nonatomic) IBOutlet UILabel *teamNameLabel;
@property (weak, nonatomic) IBOutlet YYLabel *desLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;

@property (nonatomic ,copy) NSString *desString;

@end


@implementation SigningTeamCell

static NSInteger const kSigningTeamBtnTag = 400;

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.desLabel.width = Bsky_SCREEN_WIDTH-100;
    self.desLabel.preferredMaxLayoutWidth = self.desLabel.width;
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)dealloc
{
    NSLog(@"撒安徽达克赛德还房贷撒谎发独守空房说的");
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}
- (void)setTeamModel:(SignTeamModel *)teamModel
{
    _teamModel = teamModel;
    self.teamNameLabel.text = _teamModel.team.orgName;
    self.typeLabel.text = _teamModel.team.teamType;
    self.numLabel.text = _teamModel.team.quantity;
    self.desString = _teamModel.team.remark;
}
- (void)setMemberListModel:(SignTeamMemberListModel *)memberListModel
{
    _memberListModel = memberListModel;
    [self addMember];
}
- (void)setIsExpansion:(BOOL)isExpansion
{
    _isExpansion = isExpansion;
    if (self.desString.length < 1) {
        return;
    }
    if (isExpansion) {
        NSString *string =  [NSString stringWithFormat:@"%@    收起",self.desString];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:string];
        attrStr.yy_color = Bsky_UIColorFromRGB(0x808080);
        attrStr.yy_font = [UIFont systemFontOfSize:13];
        attrStr.yy_lineSpacing = 3;
        [attrStr yy_setTextHighlightRange:NSMakeRange(string.length-5, 5) color:Bsky_UIColorFromRGB(0x4e7dd3) backgroundColor:nil tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            if (self.expansion) {
                self.expansion(NO);
                self.expansion = nil;
            }
        }];
        self.desLabel.attributedText = attrStr;
        self.desLabel.numberOfLines = 0;
        [self.desLabel sizeToFit];
    }
    else
    {
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:_desString];
        attrStr.yy_color = Bsky_UIColorFromRGB(0x808080);
        attrStr.yy_font = [UIFont systemFontOfSize:13];
        attrStr.yy_lineSpacing = 3;
        self.desLabel.attributedText = attrStr;
        self.desLabel.numberOfLines = 2;
        [self.desLabel sizeToFit];
        [self addSeeMoreButton];
    }
}
- (void)addSeeMoreButton {
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]
                                       initWithString:@"...   展开"];
    @weakify(self);
    YYTextHighlight *hi = [YYTextHighlight new];
    [hi setColor:Bsky_UIColorFromRGB(0x4e7dd3)];
    hi.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        @strongify(self);
        if (self.expansion) {
            self.expansion(YES);
            self.expansion = nil;
        }
    };

    [text yy_setColor:Bsky_UIColorFromRGB(0x4e7dd3) range:[text.string rangeOfString:@"   展开"]];
    [text yy_setTextHighlight:hi range:[text.string rangeOfString:@"   展开"]];
    text.yy_font = [UIFont systemFontOfSize:13.f];

    YYLabel *seeMore = [YYLabel new];
    seeMore.attributedText = text;
    [seeMore sizeToFit];

    NSAttributedString *truncationToken = [NSAttributedString yy_attachmentStringWithContent:seeMore contentMode:UIViewContentModeCenter attachmentSize:seeMore.size alignToFont:text.yy_font alignment:YYTextVerticalAlignmentTop];
    self.desLabel.truncationToken = truncationToken;
}
- (void)addMember
{
    self.scrollView.width = Bsky_SCREEN_WIDTH - 90;
    CGFloat width = self.scrollView.width/3;
    
    for (int i = 0; i< self.memberListModel.memberList.count; i++) {
        
        SignTeamMemberModel *memberModel = self.memberListModel.memberList[i];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor whiteColor];
        btn.frame = CGRectMake(i*width ,0, width, self.scrollView.height);
        btn.tag = kSigningTeamBtnTag + i;
        [btn addTarget:self action:@selector(itemBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:btn];
        
        UIImageView *icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"doctor_icon"]];
        UIImage *decodedImage = [UIImage imageWithBase64Str:memberModel.photo];
        if (decodedImage) {
            icon.image = decodedImage;
        }
        icon.userInteractionEnabled = NO;
        icon.frame = CGRectMake(0, 0, 50, 50);
        icon.center = CGPointMake(btn.width/2, icon.height/2);
        [icon setCornerRadius:icon.width/2];
        [btn addSubview:icon];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.textColor = Bsky_UIColorFromRGB(0x333333);
        titleLabel.text = memberModel.memberName;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [titleLabel sizeToFit];
        titleLabel.frame = CGRectMake(0, icon.bottom+5, btn.width, titleLabel.height);
        [btn addSubview:titleLabel];
        
        UILabel *tagLabel = [[UILabel alloc]init];
        tagLabel.font = [UIFont systemFontOfSize:11];
        tagLabel.textColor = Bsky_UIColorFromRGB(0x27d0be);
        tagLabel.text = memberModel.professional;
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.layer.borderColor = Bsky_UIColorFromRGB(0x3cdfce).CGColor;
        tagLabel.layer.borderWidth = 0.5;
        [tagLabel setCornerRadius:3];
        [tagLabel sizeToFit];
        tagLabel.bottom = btn.height;
        tagLabel.center = CGPointMake(btn.width/2, tagLabel.center.y-3);
        tagLabel.width = tagLabel.width+5;
        tagLabel.height = tagLabel.height+3;
        [btn addSubview:tagLabel];
        if (i == self.memberListModel.memberList.count - 1) {
            self.scrollView.contentSize = CGSizeMake(btn.right, self.scrollView.height);
        }
    }
}
#pragma mark ---- click

- (IBAction)leftBtnPressed:(UIButton *)sender {
    CGFloat itemWidth = self.scrollView.width/3;
    CGPoint contentOffset = self.scrollView.contentOffset;
    if (contentOffset.x <= 3) {
        return;
    }
    self.scrollView.contentOffset = CGPointMake(contentOffset.x - itemWidth, contentOffset.y);
}
- (IBAction)rightBtnPressed:(UIButton *)sender {
    CGFloat itemWidth = self.scrollView.width/3;
    CGPoint contentOffset = self.scrollView.contentOffset;
    CGFloat width = self.scrollView.contentSize.width - self.scrollView.width;
    if (contentOffset.x >= width - 3) {
        return;
    }
    self.scrollView.contentOffset = CGPointMake(contentOffset.x + itemWidth, contentOffset.y);
}
- (void)itemBtnPressed:(UIButton *)sender
{
    NSInteger index = sender.tag - kSigningTeamBtnTag;
    if (self.selectedIndex) {
        self.selectedIndex(index);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
        CGFloat width = self.scrollView.contentSize.width - self.scrollView.width;
        
        if (self.memberListModel.memberList.count <= 3) {
            self.leftBtn.hidden = YES;
            self.rightBtn.hidden = YES;
        }
        else if (self.scrollView.contentOffset.x < 3) {
            self.leftBtn.hidden = YES;
            self.rightBtn.hidden = NO;
        }
        else if (self.scrollView.contentOffset.x >= width - 3)
        {
            self.leftBtn.hidden = NO;
            self.rightBtn.hidden = YES;
        }
        else
        {
            self.leftBtn.hidden = NO;
            self.rightBtn.hidden = NO;
        }
        
    }
}

@end
