create database bdcesde951;
use bdcesde951;

create table alumno_951 (
    documento_identidad_951 varchar(10) primary key,
    nombre_951 varchar(50),
    apellidos_951 varchar(50),
    edad_951 int,
    telefono_951 varchar(15),
    contrase�a_951 varchar(100),
    correo_951 varchar(100) unique,
    ciudad_residencia_951 varchar(50),
    fecha_nacimiento_951 date default '2000-01-01'
);

insert into alumno_951 (documento_identidad_951, nombre_951, apellidos_951, edad_951, telefono_951, 
contrase�a_951, correo_951, ciudad_residencia_951)
values
('1234567890', 'juan', 'p�rez', 20, '3123456789', 'contrase�a1', 'juan@gmail.com', 'cali'),
('9876543210', 'mar�a', 'g�mez', 22, '3156789012', 'contrase�a2', 'maria@gmail.com', 'bogot�'),
('1111111111', 'carlos', 'mart�nez', 21, '3189012345', 'contrase�a3', 'carlos@gmail.com', 'medell�n'),
('2222222222', 'ana', 'rodr�guez', 20, '3190123456', 'contrase�a4', 'ana@gmail.com', 'cali'),
('3333333333', 'luis', 'hern�ndez', 23, '3101234567', 'contrase�a5', 'luis@gmail.com', 'bogot�');

select * from alumno_951;

create table carrera_951 (
    codigo_carrera_951 int primary key,
    nombre_carrera_951 varchar(50),
    jornada_951 varchar(10),
    facultad_951 varchar(50)
);
insert into carrera_951 (codigo_carrera_951, nombre_carrera_951, jornada_951, facultad_951)
values
(101, 'ingenier�a de sistemas', 'diurna', 'ingenier�a'),
(102, 'ingenier�a mec�nica', 'nocturna', 'ingenier�a'),
(103, 'administraci�n de empresas', 'diurna', 'administraci�n'),
(104, 'contadur�a p�blica', 'nocturna', 'administraci�n'),
(105, 'derecho', 'diurna', 'derecho');
select * from carrera_951;

