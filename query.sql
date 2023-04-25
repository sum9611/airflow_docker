# 파티션 제거 
ALTER TABLE batting_info TRUNCATE PARTITION p20230408;


create table if not exists player_info(
	player_id INT auto_increment not null ,
	player_name varchar(10) not null,
	player_birth DATE,
	primary Key (player_id)
)

create table if not exists pitching_info(
	yyyymmdd int not null comment  '날짜' ,
	player_name varchar(10) not null comment  '선수이름',
	player_birth DATE not null comment  '선수 생년월일',
	team varchar(10) not null comment  '소속팀',
	today_type varchar(10) comment '승, 패, 홀, 세',
	IP int comment '이닝',
	TBF int comment '상대한 타자 수',
	H int comment  '피안타',
	R int comment '실점',
	ER int comment '자책점',
	BB int comment '볼넷',
	HBP int comment '데드볼',
	K int comment '삼진',
	HR int comment '피홈런',
	`GO-FO` varchar(10) comment'땅볼 수,플라이볼 수',
	`PIT-S` varchar(10) comment'투구 수,스트라이크 수',
	`IR-IS`varchar(10) comment'승계주자, 승계주자득점',
	GSC int comment '투수 평가 점수',
	ERA	decimal(4,2) comment '평균자책점',
	WHIP varchar(10) comment '이닝당 출루허용률',
	LI decimal(5,2) comment  '승부 영향 중요도',
	WPA decimal(5,3) comment '승리 확률 기여도',
	RE24 decimal(5,3) comment  '기대득점 차이값',
	primary key(yyyymmdd, player_name, player_birth)
);



drop table batting_info ;

create table if not exists batting_info(
	yyyymmdd int not null comment  '날짜' ,
	player_name varchar(10) not null comment  '선수이름',
	player_birth DATE not null comment  '선수 생년월일',
	team varchar(10) not null comment  '소속팀',
	P varchar(10) not null comment  '포지션',
	TPA int comment  '타석',
	AB int comment  '타수',
	R int comment  '득점',
	H int comment  '안타',
	HR int comment  '홈런',
	RBI int comment  '타점' ,
	BB int comment  '볼넷',
	HBP int comment  '데드볼',
	SO int comment  '삼진',
	`GO` int comment  '삼진아웃',
	FO int comment  '-',
	PIT int comment  '-',
	GDP int comment  '병살타',
	LOB int comment  '잔루',
	`AVG` decimal(5,3) comment  '타율',
	OPS decimal(5,3) comment  '출루율+장타율',
	LI decimal(5,2) comment  '승부 영향 중요도',
	WPA decimal(5,3) comment '승리 확률 기여도',
	RE24 decimal(5,3) comment  '기대득점 차이값',
	primary key(yyyymmdd, player_name, player_birth)
);


## 신규 선수 찾기 
select * from player_info A right outer join (
select player_birth , player_name  from batting_info bi 
group by player_birth , player_name
union 
select player_birth , player_name  from pitching_info pi2 
group by player_birth , player_name)B on A.player_name  = B.player_name and A.player_birth  = B.player_birth;



