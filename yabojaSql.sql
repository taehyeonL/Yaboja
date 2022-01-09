
create database yaboja;
use yaboja;
select * from yaReviewTbl;  
select * from BoardTbl;
select *from yaMemberTbl;
select * from boardReplyTbl;
select * from yaReviewReplyTbl;
select * from ottTbl;


insert into yaMembertbl(ya_id, ya_email, ya_pwd, ya_name, ya_myOTT, ya_phNum) value ("lee","lth@com", "1234", "leeth","netflx",010);
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
insert into ottTbl(ottName,clientNum,genre_action,genre_adventure,genre_romance,genre_comedy,genre_animation,genre_fantasy,genre_horror,genre_documentary) value("netflix",10,10,10,10,10,10,10,10,10);
create table contentTbl(
	title nvarchar(20) primary key,
	ottName varchar(20) not null,
	plot nvarchar(1000) not null,
	main_actor nvarchar(100) not null,
	producer nvarchar(20) not null,
	produce_com nvarchar(20) not null,
	write_time timestamp default now(),
    service_type nvarchar(20) not null,
    foreign key(ottName) references ottTbl(ottName)ON DELETE CASCADE ON UPDATE CASCADE
)default character set utf8 collate utf8_general_ci;
insert into contentTbl(title,ottName,plot,main_actor,producer,produce_com) value("ironman", "netflix", "졸라재밌다","로다주","감독님", "마블");

create table yaReviewTbl(
	seq_review integer auto_increment primary key,
	id char(10) not null,
	ottName varchar(20) not null,
	review_content nvarchar(20) not null,
	eval int(1) not null check(eval<=5),
	review_body nvarchar(500) not null,
	review_recommend int(10) not null,
    review_not_recommend int (10) not null,
    spo boolean default false,
	foreign key(id) references yaMemberTbl(ya_Id) ON DELETE CASCADE ON UPDATE CASCADE,
	foreign key(ottName) references ottTbl(ottName) ON DELETE CASCADE ON UPDATE CASCADE,
	foreign key(review_content) references contentTbl(title) ON DELETE CASCADE ON UPDATE CASCADE
) default character set utf8 collate utf8_general_ci;



create table BoardTbl(
	seq_board integer auto_increment primary key,
	ya_id varchar(10) not null,
	Board_Title nvarchar(100) not null,
	Board_Body nvarchar(1000) not null,
	write_time timestamp default now(),
	view_count int(100) default 0,
	board_recommend int(10),
	board_not_recommend int(10),
	report int(100),
	content_title nvarchar(20) not null,
	foreign key(content_title) references contentTbl(title) ON DELETE CASCADE ON UPDATE CASCADE,
	foreign key(ya_id) references yaMemberTbl(ya_id) ON DELETE CASCADE ON UPDATE CASCADE
)default character set utf8 collate utf8_general_ci;



create table reportBoardTbl(
	seq_report integer auto_increment primary key,
	id varchar(10) not null,
	report_title nvarchar(20) not null,
	report_body nvarchar(300) not null,
	report_board_seq integer not null,
	foreign key(id) references yaMemberTbl(ya_Id) ON DELETE CASCADE ON UPDATE CASCADE,
	foreign key(report_board_seq) references BoardTbl(seq_board) ON DELETE CASCADE ON UPDATE CASCADE
)default character set utf8 collate utf8_general_ci;


create table boardReplyTbl(
	seq_boardreply integer auto_increment primary key,
    find_board integer not null,
	id char(10) not null,
	reply_body nvarchar(200) not null,
	write_time timestamp default now(),
	foreign key(find_board) references BoardTbl(seq_board) ON DELETE CASCADE ON UPDATE CASCADE,
	foreign key(id) references yaMemberTbl(ya_id) ON DELETE CASCADE ON UPDATE CASCADE
)default character set utf8 collate utf8_general_ci;

create table yaReviewReplyTbl(
	seq_reviewreply integer auto_increment primary key,
    find_review integer not null,
	id char(10) not null,
	reply_body nvarchar(200) not null,
	reply_recommend int(10),
	reply_not_recommend int(10),
	write_time timestamp default now(),
    foreign key(find_review) references yaReviewTbl(seq_review) ON DELETE CASCADE ON UPDATE CASCADE
)default character set utf8 collate utf8_general_ci;






create table reviewReportTbl(
	seq_report integer auto_increment primary key,
	id char(10) not null,
	report_title nvarchar(20) not null,
	report_body nvarchar(300) not null,
	report_review_seq integer not null,
	foreign key(id) references yaMemberTbl(ya_Id) ON DELETE CASCADE ON UPDATE CASCADE,
	foreign key(report_review_seq) references yaReviewTbl(seq_review) ON DELETE CASCADE ON UPDATE CASCADE
)default character set utf8 collate utf8_general_ci;


create table ya_follow(
follower_seq integer auto_increment primary key,
follower_id varchar(10) not null,
followed_id varchar(10) not null,
foreign key(follower_id) references yaMemberTbl(ya_id) ON DELETE CASCADE ON UPDATE CASCADE,
foreign key(followed_id) references yaMemberTbl(ya_id) ON DELETE CASCADE ON UPDATE CASCADE
)default character set utf8 collate utf8_general_ci;