create table materia_951 (
    codigo_materia_951 int primary key,
    nombre_materia_951 varchar(50),
    area_conocimiento_951 varchar(50),
	horario_951 varchar(10);

insert into materia_951 (codigo_materia_951, nombre_materia_951, area_conocimiento_951, horario_951)
values
(200, 'programaci�n', 'cienc ias de la computaci�n', '8:00-10:00'),
(202, 'matem�ticas', 'ciencias exactas', '10:00-12:00'),
(204, 'f�sica', 'ciencias exactas', '14:00-16:00'),
(206, 'qu�mica', 'ciencias exactas', '16:00-18:00'),
(208, 'econom�a', 'ciencias sociales', '18:00-20:00');  

select * from materia_951;

create table profesorcesde_951 (
    documento_identidad_951 varchar(10) primary key,
    nombre_951 varchar(50),
    apellidos_951 varchar(50),
    edad_951 int,
    telefono_951 varchar(15),
    contrase�a_951 varchar(100),
    correo_951 varchar(100) unique,
    nivel_academico_951 varchar(10) default 'pregrado'
);
insert into profesorcesde_951 (documento_identidad_951, nombre_951, apellidos_951, edad_951, 
telefono_951, contrase�a_951, correo_951, nivel_academico_951)
values
('4444444444', 'jorge', 'garc�a', 35, '3201234567', 'contrase�a6', 'jorge@gmail.com', 'pregrado'),
('5555555555', 'luz', 'mart�nez', 30, '3214567890', 'contrase�a7', 'luz@gmail.com', 'pregrado'),
('6666666666', 'carlos', 'hern�ndez', 40, '3227890123', 'contrase�a8', 'carlos@gmail.com', 'posgrado'),
('7777777777', 'marcela', 'g�mez', 32, '3234567890', 'contrase�a9', 'marcela@gmail.com', 'pregrado'),
('8888888888', 'juan', 'rodr�guez', 38, '3245678901', 'contrase�a10', 'juan@gmail.com', 'posgrado');
select * from profesorcesde_951;

create table alumno_materia_951 (
    alumno_951 varchar(10) foreign key references alumno_951(documento_identidad_951),
    materia_951 int foreign key references materia_951(codigo_materia_951)
);
insert into alumno_materia_951 (alumno_951, materia_951)
values
('1234567890', 200),
('9876543210', 202),
('1111111111', 204),
('2222222222', 206),
('3333333333', 208);
select * from alumno_materia_951;

create table alumno_carrera_951 (
    alumno_951 varchar(10) foreign key references alumno_951(documento_identidad_951),
    carrera_951 int foreign key references carrera_951(codigo_carrera_951)
);
insert into alumno_carrera_951 (alumno_951, carrera_951)
values
('1234567890', 101),
('9876543210', 102),
('1111111111', 103),
('2222222222', 104),
('3333333333', 105);
select * from alumno_carrera_951;

create table profesor_materia_951 (
    profesor_951 varchar(10) foreign key references profesorcesde_951(documento_identidad_951),
    materia_951 int foreign key references materia_951(codigo_materia_951)
);
insert into alumno_carrera_951 (alumno_951, carrera_951)
values
('1234567890', 101),
('9876543210', 102),
('1111111111', 103),
('2222222222', 104),
('3333333333', 105);
select * from profesor_materia_951;

select * from alumno_951
where edad_951 < 15 and ciudad_residencia_951 = 'cali';

select * from alumno_951
where ciudad_residencia_951 = 'bogot�';

update alumno_951
set ciudad_residencia_951 = 'bogot�'
where ciudad_residencia_951 = 'cali';


select a.*, c.nombre_carrera_951
from alumno_951 a
inner join alumno_carrera_951 ac on a.documento_identidad_951 = ac.alumno_951
inner join carrera_951 c on ac.carrera_951 = c.codigo_carrera_951;


-- unique
alter table alumno_951 add constraint uc_alumno_951_correo_951 unique (correo_951);
alter table profesorcesde_951 add constraint uc_profesorcesde_951_correo_951 unique (correo_951);

-- primary keys
alter table alumno_951 add constraint pk_alumno_951 primary key (documento_identidad_951);
alter table carrera_951 add constraint pk_carrera_951 primary key (codigo_carrera_951);
alter table profesorcesde_951 add constraint pk_profesorcesde_951 primary key (documento_identidad_951);
alter table alumno_carrera_951 add constraint pk_alumno_carrera_951 primary key (alumno_951, carrera_951);
alter table profesor_materia_951 add constraint pk_profesor_materia_951 primary key (profesor_951, materia_9510);
-- foreign keys
alter table alumno_materia_951 add constraint fk_alumno_materia_951_alumno_951 foreign key (alumno_951) references alumno_951(documento_identidad_951);
alter table alumno_materia_951 add constraint fk_alumno_materia_951_materia_951 foreign key (materia_951) references materia_951(codigo_materia_951);
alter table alumno_carrera_951 add constraint fk_alumno_carrera_951_alumno_951 foreign key (alumno_951) references alumno_951(documento_identidad_951);
alter table alumno_carrera_951 add constraint fk_alumno_carrera_951_carrera_951 foreign key (carrera_951) references carrera_951(codigo_carrera_951);
alter table profesor_materia_951 add constraint fk_profesor_materia_951_profesor_951 foreign key (profesor_951) references profesorcesde_951(documento_identidad_951);
alter table profesor_materia_951 add constraint fk_profesor_materia_951_materia_951 foreign key (materia_951) references materia_951(codigo_materia_951);

select * from alumno_951;
select * from carrera_951;
select * from materia_951;
select * from profesorcesde_951;
select * from alumno_materia_951;
select * from alumno_carrera_951;
select * from profesor_materia_951;