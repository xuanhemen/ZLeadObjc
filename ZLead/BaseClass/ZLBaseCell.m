//
//  ZLBaseCell.m
//  ZLead
//
//  Created by dmy on 2019/5/25.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLBaseCell.h"

@interface ZLBaseCell ()

@end

@implementation ZLBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.bottomSeparator = [[UIView alloc] initWithFrame:CGRectZero];
        self.bottomSeparator.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        [self addSubview:self.bottomSeparator];
    }
    return self;
}


- (void)setupData:(id)dataModel {
    
}

+ (CGFloat)heightForCell {
    return 0;
}

@end
