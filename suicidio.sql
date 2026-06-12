create database suicidio;
use suicidio;

create table estados(
id_estado int primary key auto_increment,
sigla varchar(2) not null
);

create table estado_civil(
id_estado_civil int primary key auto_increment,
ds_estado_civil varchar(24) not null
);

create table escolaridade(
id_escolaridade int primary key auto_increment,
ds_escolaridade varchar(11) not null
);

create table causas(
id_causa int primary key auto_increment,
causasbas varchar(4),
causasbas_o varchar(4)
);

create table suicidios(
id_suicidio bigint primary key auto_increment,
ano year not null,
dt_nasc date,
sexo enum('Feminino','Masculino') not null,
id_estado int not null,
foreign key(id_estado) references estados(id_estado),
id_estado_civil int not null,
foreign key(id_estado_civil) references estado_civil(id_estado_civil),
id_escolaridade int not null,
foreign key(id_escolaridade) references escolaridade(id_escolaridade),
id_causa int not null,
foreign key(id_causa) references causas(id_causa)
);

-- INSERTS

insert into estados(sigla) values
('AC'),('AL'),('AM'),('AP'),('BA'),('CE'),
('DF'),('ES'),('GO'),('MA'),('MG'),('MS'),
('MT'),('PA'),('PB'),('PE'),('PI'),('PR'),
('RJ'),('RN'),('RO'),('RR'),('RS'),('SC'),
('SE'),('SP'),('TO');

insert into estado_civil(ds_estado_civil) values
('Casado/a'),
('Separado/a judicialmente'),
('Solteiro/a'),
('União consensual'),
('Viúvo/a');

insert into escolaridade(ds_escolaridade) values
('1 a 3 anos'),
('12 e mais'),
('4 a 7 anos'),
('8 a 11 anos'),
('Nenhuma');

insert into causas (causasbas, causasbas_o) values
('X749', 'X749'),
('X700', 'X700'),
('X630', 'X630'),
('X808', 'X808'),
('X804', 'X804'),
('X840', 'X840'),
('X700', 'R98'),
('X724', 'X724'),
('X689', 'X689'),
('X649', 'X649'),
('X720', 'X720'),
('X708', 'X708'),
('X610', 'X610'),
('X701', 'X701'),
('X708', 'X709'),
('X729', 'R99'),
('X740', 'X740'),
('X709', 'X709'),
('X704', 'X704'),
('X697', 'X697'),
('X708', 'Y348'),
('X804', 'Y344'),
('X700', 'Y208'),
('X744', 'X744'),
('X690', 'X690'),
('X620', 'X620');

