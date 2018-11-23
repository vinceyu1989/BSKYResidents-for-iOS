//
//  DoctorExpertCell.m
//  BskyResidents
//
//  Created by 何雷 on 2017/10/12.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "DoctorExpertCell.h"
#import "YYText.h"

@interface DoctorExpertCell()

@property (nonatomic,strong)  YYLabel *desLabel;

@property (nonatomic ,copy) NSString *desString;

@end

@implementation DoctorExpertCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.desLabel = [[YYLabel alloc]initWithFrame:CGRectMake(0, 0, Bsky_SCREEN_WIDTH -30, 7)];
        self.desLabel.preferredMaxLayoutWidth = self.desLabel.width;
        [self addSubview:self.desLabel];
        [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self).offset(15);
            make.right.bottom.equalTo(self).offset(-15);
            make.width.equalTo(@(Bsky_SCREEN_WIDTH -30));
        }];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = Bsky_UIColorFromRGB(0xededed);
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.equalTo(@0.5);
        }];
    }
    return self;
}
- (void)setDesString:(NSString *)desString  expansion:(BOOL) isExpansion
{
    if (!desString || desString.length < 1) {
        self.desLabel.text = nil;
        return;
    }
    self.desString = desString;
    if (isExpansion) {
        NSString *string =  [NSString stringWithFormat:@"擅长：%@    收起",self.desString];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:string];
        attrStr.yy_color = Bsky_UIColorFromRGB(0x333333);
        attrStr.yy_font = [UIFont systemFontOfSize:13];
        [attrStr yy_setFont:[UIFont boldSystemFontOfSize:13.f] range:NSMakeRange(0, 3)];
        attrStr.yy_lineSpacing = 10;
        [attrStr yy_setTextHighlightRange:NSMakeRange(string.length-5, 5) color:Bsky_UIColorFromRGB(0x4e7dd3) backgroundColor:nil tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            self.desLabel.numberOfLines = 3;
            [self.desLabel sizeToFit];
            if (self.expansion) {
                self.expansion(NO);
            }
            self.height = self.desLabel.height+30;
            // 让 table view 重新计算高度
            UITableView *tableView = [self tableView];
            [tableView beginUpdates];
            [tableView endUpdates];
        }];
        self.desLabel.attributedText = attrStr;
        self.desLabel.numberOfLines = 0;
        [self.desLabel sizeToFit];
        if (self.expansion) {
            self.expansion(YES);
        }
        self.height = self.desLabel.height+30;
    }
    else
    {
        NSString *str = [NSString stringWithFormat:@"擅长：%@",desString];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        attrStr.yy_color = Bsky_UIColorFromRGB(0x333333);
        attrStr.yy_font = [UIFont systemFontOfSize:13];
        [attrStr yy_setFont:[UIFont boldSystemFontOfSize:13.f] range:NSMakeRange(0, 3)];
        attrStr.yy_lineSpacing = 10;
        self.desLabel.attributedText = attrStr;
        self.desLabel.numberOfLines = 3;
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
        [self packUp];
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
- (void)packUp{
    NSString *string =  [NSString stringWithFormat:@"擅长：%@    收起",self.desString];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:string];
    attrStr.yy_color = Bsky_UIColorFromRGB(0x333333);
    attrStr.yy_font = [UIFont systemFontOfSize:13];
    [attrStr yy_setFont:[UIFont boldSystemFontOfSize:13.f] range:NSMakeRange(0, 3)];
    attrStr.yy_lineSpacing = 10;
    [attrStr yy_setTextHighlightRange:NSMakeRange(string.length-5, 5) color:Bsky_UIColorFromRGB(0x4e7dd3) backgroundColor:nil tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        self.desLabel.numberOfLines = 3;
        [self.desLabel sizeToFit];
        if (self.expansion) {
            self.expansion(NO);
        }
        self.height = self.desLabel.height+30;
        // 让 table view 重新计算高度
        UITableView *tableView = [self tableView];
        [tableView beginUpdates];
        [tableView endUpdates];
    }];
    self.desLabel.attributedText = attrStr;
    self.desLabel.numberOfLines = 0;
    [self.desLabel sizeToFit];
    if (self.expansion) {
        self.expansion(YES);
    }
    self.height = self.desLabel.height+30;
    // 让 table view 重新计算高度
    UITableView *tableView = [self tableView];
    [tableView beginUpdates];
    [tableView endUpdates];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (UITableView *)tableView
{
    UIView *tableView = self.superview;
    
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}

@end
