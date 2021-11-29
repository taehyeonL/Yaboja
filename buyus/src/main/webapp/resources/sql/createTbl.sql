CREATE SCHEMA `yaboja` DEFAULT CHARACTER SET utf8 ;
create database yaboja;
use yaboja;


create table yaMemberTbl(
   ya_id varchar(10) primary key,
   ya_email varchar(20) not null unique,
   ya_pwd varchar(10) not null,
   ya_name nvarchar(10) not null,
   ya_myOTT varchar(10) not null,
   ya_phNum int(10) not null,
   ya_level int(4) default '1',
   ya_point int(255) default'0',
   write_time timestamp default now()
) default character set utf8 collate utf8_general_ci;

create table ottTbl(
   ottName varchar(20) primary key,
   clientNum int(20) not null,
   genre_action int(20) not null,
   genre_adventure int(20) not null,
   genre_romance int(20) not null,
   genre_comedy int(20) not null,
   genre_animation int(20) not null,
   genre_fantasy int(20) not null,
   genre_horror int(20) not null,
   genre_documentary int(20) not null,
   write_time timestamp default now()
) default character set utf8 collate utf8_general_ci;

create table contentTbl(
   title nvarchar(20) primary key,
   ottName varchar(20) not null,
   plot nvarchar(1000) not null,
   main_actor nvarchar(100) not null,
   producer nvarchar(20) not null,
   produce_com nvarchar(20) not null,
   write_time timestamp default now()
) default character set utf8 collate utf8_general_ci;
alter table contentTbl add foreign key(ottName) references ottTbl(ottName);

create table yaReviewTbl(
   seq_review integer auto_increment primary key,
   id char(10) not null,
   ottName varchar(20) not null,
   review_title nvarchar(20) not null,
   eval int(1) not null check(eval<=5),
   review_body nvarchar(500) not null,
   review_recommand int(10) not null,
   foreign key(id) references yaMemberTbl(ya_Id),
   foreign key(ottName) references ottTbl(ottName),
   foreign key(review_title) references contentTbl(title)
) default character set utf8 collate utf8_general_ci;

create table BoardTbl(
   seq_board integer auto_increment primary key,
   ya_id varchar(10) not null,
   Board_Title nvarchar(100) not null,
   Board_Body nvarchar(1000) not null,
   write_time timestamp default now(),
   view_count int(100),
   board_recommend varchar(200),
   board_not_recommend varchar(200),
   report int(100),
   content_title nvarchar(20) not null,
   foreign key(content_title) references contentTbl(title),
   foreign key(ya_id) references yaMemberTbl(ya_id)
) default character set utf8 collate utf8_general_ci;

create table reportBoardTbl(
   seq_report integer auto_increment primary key,
   id char(10) not null,
   report_title nvarchar(20) not null,
   report_body nvarchar(300) not null,
   report_board_seq integer not null,
   foreign key(id) references yaMemberTbl(ya_Id),
   foreign key(report_board_seq) references BoardTbl(seq_board)
)default character set utf8 collate utf8_general_ci;

create table boardReplyTbl(
   find_board integer not null,
   id char(10) not null,
   reply_body nvarchar(200) not null,
   write_time timestamp default now(),
   foreign key(find_board) references BoardTbl(seq_board),
   foreign key(id) references yaMemberTbl(ya_id)
)default character set utf8 collate utf8_general_ci;

create table yaReviewReplyTbl(
   find_review integer not null,
   id char(10) not null,
   reply_body nvarchar(200) not null,
   reply_recommend varchar(200),
   reply_not_recommend varchar(200),
   write_time timestamp default now(),
    foreign key(find_review) references yaReviewTbl(seq_review)
)default character set utf8 collate utf8_general_ci;

create table reviewReportTbl(
   seq_report integer auto_increment primary key,
   id char(10) not null,
   report_title nvarchar(20) not null,
   report_body nvarchar(300) not null,
   report_review_seq integer not null,
   foreign key(id) references yaMemberTbl(ya_Id)
)default character set utf8 collate utf8_general_ci;

alter table reviewReportTbl add foreign key(report_review_seq) references BoardTbl(yaReviewTbl);


create table ya_follow(
follower_seq integer auto_increment primary key,
follower_id varchar(10) not null,
followed_id varchar(10) not null,
foreign key(follower_id) references ya_MemberTbl(ya_id),
foreign key(followed_id) references ya_MemberTbl(ya_id)
) default character set utf8 collate utf8_general_ci;

