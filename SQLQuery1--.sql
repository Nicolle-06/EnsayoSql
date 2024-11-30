create database GabineteAbogados;
use GabineteAbogados;
create table Cliente (
  Id varchar(8) primary key,
  Nombre varchar(50),
  Direccion varchar(100),
  Telefono varchar(15),
  Email varchar(50)
);

create table Procurador (
  Id varchar(8) primary key,
  Nombre varchar(50),
  Dirección varchar(100),
  Teléfono varchar(15),
  Email varchar(50)
);

create table Asunto (
  Numero_exp int primary key,
  Fecha_inicio date,
  Fecha_fin date,
  Estado varchar(20),
  Cliente_id varchar(8) foreign key references Cliente(id),
  Procurador_id varchar(8) foreign key references Procurador(id)
);

create table Asunto_Procurador (
  Numero_exp int foreign key references Asunto(Numero_exp),
  Procurador_id varchar(8) foreign key references Procurador(id),
  primary key (Numero_exp, Procurador_id)
);

insert into Cliente (id, Nombre, Direccion, Telefono, Email)
values 
  ('36273819', 'Juan Pérez', 'Calle 1', '912345678', 'juan@gmail.com');

insert into Procurador (id, Nombre, Dirección, Teléfono, Email)
values 
  ('85936407', 'María García', 'Calle 2', '987654321', 'maria@gmail.com');

insert into Asunto (Numero_exp, Fecha_inicio, Fecha_fin, Estado, Cliente_id, Procurador_id)
values 
  (1, '2022-01-01', '2022-12-31', 'En tramite', '74863950', '98765432');

  alter table Asunto
add Descripción varchar(200);

alter table Asunto
drop column Descripción;

select * from Asunto
where Estado = 'En trámite';

select * from Cliente
where id = '987654321';

update Asunto
set Estado = 'Archivado'
where Numero_exp = 1;

delete from Asunto
where Numero_exp= 2;

select *
from Asunto
inner join Cliente
on Asunto.Cliente_id = Cliente.id;

select *
from Asunto
left join Procurador
on Asunto.Procurador_id = Procurador.id;

select *
from Asunto
right join Procurador
on Asunto.Procurador_id = Procurador.id;


select *
from Asunto
full join Procurador
on Asunto.Procurador_id = Procurador.id;

select *
from Asunto
inner join Asunto_Procurador
on Asunto.Numero_exp = Asunto_Procurador.Numero_exp
inner join Procurador
on Asunto_Procurador.Procurador_id = Procurador.id;



