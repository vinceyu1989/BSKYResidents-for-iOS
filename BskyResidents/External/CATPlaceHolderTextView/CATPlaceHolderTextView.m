//
//  UIPlaceHolderTextView.m
//  eDuShi
//
//  Created by aladdin on 14/12/23.
//  Copyright (c) 2014年 aladdin. All rights reserved.
//

#import "CATPlaceHolderTextView.h"

@implementation CATPlaceHolderTextView

@synthesize placeHolderLabel;
@synthesize placeholder;
@synthesize placeholderColor;

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)awakeFromNib
{
	[super awakeFromNib];
	[self setPlaceholder:@""];
    [self setPlaceholderColor:Bsky_UIColorFromRGBA(0xcccccc,1)];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

- (id)initWithFrame:(CGRect)frame
{
	if ((self = [super initWithFrame:frame])) {
		[self setPlaceholder:@""];
        [self setPlaceholderColor:Bsky_UIColorFromRGBA(0xcccccc,1)];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
	}
	return self;
}

- (void)textChanged:(NSNotification *)notification
{
	if ([[self placeholder] length] == 0) {
		return;
	}

	if ([[self text] length] == 0) {
		[[self viewWithTag:999] setAlpha:1];
	} else {
		[[self viewWithTag:999] setAlpha:0];
	}
}

- (void)setText:(NSString *)text
{
	[super setText:text];
	[self textChanged:nil];
}

- (void)drawRect:(CGRect)rect
{
	if ([[self placeholder] length] > 0) {
		if (placeHolderLabel == nil) {
			placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 15, self.bounds.size.width - 16, 0)];
			placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
			placeHolderLabel.numberOfLines = 0;
			placeHolderLabel.font = self.font;
			placeHolderLabel.backgroundColor = [UIColor clearColor];
			placeHolderLabel.textColor = self.placeholderColor;
			placeHolderLabel.alpha = 0;
			placeHolderLabel.tag = 999;
            
			[self addSubview:placeHolderLabel];
		}

		placeHolderLabel.text = self.placeholder;
		[placeHolderLabel sizeToFit];
		[self sendSubviewToBack:placeHolderLabel];
	}

	if ([[self text] length] == 0 && [[self placeholder] length] > 0) {
		[[self viewWithTag:999] setAlpha:1];
	}

	[super drawRect:rect];
}

- (void)setPlaceholder:(NSString *)aPlaceholder
{
	placeholder = aPlaceholder;
	[self setNeedsDisplay];
    
    self.placeHolderLabel.frame = CGRectMake(12, 15, 300, 30);
}

@end
