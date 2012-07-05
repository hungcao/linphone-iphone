/* UIChatCell.m
 *
 * Copyright (C) 2012  Belledonne Comunications, Grenoble, France
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or   
 *  (at your option) any later version.                                 
 *                                                                      
 *  This program is distributed in the hope that it will be useful,     
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of      
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the       
 *  GNU Library General Public License for more details.                
 *                                                                      
 *  You should have received a copy of the GNU General Public License   
 *  along with this program; if not, write to the Free Software         
 *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */

#import "UIChatCell.h"

@implementation UIChatCell

@synthesize avatarView;
@synthesize displayNameLabel;
@synthesize chatContentLabel;

@synthesize chat;

#pragma mark - Lifecycle Functions

- (id)init {
    if ((self = [super init]) != nil) {
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"UIChatCell"
                                                              owner:self
                                                            options:nil];
        
        if ([arrayOfViews count] >= 1) {
            [self addSubview:[[arrayOfViews objectAtIndex:0] retain]];
        }
    }
    return self;
}

- (void)dealloc {
    [displayNameLabel release];
    [chatContentLabel release];
    
    [super dealloc];
}

#pragma mark - 

- (void)update {
    [avatarView setImage:[UIImage imageNamed:@"avatar_unknown_small.png"]];
    
    [displayNameLabel setText:[chat remoteContact]];
    [chatContentLabel setText:[chat message]];
    
    //
    // Adapt size
    //
    CGRect displayNameFrame = [displayNameLabel frame];
    CGRect chatContentFrame = [chatContentLabel frame];
    
    chatContentFrame.origin.x -= displayNameFrame.size.width;
    
    // Compute firstName size
    CGSize contraints;
    contraints.height = [displayNameLabel frame].size.height;
    contraints.width = ([chatContentLabel frame].size.width + [chatContentLabel frame].origin.x) - [displayNameLabel frame].origin.x;
    CGSize firstNameSize = [[displayNameLabel text] sizeWithFont:[displayNameLabel font] constrainedToSize: contraints];
    displayNameFrame.size.width = firstNameSize.width;
    
    // Compute lastName size & position
    chatContentFrame.origin.x += displayNameFrame.size.width;
    chatContentFrame.size.width = (contraints.width + [displayNameLabel frame].origin.x) - chatContentFrame.origin.x;
    
    [displayNameLabel setFrame: displayNameFrame];
    [chatContentLabel setFrame: chatContentFrame];
}


#pragma mark - Action Functions

- (IBAction)onDetails: (id) event {
    
}

@end