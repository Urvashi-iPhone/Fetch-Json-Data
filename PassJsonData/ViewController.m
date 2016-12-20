//
//  ViewController.m
//  PassJsonData
//
//  Created by Tecksky Techonologies on 12/2/16.
//  Copyright © 2016 Softranz Technologies. All rights reserved.
//

#import "ViewController.h"
#import "showdataTableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataList;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dataList = [[NSMutableArray alloc] init];
    
    /*-------RUNMILE API---------*/
    
    NSError *error2;
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];

    NSData *jsondata2 = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error2];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [jsondata2 length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:@"http://runmile.com/api/web/v1/profile/search"]];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"VVb419EerxCnpQfGv0pkJsKa84Fj1WzngxPJRvce" forHTTPHeaderField:@"TeckskyAuth"];
    
    
    [request setHTTPBody:jsondata2];
    
    NSURLResponse *response;
    
    NSData *POSTReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    NSMutableDictionary *dic12 = [NSJSONSerialization JSONObjectWithData:POSTReply options:0 error:nil];
    
    NSMutableArray *pager = [[dic12 valueForKey:@"data"] valueForKey:@"pager"];
    
        for (int i =0; i<[pager count]; i++)
            {
                NSMutableDictionary *dic = [pager objectAtIndex:i];
                NSString *fname = [dic valueForKey:@"firstname"];
                UIImage *avatar = [dic valueForKey:@"avatar"];
        
                NSMutableDictionary *model = [[NSMutableDictionary alloc]init];
                [model setObject:fname forKey:@"FIRSTNAME"];
                [model setObject:avatar forKey:@"AVATARIMG"];
                [dataList addObject:model];
            }

          /*-------CAMPUS API---------*/
//    NSString *str = [NSString stringWithFormat:@"http://campussconnect.com/json_campuseconnect/json_allpostdata.php"];
//    NSURL *url = [NSURL URLWithString:str];
//    NSData *jsondata = [NSData dataWithContentsOfURL:url];
//    NSError *error;
//    NSDictionary *dicdata = [NSJSONSerialization JSONObjectWithData:jsondata options:kNilOptions error:&error];
//    NSMutableArray *myarray = [[NSMutableArray alloc]initWithArray:[dicdata objectForKey:@"Postlist"] copyItems:YES];
//    
//    for (int i =0; i<[myarray count]; i++)
//    {
//        NSMutableDictionary *dic = [myarray objectAtIndex:i];
//        NSString *fname = [dic valueForKey:@"first_name"];
//        NSString *postAgo = [dic valueForKey:@"Posted_ago"];
//        NSString *postId = [dic valueForKey:@"PostId"];
//        NSMutableArray *comment = [dic valueForKey:@"Comments"];
//        NSMutableArray *subtyp = [dic valueForKey:@"subtype"];
//        
//        NSMutableDictionary *model = [[NSMutableDictionary alloc]init];
//        [model setObject:fname forKey:@"NAME"];
//        [model setObject:postAgo forKey:@"POST"];
//        [model setObject:postId forKey:@"POST_Id"];
//        [model setObject:comment forKey:@"COMMENTS"];
//        [model setObject:subtyp forKey:@"SUBTYPE"];
//        [dataList addObject:model];
//    }
//   // [dataList removeObjectAtIndex:5];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataList count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    showdataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
   /*-------CAMPUS API---------*/
//    cell.name.text = [[dataList objectAtIndex:indexPath.row] valueForKey:@"NAME"];
//    cell.commenttag.text = [NSString stringWithFormat:@"%d",[[[dataList objectAtIndex:indexPath.row] valueForKey:@"COMMENTS"]count]];
//    
//    NSString *comment_cnt = [[[[dataList objectAtIndex:indexPath.row] valueForKey:@"COMMENTS"] objectAtIndex:0] valueForKey:@"CommentId"];
//    
//    cell.code.text = [NSString stringWithFormat:@"%@",comment_cnt];
//    
//    NSMutableArray *subtype = [[dataList objectAtIndex:indexPath.row] valueForKey:@"SUBTYPE"];
    
     /*-------RUNMILE API---------*/
    cell.name.text = [[dataList objectAtIndex:indexPath.row] valueForKey:@"FIRSTNAME"];
     cell.myimage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[dataList objectAtIndex:indexPath.row]valueForKey:@"AVATARIMG"]]]];
  
    return cell;
}
@end
