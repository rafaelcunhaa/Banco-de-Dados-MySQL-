create schema clinica_veti;
USE clinica_veti;

-- Tutor(id, cpf, nome, email, fone) /* */

/*     drop table tutor;   apaga a tabela*/
CREATE TABLE tutor(
	id INT primary key auto_increment,
    cpf varchar(12) not null,
    nome varchar(150) not null, 
    email varchar(150) , 
    fone varchar(25) not null,
	unique(cpf, email, fone)
);

-- Tutor_endereço(id, id_resp, cep, rua, numero, complemento, cidade, uf)
drop table if exists tutor_endereco;
create table tutor_endereco(
	id int primary key auto_increment,
	id_resp int not null,
	cep varchar(8) not null,
    rua varchar(50) not null,
	numero varchar(5) not null,
    compçemento varchar(100),
    cidade varchar(50) not null,
    uf varchar(2) not null,
	foreign key (id_resp) references tutor(id)
);

-- Animal(id, id_tut, peso, raca, especie, cor, sexo, data_nasc)
drop table if exists animal;
create table animal(
	id INT primary key auto_increment,
    id_tut int not null,
    nome varchar(100) not null,
    peso decimal(5,2) not null, 
    raca varchar(50), 
    especie varchar(50) not null, 
    cor varchar(50) not null, 
    sexo enum('Macho','Femea') not null, 
    data_nasc date not null,
    foreign key (id_tut) references tutor(id)
    );
    
  --  Veterinário(id, nome, crmv, email, fone, especialidade)
drop table if exists veterinario;
create table veterinario(
	id int primary key auto_increment,
	nome varchar(100) not null,
	crmv varchar(50) not null,
	email varchar(150),
	fone varchar(25) not null,
	especialidade varchar(50) not null,
	unique(crmv, fone)
);

-- Veterinario_endereço(id, id_vet, cep, rua, numero, complemento, cidade, uf)
drop table if exists veterinario_endereco;
create table veterinario_endereco(
	id int primary key auto_increment,
    id_vet int not null,
    cep varchar(8) not null,
    rua varchar(50) not null,
    numero varchar(5) not null,
    complemento varchar(100),
	cidade varchar(50) not null,
	uf varchar(2) not null,
    foreign key (id_vet) references veterinario(id)
);

    
  --  Consulta(id, id_vet, id_animal, dt, horario)
  drop table if exists consulta;
  create table consulta(
	id int primary key auto_increment,
    id_vet int not null,
    id_animal int not null,
	dt date not null,
	horario varchar(6),
	foreign key (id_vet) references veterinario(id),
	foreign key (id_animal) references animal(id),
    unique(dt,horario)
  );
    