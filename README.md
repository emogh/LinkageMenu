# Linkage Menu View——仿考拉海购分类菜单栏选择
##Preview

###iPhone5 Simulator      
![image](https://github.com/EmotionV/LinkageMenu/blob/master/gif/i5.gif)      
      
###iPhone6 Simulator   
![image](https://github.com/EmotionV/LinkageMenu/blob/master/gif/i6.gif)     
   
###iPhone6p Simulator   
![image](https://github.com/EmotionV/LinkageMenu/blob/master/gif/i6p.gif)    
       
       
##Usage

`#import "LinkageMenuView.h"`
Then, create LinkageMenuView
```
NSArray *titles = @[@"11",@"22",@"33",@"44"];
NSArray *views = @[view1,view2,view3,view4];
LinkageMenuView *lkMenu = [[LinkageMenuView alloc] initWithFrame:FRAME WithMenu:titles andViews:views];
```
also you can change the menu style, include  `textSize` `textColor` `selectTextColor` `bottomViewColor`
```
lkMenu.textSize = 11;
lkMenu.textColor = [UIColor blueColor];
lkMenu.selectTextColor = [UIColor redColor];
lkMenu.bottomViewColor = [UIColor yellowColor];
```

##License
MIT