insert into suicidios
(ano, dt_nasc, sexo, id_estado, id_estado_civil, id_escolaridade, id_causa)
values
(2015,'1987-08-23','Masculino',18,3,4,1),
(2014,'1979-10-04','Masculino',14,3,3,2),
(2016,'1969-10-13','Masculino',23,3,5,3),
(2017,'1938-05-27','Masculino',24,2,3,2),
(2018,'1961-07-11','Feminino',17,2,1,2),
(2011,'1991-09-24','Masculino',18,3,2,4),
(2019,'1981-05-26','Feminino',26,1,4,5),
(2019,'1978-02-16','Feminino',23,4,2,6),
(2011,'1998-09-14','Feminino',14,3,4,7),
(2012,'1986-06-19','Masculino',26,3,4,2),
(2012,'1987-06-26','Masculino',26,3,4,2),
(2019,'1991-02-11','Masculino',23,3,4,8),
(2019,'1993-02-14','Feminino',13,3,4,6),
(2013,'1983-01-12','Masculino',23,3,3,2),
(2014,'1967-10-04','Feminino',17,2,4,9),
(2016,'1971-08-04','Feminino',26,1,4,10),
(2013,'1994-02-26','Masculino',6,3,3,6),
(2012,'1995-01-15','Masculino',6,3,4,11),
(2015,'1978-12-28','Masculino',15,1,3,2),
(2015,'2003-01-01','Feminino',3,3,5,12),
(2019,'1939-11-30','Masculino',26,1,4,2),
(2016,'1978-12-01','Masculino',12,3,3,2),
(2016,'1947-08-31','Feminino',18,1,5,13),
(2019,'1965-09-23','Masculino',26,3,2,1),
(2017,'1956-09-22','Masculino',23,1,4,2),
(2017,'1972-03-10','Masculino',14,3,4,14),
(2014,'1983-07-26','Masculino',26,1,4,15),
(2017,'1962-07-23','Masculino',14,4,3,16),
(2015,'1999-06-19','Masculino',24,3,1,17),
(2016,'1967-05-04','Masculino',18,3,2,2),
(2015,'1999-07-03','Feminino',24,3,4,2),
(2015,'1971-07-12','Masculino',18,1,5,18),
(2016,'1962-04-03','Masculino',18,1,3,13),
(2016,'1981-06-24','Masculino',18,3,4,2),
(2015,'1982-10-29','Masculino',23,1,3,19),
(2013,'1995-03-11','Masculino',16,3,1,20),
(2019,'1984-01-05','Feminino',23,3,4,11),
(2019,'1995-07-10','Masculino',3,3,2,2),
(2015,'1942-02-17','Feminino',6,5,2,2),
(2018,'1966-07-11','Masculino',16,1,1,21),
(2016,'1958-08-26','Feminino',5,1,4,22),
(2014,'1967-08-24','Masculino',7,3,5,23),
(2016,'1969-12-14','Masculino',8,3,1,2),
(2012,'1957-12-25','Masculino',19,3,5,24),
(2018,'1982-11-04','Masculino',23,3,1,2),
(2016,'1976-09-13','Masculino',26,1,4,1),
(2012,'1967-10-02','Masculino',5,1,1,25),
(2012,'1936-07-26','Masculino',23,2,1,18),
(2014,'1958-06-01','Masculino',26,2,4,11),
(2019,'1984-05-01','Feminino',18,1,4,26);


-- VIEWS

-- 1)
create view idade_sexo_estado as
select TIMESTAMPDIFF(YEAR, s.dt_nasc, CURDATE()) as idade, s.sexo, e.sigla
from suicidios s
join estados e
	on e.id_estado = s.id_estado;

-- 2)
create view suicidio_por_estado as 
select count(s.id_suicidio) as total, e.sigla as estado 
from  suicidios s 
join estados e
	on e.id_estado = s.id_estado
group by e.id_estado, e.sigla;
   
-- 3)
create view top_10_estados as 
select count(s.id_suicidio) as total, e.sigla as estado 
from  suicidios s 
join estados e
	on e.id_estado = s.id_estado
group by e.id_estado, e.sigla
order by total desc limit 10;

-- 4)
create view suicidio_por_escolaridade as 
select count(s.id_suicidio) as total, e.ds_escolaridade as escolaridade 
from  suicidios s 
join escolaridade e
	on e.id_escolaridade = s.id_escolaridade
group by e.id_escolaridade, e.ds_escolaridade;
    
-- 5)
create view suicidio_por_estado_civil as 
select count(s.id_suicidio) as total, e.ds_estado_civil as estado_civil 
from  suicidios s 
join estado_civil e
	on e.id_estado_civil = s.id_estado_civil
group by e.id_estado_civil, e.ds_estado_civil;

-- 6)
create view media_idade_estado as
select floor(avg(TIMESTAMPDIFF(YEAR, dt_nasc, CURDATE()))) AS idade, e.sigla as estado
from  suicidios s 
join estados e
	on e.id_estado = s.id_estado
group by e.id_estado, e.sigla;
    
-- 7)
create view relatorio as
select 	e.sigla as estado, 
		ec.ds_estado_civil as estado_civil, 
        es.ds_escolaridade as escolaridade,
        concat(c.causasbas,' - ',c.causasbas_o) as causasbas_causasbas_o,
        count(s.id_suicidio) as quantidade_casos
from suicidios s
join estados e
	on e.id_estado = s.id_estado
join estado_civil ec
	on ec.id_estado_civil = s.id_estado_civil
join escolaridade es
	on es.id_escolaridade = s.id_escolaridade
join causas c
	on c.id_causa = s.id_causa
group by e.sigla, ec.ds_estado_civil, es.ds_escolaridade, c.causasbas, c.causasbas_o 