ALTER TABLE batting_info PARTITION BY RANGE(`yyyymmdd`)(
	PARTITION p20230101 VALUES LESS THAN (20230102),
	PARTITION p20230102 VALUES LESS THAN (20230103),
	PARTITION p20230103 VALUES LESS THAN (20230104),
	PARTITION p20230104 VALUES LESS THAN (20230105),
	PARTITION p20230105 VALUES LESS THAN (20230106),
	PARTITION p20230106 VALUES LESS THAN (20230107),
	PARTITION p20230107 VALUES LESS THAN (20230108),
	PARTITION p20230108 VALUES LESS THAN (20230109),
	PARTITION p20230109 VALUES LESS THAN (20230110),
	PARTITION p20230110 VALUES LESS THAN (20230111),
	PARTITION p20230111 VALUES LESS THAN (20230112),
	PARTITION p20230112 VALUES LESS THAN (20230113),
	PARTITION p20230113 VALUES LESS THAN (20230114),
	PARTITION p20230114 VALUES LESS THAN (20230115),
	PARTITION p20230115 VALUES LESS THAN (20230116),
	PARTITION p20230116 VALUES LESS THAN (20230117),
	PARTITION p20230117 VALUES LESS THAN (20230118),
	PARTITION p20230118 VALUES LESS THAN (20230119),
	PARTITION p20230119 VALUES LESS THAN (20230120),
	PARTITION p20230120 VALUES LESS THAN (20230121),
	PARTITION p20230121 VALUES LESS THAN (20230122),
	PARTITION p20230122 VALUES LESS THAN (20230123),
	PARTITION p20230123 VALUES LESS THAN (20230124),
	PARTITION p20230124 VALUES LESS THAN (20230125),
	PARTITION p20230125 VALUES LESS THAN (20230126),
	PARTITION p20230126 VALUES LESS THAN (20230127),
	PARTITION p20230127 VALUES LESS THAN (20230128),
	PARTITION p20230128 VALUES LESS THAN (20230129),
	PARTITION p20230129 VALUES LESS THAN (20230130),
	PARTITION p20230130 VALUES LESS THAN (20230131),
	PARTITION p20230131 VALUES LESS THAN (20230201),
	PARTITION p20230201 VALUES LESS THAN (20230202),
	PARTITION p20230202 VALUES LESS THAN (20230203),
	PARTITION p20230203 VALUES LESS THAN (20230204),
	PARTITION p20230204 VALUES LESS THAN (20230205),
	PARTITION p20230205 VALUES LESS THAN (20230206),
	PARTITION p20230206 VALUES LESS THAN (20230207),
	PARTITION p20230207 VALUES LESS THAN (20230208),
	PARTITION p20230208 VALUES LESS THAN (20230209),
	PARTITION p20230209 VALUES LESS THAN (20230210),
	PARTITION p20230210 VALUES LESS THAN (20230211),
	PARTITION p20230211 VALUES LESS THAN (20230212),
	PARTITION p20230212 VALUES LESS THAN (20230213),
	PARTITION p20230213 VALUES LESS THAN (20230214),
	PARTITION p20230214 VALUES LESS THAN (20230215),
	PARTITION p20230215 VALUES LESS THAN (20230216),
	PARTITION p20230216 VALUES LESS THAN (20230217),
	PARTITION p20230217 VALUES LESS THAN (20230218),
	PARTITION p20230218 VALUES LESS THAN (20230219),
	PARTITION p20230219 VALUES LESS THAN (20230220),
	PARTITION p20230220 VALUES LESS THAN (20230221),
	PARTITION p20230221 VALUES LESS THAN (20230222),
	PARTITION p20230222 VALUES LESS THAN (20230223),
	PARTITION p20230223 VALUES LESS THAN (20230224),
	PARTITION p20230224 VALUES LESS THAN (20230225),
	PARTITION p20230225 VALUES LESS THAN (20230226),
	PARTITION p20230226 VALUES LESS THAN (20230227),
	PARTITION p20230227 VALUES LESS THAN (20230228),
	PARTITION p20230228 VALUES LESS THAN (20230301),
	PARTITION p20230301 VALUES LESS THAN (20230302),
	PARTITION p20230302 VALUES LESS THAN (20230303),
	PARTITION p20230303 VALUES LESS THAN (20230304),
	PARTITION p20230304 VALUES LESS THAN (20230305),
	PARTITION p20230305 VALUES LESS THAN (20230306),
	PARTITION p20230306 VALUES LESS THAN (20230307),
	PARTITION p20230307 VALUES LESS THAN (20230308),
	PARTITION p20230308 VALUES LESS THAN (20230309),
	PARTITION p20230309 VALUES LESS THAN (20230310),
	PARTITION p20230310 VALUES LESS THAN (20230311),
	PARTITION p20230311 VALUES LESS THAN (20230312),
	PARTITION p20230312 VALUES LESS THAN (20230313),
	PARTITION p20230313 VALUES LESS THAN (20230314),
	PARTITION p20230314 VALUES LESS THAN (20230315),
	PARTITION p20230315 VALUES LESS THAN (20230316),
	PARTITION p20230316 VALUES LESS THAN (20230317),
	PARTITION p20230317 VALUES LESS THAN (20230318),
	PARTITION p20230318 VALUES LESS THAN (20230319),
	PARTITION p20230319 VALUES LESS THAN (20230320),
	PARTITION p20230320 VALUES LESS THAN (20230321),
	PARTITION p20230321 VALUES LESS THAN (20230322),
	PARTITION p20230322 VALUES LESS THAN (20230323),
	PARTITION p20230323 VALUES LESS THAN (20230324),
	PARTITION p20230324 VALUES LESS THAN (20230325),
	PARTITION p20230325 VALUES LESS THAN (20230326),
	PARTITION p20230326 VALUES LESS THAN (20230327),
	PARTITION p20230327 VALUES LESS THAN (20230328),
	PARTITION p20230328 VALUES LESS THAN (20230329),
	PARTITION p20230329 VALUES LESS THAN (20230330),
	PARTITION p20230330 VALUES LESS THAN (20230331),
	PARTITION p20230331 VALUES LESS THAN (20230401),
	PARTITION p20230401 VALUES LESS THAN (20230402),
	PARTITION p20230402 VALUES LESS THAN (20230403),
	PARTITION p20230403 VALUES LESS THAN (20230404),
	PARTITION p20230404 VALUES LESS THAN (20230405),
	PARTITION p20230405 VALUES LESS THAN (20230406),
	PARTITION p20230406 VALUES LESS THAN (20230407),
	PARTITION p20230407 VALUES LESS THAN (20230408),
	PARTITION p20230408 VALUES LESS THAN (20230409),
	PARTITION p20230409 VALUES LESS THAN (20230410),
	PARTITION p20230410 VALUES LESS THAN (20230411),
	PARTITION p20230411 VALUES LESS THAN (20230412),
	PARTITION p20230412 VALUES LESS THAN (20230413),
	PARTITION p20230413 VALUES LESS THAN (20230414),
	PARTITION p20230414 VALUES LESS THAN (20230415),
	PARTITION p20230415 VALUES LESS THAN (20230416),
	PARTITION p20230416 VALUES LESS THAN (20230417),
	PARTITION p20230417 VALUES LESS THAN (20230418),
	PARTITION p20230418 VALUES LESS THAN (20230419),
	PARTITION p20230419 VALUES LESS THAN (20230420),
	PARTITION p20230420 VALUES LESS THAN (20230421),
	PARTITION p20230421 VALUES LESS THAN (20230422),
	PARTITION p20230422 VALUES LESS THAN (20230423),
	PARTITION p20230423 VALUES LESS THAN (20230424),
	PARTITION p20230424 VALUES LESS THAN (20230425),
	PARTITION p20230425 VALUES LESS THAN (20230426),
	PARTITION p20230426 VALUES LESS THAN (20230427),
	PARTITION p20230427 VALUES LESS THAN (20230428),
	PARTITION p20230428 VALUES LESS THAN (20230429),
	PARTITION p20230429 VALUES LESS THAN (20230430),
	PARTITION p20230430 VALUES LESS THAN (20230501),
	PARTITION p20230501 VALUES LESS THAN (20230502),
	PARTITION p20230502 VALUES LESS THAN (20230503),
	PARTITION p20230503 VALUES LESS THAN (20230504),
	PARTITION p20230504 VALUES LESS THAN (20230505),
	PARTITION p20230505 VALUES LESS THAN (20230506),
	PARTITION p20230506 VALUES LESS THAN (20230507),
	PARTITION p20230507 VALUES LESS THAN (20230508),
	PARTITION p20230508 VALUES LESS THAN (20230509),
	PARTITION p20230509 VALUES LESS THAN (20230510),
	PARTITION p20230510 VALUES LESS THAN (20230511),
	PARTITION p20230511 VALUES LESS THAN (20230512),
	PARTITION p20230512 VALUES LESS THAN (20230513),
	PARTITION p20230513 VALUES LESS THAN (20230514),
	PARTITION p20230514 VALUES LESS THAN (20230515),
	PARTITION p20230515 VALUES LESS THAN (20230516),
	PARTITION p20230516 VALUES LESS THAN (20230517),
	PARTITION p20230517 VALUES LESS THAN (20230518),
	PARTITION p20230518 VALUES LESS THAN (20230519),
	PARTITION p20230519 VALUES LESS THAN (20230520),
	PARTITION p20230520 VALUES LESS THAN (20230521),
	PARTITION p20230521 VALUES LESS THAN (20230522),
	PARTITION p20230522 VALUES LESS THAN (20230523),
	PARTITION p20230523 VALUES LESS THAN (20230524),
	PARTITION p20230524 VALUES LESS THAN (20230525),
	PARTITION p20230525 VALUES LESS THAN (20230526),
	PARTITION p20230526 VALUES LESS THAN (20230527),
	PARTITION p20230527 VALUES LESS THAN (20230528),
	PARTITION p20230528 VALUES LESS THAN (20230529),
	PARTITION p20230529 VALUES LESS THAN (20230530),
	PARTITION p20230530 VALUES LESS THAN (20230531),
	PARTITION p20230531 VALUES LESS THAN (20230601),
	PARTITION p20230601 VALUES LESS THAN (20230602),
	PARTITION p20230602 VALUES LESS THAN (20230603),
	PARTITION p20230603 VALUES LESS THAN (20230604),
	PARTITION p20230604 VALUES LESS THAN (20230605),
	PARTITION p20230605 VALUES LESS THAN (20230606),
	PARTITION p20230606 VALUES LESS THAN (20230607),
	PARTITION p20230607 VALUES LESS THAN (20230608),
	PARTITION p20230608 VALUES LESS THAN (20230609),
	PARTITION p20230609 VALUES LESS THAN (20230610),
	PARTITION p20230610 VALUES LESS THAN (20230611),
	PARTITION p20230611 VALUES LESS THAN (20230612),
	PARTITION p20230612 VALUES LESS THAN (20230613),
	PARTITION p20230613 VALUES LESS THAN (20230614),
	PARTITION p20230614 VALUES LESS THAN (20230615),
	PARTITION p20230615 VALUES LESS THAN (20230616),
	PARTITION p20230616 VALUES LESS THAN (20230617),
	PARTITION p20230617 VALUES LESS THAN (20230618),
	PARTITION p20230618 VALUES LESS THAN (20230619),
	PARTITION p20230619 VALUES LESS THAN (20230620),
	PARTITION p20230620 VALUES LESS THAN (20230621),
	PARTITION p20230621 VALUES LESS THAN (20230622),
	PARTITION p20230622 VALUES LESS THAN (20230623),
	PARTITION p20230623 VALUES LESS THAN (20230624),
	PARTITION p20230624 VALUES LESS THAN (20230625),
	PARTITION p20230625 VALUES LESS THAN (20230626),
	PARTITION p20230626 VALUES LESS THAN (20230627),
	PARTITION p20230627 VALUES LESS THAN (20230628),
	PARTITION p20230628 VALUES LESS THAN (20230629),
	PARTITION p20230629 VALUES LESS THAN (20230630),
	PARTITION p20230630 VALUES LESS THAN (20230701),
	PARTITION p20230701 VALUES LESS THAN (20230702),
	PARTITION p20230702 VALUES LESS THAN (20230703),
	PARTITION p20230703 VALUES LESS THAN (20230704),
	PARTITION p20230704 VALUES LESS THAN (20230705),
	PARTITION p20230705 VALUES LESS THAN (20230706),
	PARTITION p20230706 VALUES LESS THAN (20230707),
	PARTITION p20230707 VALUES LESS THAN (20230708),
	PARTITION p20230708 VALUES LESS THAN (20230709),
	PARTITION p20230709 VALUES LESS THAN (20230710),
	PARTITION p20230710 VALUES LESS THAN (20230711),
	PARTITION p20230711 VALUES LESS THAN (20230712),
	PARTITION p20230712 VALUES LESS THAN (20230713),
	PARTITION p20230713 VALUES LESS THAN (20230714),
	PARTITION p20230714 VALUES LESS THAN (20230715),
	PARTITION p20230715 VALUES LESS THAN (20230716),
	PARTITION p20230716 VALUES LESS THAN (20230717),
	PARTITION p20230717 VALUES LESS THAN (20230718),
	PARTITION p20230718 VALUES LESS THAN (20230719),
	PARTITION p20230719 VALUES LESS THAN (20230720),
	PARTITION p20230720 VALUES LESS THAN (20230721),
	PARTITION p20230721 VALUES LESS THAN (20230722),
	PARTITION p20230722 VALUES LESS THAN (20230723),
	PARTITION p20230723 VALUES LESS THAN (20230724),
	PARTITION p20230724 VALUES LESS THAN (20230725),
	PARTITION p20230725 VALUES LESS THAN (20230726),
	PARTITION p20230726 VALUES LESS THAN (20230727),
	PARTITION p20230727 VALUES LESS THAN (20230728),
	PARTITION p20230728 VALUES LESS THAN (20230729),
	PARTITION p20230729 VALUES LESS THAN (20230730),
	PARTITION p20230730 VALUES LESS THAN (20230731),
	PARTITION p20230731 VALUES LESS THAN (20230801),
	PARTITION p20230801 VALUES LESS THAN (20230802),
	PARTITION p20230802 VALUES LESS THAN (20230803),
	PARTITION p20230803 VALUES LESS THAN (20230804),
	PARTITION p20230804 VALUES LESS THAN (20230805),
	PARTITION p20230805 VALUES LESS THAN (20230806),
	PARTITION p20230806 VALUES LESS THAN (20230807),
	PARTITION p20230807 VALUES LESS THAN (20230808),
	PARTITION p20230808 VALUES LESS THAN (20230809),
	PARTITION p20230809 VALUES LESS THAN (20230810),
	PARTITION p20230810 VALUES LESS THAN (20230811),
	PARTITION p20230811 VALUES LESS THAN (20230812),
	PARTITION p20230812 VALUES LESS THAN (20230813),
	PARTITION p20230813 VALUES LESS THAN (20230814),
	PARTITION p20230814 VALUES LESS THAN (20230815),
	PARTITION p20230815 VALUES LESS THAN (20230816),
	PARTITION p20230816 VALUES LESS THAN (20230817),
	PARTITION p20230817 VALUES LESS THAN (20230818),
	PARTITION p20230818 VALUES LESS THAN (20230819),
	PARTITION p20230819 VALUES LESS THAN (20230820),
	PARTITION p20230820 VALUES LESS THAN (20230821),
	PARTITION p20230821 VALUES LESS THAN (20230822),
	PARTITION p20230822 VALUES LESS THAN (20230823),
	PARTITION p20230823 VALUES LESS THAN (20230824),
	PARTITION p20230824 VALUES LESS THAN (20230825),
	PARTITION p20230825 VALUES LESS THAN (20230826),
	PARTITION p20230826 VALUES LESS THAN (20230827),
	PARTITION p20230827 VALUES LESS THAN (20230828),
	PARTITION p20230828 VALUES LESS THAN (20230829),
	PARTITION p20230829 VALUES LESS THAN (20230830),
	PARTITION p20230830 VALUES LESS THAN (20230831),
	PARTITION p20230831 VALUES LESS THAN (20230901),
	PARTITION p20230901 VALUES LESS THAN (20230902),
	PARTITION p20230902 VALUES LESS THAN (20230903),
	PARTITION p20230903 VALUES LESS THAN (20230904),
	PARTITION p20230904 VALUES LESS THAN (20230905),
	PARTITION p20230905 VALUES LESS THAN (20230906),
	PARTITION p20230906 VALUES LESS THAN (20230907),
	PARTITION p20230907 VALUES LESS THAN (20230908),
	PARTITION p20230908 VALUES LESS THAN (20230909),
	PARTITION p20230909 VALUES LESS THAN (20230910),
	PARTITION p20230910 VALUES LESS THAN (20230911),
	PARTITION p20230911 VALUES LESS THAN (20230912),
	PARTITION p20230912 VALUES LESS THAN (20230913),
	PARTITION p20230913 VALUES LESS THAN (20230914),
	PARTITION p20230914 VALUES LESS THAN (20230915),
	PARTITION p20230915 VALUES LESS THAN (20230916),
	PARTITION p20230916 VALUES LESS THAN (20230917),
	PARTITION p20230917 VALUES LESS THAN (20230918),
	PARTITION p20230918 VALUES LESS THAN (20230919),
	PARTITION p20230919 VALUES LESS THAN (20230920),
	PARTITION p20230920 VALUES LESS THAN (20230921),
	PARTITION p20230921 VALUES LESS THAN (20230922),
	PARTITION p20230922 VALUES LESS THAN (20230923),
	PARTITION p20230923 VALUES LESS THAN (20230924),
	PARTITION p20230924 VALUES LESS THAN (20230925),
	PARTITION p20230925 VALUES LESS THAN (20230926),
	PARTITION p20230926 VALUES LESS THAN (20230927),
	PARTITION p20230927 VALUES LESS THAN (20230928),
	PARTITION p20230928 VALUES LESS THAN (20230929),
	PARTITION p20230929 VALUES LESS THAN (20230930),
	PARTITION p20230930 VALUES LESS THAN (20231001),
	PARTITION p20231001 VALUES LESS THAN (20231002),
	PARTITION p20231002 VALUES LESS THAN (20231003),
	PARTITION p20231003 VALUES LESS THAN (20231004),
	PARTITION p20231004 VALUES LESS THAN (20231005),
	PARTITION p20231005 VALUES LESS THAN (20231006),
	PARTITION p20231006 VALUES LESS THAN (20231007),
	PARTITION p20231007 VALUES LESS THAN (20231008),
	PARTITION p20231008 VALUES LESS THAN (20231009),
	PARTITION p20231009 VALUES LESS THAN (20231010),
	PARTITION p20231010 VALUES LESS THAN (20231011),
	PARTITION p20231011 VALUES LESS THAN (20231012),
	PARTITION p20231012 VALUES LESS THAN (20231013),
	PARTITION p20231013 VALUES LESS THAN (20231014),
	PARTITION p20231014 VALUES LESS THAN (20231015),
	PARTITION p20231015 VALUES LESS THAN (20231016),
	PARTITION p20231016 VALUES LESS THAN (20231017),
	PARTITION p20231017 VALUES LESS THAN (20231018),
	PARTITION p20231018 VALUES LESS THAN (20231019),
	PARTITION p20231019 VALUES LESS THAN (20231020),
	PARTITION p20231020 VALUES LESS THAN (20231021),
	PARTITION p20231021 VALUES LESS THAN (20231022),
	PARTITION p20231022 VALUES LESS THAN (20231023),
	PARTITION p20231023 VALUES LESS THAN (20231024),
	PARTITION p20231024 VALUES LESS THAN (20231025),
	PARTITION p20231025 VALUES LESS THAN (20231026),
	PARTITION p20231026 VALUES LESS THAN (20231027),
	PARTITION p20231027 VALUES LESS THAN (20231028),
	PARTITION p20231028 VALUES LESS THAN (20231029),
	PARTITION p20231029 VALUES LESS THAN (20231030),
	PARTITION p20231030 VALUES LESS THAN (20231031),
	PARTITION p20231031 VALUES LESS THAN (20231101),
	PARTITION p20231101 VALUES LESS THAN (20231102),
	PARTITION p20231102 VALUES LESS THAN (20231103),
	PARTITION p20231103 VALUES LESS THAN (20231104),
	PARTITION p20231104 VALUES LESS THAN (20231105),
	PARTITION p20231105 VALUES LESS THAN (20231106),
	PARTITION p20231106 VALUES LESS THAN (20231107),
	PARTITION p20231107 VALUES LESS THAN (20231108),
	PARTITION p20231108 VALUES LESS THAN (20231109),
	PARTITION p20231109 VALUES LESS THAN (20231110),
	PARTITION p20231110 VALUES LESS THAN (20231111),
	PARTITION p20231111 VALUES LESS THAN (20231112),
	PARTITION p20231112 VALUES LESS THAN (20231113),
	PARTITION p20231113 VALUES LESS THAN (20231114),
	PARTITION p20231114 VALUES LESS THAN (20231115),
	PARTITION p20231115 VALUES LESS THAN (20231116),
	PARTITION p20231116 VALUES LESS THAN (20231117),
	PARTITION p20231117 VALUES LESS THAN (20231118),
	PARTITION p20231118 VALUES LESS THAN (20231119),
	PARTITION p20231119 VALUES LESS THAN (20231120),
	PARTITION p20231120 VALUES LESS THAN (20231121),
	PARTITION p20231121 VALUES LESS THAN (20231122),
	PARTITION p20231122 VALUES LESS THAN (20231123),
	PARTITION p20231123 VALUES LESS THAN (20231124),
	PARTITION p20231124 VALUES LESS THAN (20231125),
	PARTITION p20231125 VALUES LESS THAN (20231126),
	PARTITION p20231126 VALUES LESS THAN (20231127),
	PARTITION p20231127 VALUES LESS THAN (20231128),
	PARTITION p20231128 VALUES LESS THAN (20231129),
	PARTITION p20231129 VALUES LESS THAN (20231130),
	PARTITION p20231130 VALUES LESS THAN (20231201),
	PARTITION p20231201 VALUES LESS THAN (20231202),
	PARTITION p20231202 VALUES LESS THAN (20231203),
	PARTITION p20231203 VALUES LESS THAN (20231204),
	PARTITION p20231204 VALUES LESS THAN (20231205),
	PARTITION p20231205 VALUES LESS THAN (20231206),
	PARTITION p20231206 VALUES LESS THAN (20231207),
	PARTITION p20231207 VALUES LESS THAN (20231208),
	PARTITION p20231208 VALUES LESS THAN (20231209),
	PARTITION p20231209 VALUES LESS THAN (20231210),
	PARTITION p20231210 VALUES LESS THAN (20231211),
	PARTITION p20231211 VALUES LESS THAN (20231212),
	PARTITION p20231212 VALUES LESS THAN (20231213),
	PARTITION p20231213 VALUES LESS THAN (20231214),
	PARTITION p20231214 VALUES LESS THAN (20231215),
	PARTITION p20231215 VALUES LESS THAN (20231216),
	PARTITION p20231216 VALUES LESS THAN (20231217),
	PARTITION p20231217 VALUES LESS THAN (20231218),
	PARTITION p20231218 VALUES LESS THAN (20231219),
	PARTITION p20231219 VALUES LESS THAN (20231220),
	PARTITION p20231220 VALUES LESS THAN (20231221),
	PARTITION p20231221 VALUES LESS THAN (20231222),
	PARTITION p20231222 VALUES LESS THAN (20231223),
	PARTITION p20231223 VALUES LESS THAN (20231224),
	PARTITION p20231224 VALUES LESS THAN (20231225),
	PARTITION p20231225 VALUES LESS THAN (20231226),
	PARTITION p20231226 VALUES LESS THAN (20231227),
	PARTITION p20231227 VALUES LESS THAN (20231228),
	PARTITION p20231228 VALUES LESS THAN (20231229),
	PARTITION p20231229 VALUES LESS THAN (20231230),
	PARTITION p20231230 VALUES LESS THAN (20231231),
	PARTITION p20231231 VALUES LESS THAN (20240101)
);




