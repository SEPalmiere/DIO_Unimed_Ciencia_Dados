show databases;
use oficina_mecanica;
show tables;
 desc cliente;
select * from pessoa;
select Pnome, Snome,Sobrenome, Sexo from pessoa;
select Pnome, Snome,Sobrenome from pessoa where (Sexo = 'feminino');
select concat (Pnome, ' ', Snome, ' ',Sobrenome) as nome from pessoa where (Sexo = 'feminino');
select CPF, Data_nascimento from pessoa
	where Sobrenome ='Bosch';
    
select * from cliente;
Select Pnome, Snome,Sobrenome from pessoa, cliente
	where Pessoa_CPF = CPF;
    Select Pnome, Snome,Sobrenome, CPF from pessoa, cliente
	where Pessoa_CPF = CPF
    group by Sobrenome;
    
select * from mecanico;
alter table cliente add UFF char(2) not null default 'SP';
desc cliente;
select * from cliente;
update cliente set UFF = 'RJ' where idCliente = '2';

desc pessoa;
insert into pessoa (CPF, Pnome, Snome, Sobrenome, Data_nascimento, Sexo) values ('18268974563', 'Kayla', 'Sarah', 'Fernandes', '1989-01-01-00:00:00', 'feminino');

SELECT COUNT(CPF) from pessoa;
select * from veiculo;

Select concat (Pnome, ' ', Snome, ' ',Sobrenome) as nome, Modelo, Marca, Placa 
	from pessoa p, cliente c, veiculo v
	where p.CPF = c.Pessoa_CPF and c.Veiculo_idveiculo = v.idveiculo;

Select concat (Pnome, ' ', Snome, ' ',Sobrenome) as nome, Modelo, Marca, Placa 
	from pessoa p, cliente c, veiculo v
	where p.CPF = c.Pessoa_CPF and c.Veiculo_idveiculo = v.idveiculo
    Order by nome;
 
 Select concat (Pnome, ' ', Snome, ' ',Sobrenome) as nome, Modelo, Marca, Placa 
	from pessoa p, cliente c, veiculo v
	where p.CPF = c.Pessoa_CPF and c.Veiculo_idveiculo = v.idveiculo and Marca like 'Cadillac';
 
 Select concat (Pnome, ' ', Snome, ' ',Sobrenome) as nome, Modelo, Marca, Placa 
	from pessoa p, cliente c, veiculo v
	where p.CPF = c.Pessoa_CPF and c.Veiculo_idveiculo = v.idveiculo and Marca like '%lac';
 
 Select concat (Pnome, ' ', Snome, ' ',Sobrenome) as nome, Modelo, Marca, Placa 
	from pessoa p, cliente c, veiculo v
	where p.CPF = c.Pessoa_CPF and c.Veiculo_idveiculo = v.idveiculo and Marca like 'Cadi%';   
    
    desc mecanico;
    update mecanico set salario = salario * 1000 where idMecanico = '6'; 
    select * from mecanico;
    
Select concat (Pnome, ' ', Snome, ' ',Sobrenome) as nome, CPF, sexo, salario
	from mecanico m , pessoa p
	where p.CPF = m.Pessoa_CPF and (salario between 3300 and 3500);
    
    Select concat (Pnome, ' ', Snome, ' ',Sobrenome) as nome, CPF, sexo, salario
	from mecanico m , pessoa p
	where p.CPF = m.Pessoa_CPF
    order by salario desc;

-- O comando abaixo retorna o nome da mesma pessoa mecanico varias vezes, para corrigir isso declaramos Distinct no comando Select
Select concat (Pnome, ' ', Snome, ' ',Sobrenome) as nome, CPF, sexo 
	from pessoa p, cliente c, mecanico m
	where (p.CPF = c.Pessoa_CPF or p.CPF = m.Pessoa_CPF);


 -- Usando distinct para recuperar somente um mecanico das tabelas   
Select Distinct concat (Pnome, ' ', Snome, ' ',Sobrenome) as nome, CPF, sexo 
	from pessoa p, cliente c, mecanico m
	where (p.CPF = c.Pessoa_CPF or p.CPF = m.Pessoa_CPF);
    
    
Select Distinct concat (Pnome, ' ', Snome, ' ',Sobrenome) as nome, CPF, sexo 
	from pessoa p, cliente c, mecanico m
	where (p.CPF = c.Pessoa_CPF or p.CPF = m.Pessoa_CPF) and sexo = 'feminino'
    order by CPF;
    
  Select Distinct concat (Pnome, ' ', Snome, ' ',Sobrenome) as nome, CPF 
	from pessoa p, cliente c, mecanico m
	where (p.CPF = c.Pessoa_CPF or p.CPF = m.Pessoa_CPF)
    order by CPF;
    
    -- Pessoas que não sao clientes e nem mecanicos utilizando Subqueries
  
	Select Distinct concat (Pnome, ' ', Snome, ' ',Sobrenome) as nome, CPF, sexo 
       from pessoa p, cliente c, mecanico m
		where CPF not in 
		(select CPF 
			from pessoa p, cliente c, mecanico m
            where p.CPF = c.Pessoa_CPF or p.CPF = m.Pessoa_CPF);

-- Selecionar o nome de todos os clientes usando Exists
Select concat(p.Pnome, ' ', p.Snome, ' ',p.Sobrenome)
	from pessoa p
    where exists (select * from cliente as c, veiculo as v
					where p.CPF = c.Pessoa_CPF);
                    
Select * from Pessoa
Order by CPF Limit 5;

Select * from Pessoa
Order by Sobrenome, Pnome Limit 5;

Select * from Pessoa
Order by Sobrenome desc, Pnome Limit 5;

Select count(*) from Pessoa
	Where Sexo = 'feminino';


Select concat(Pnome, ' ', Snome, ' ', Sobrenome) as nome, Sexo, Especialidade from mecanico m, Pessoa p
where p.CPF = m.Pessoa_CPF;

Select Pessoa_CPF, count(*), avg(salario) from mecanico
	group by Especialidade;
    
Select count(*), avg(salario), Especialidade from mecanico
	group by Especialidade;
    
 Select count(*), round(avg(salario),2) as salario, Especialidade from mecanico
	group by Especialidade
    order by salario desc;

Select sum(salario) as total_sal, max(salario) as Max_sal, min(salario) as Min_sal, avg(salario) as media_salario from mecanico;

Select concat(Pnome, ' ', Snome, ' ', Sobrenome), Data_nascimento from Pessoa
Where Sexo = 'feminino'
group by Data_nascimento;

Select Sexo, count(Sexo) from Pessoa
group by Sexo;


Select concat(Pnome, ' ', Snome, ' ', Sobrenome) as nome, Sexo, Especialidade, salario from mecanico m, Pessoa p
where p.CPF = m.Pessoa_CPF
Group by Especialidade
Having salario > 3400;

-- Case statement

Select * from mecanico;

-- Atualiazar todos os salarios dos mecanicos
-- Observe que o safe mode  do workbench devera estar desabilitado

	Update mecanico  Set salario =
	case 
		WHEN Especialidade ='soldador'		then salario + 200 
		WHEN Especialidade ='finalizador'  	then salario + 150 
        WHEN Especialidade ='reparador' 	then salario + 100
		WHEN Especialidade ='preparador'	then salario + 50
        Else salario + 0
        End;
        
-- Join

Select concat(p.Pnome, ' ', p.Snome, ' ', p.Sobrenome) as nome, m.Especialidade, m.salario
	fROM Pessoa p Join mecanico m
    On p.CPF = m.Pessoa_CPF;
    
Select * from Pessoa 
	Join cliente
    On CPF = Pessoa_CPF;
    
Select * from Pessoa, cliente
	Where CPF = Pessoa_CPF;
    
Select concat(Pnome, ' ', Snome, ' ', Sobrenome) as nome, Especialidade, salario 
from (Pessoa  Join mecanico on CPF = Pessoa_CPF)
   where Sexo = 'feminino';
   
-- Join com mais de duas tabelas
show tables;
select * from ordem_servico;
select * from equipe;
select * from trabalha;
select * from oficina;
select * from veiculo;

update ordem_servico set Descricao = 'Liberado para manutencao'
	where idOS = 3;
    
-- Outer Join traz valores nulos quando não encontra match (Para usar a função outer join aplicamos o Left Join ou Left Outer Join).


Select * from pessoa inner join mecanico on CPF = Pessoa_CPF;
Select * from pessoa full join mecanico on CPF = Pessoa_CPF;

Select * from pessoa left join mecanico on CPF = Pessoa_CPF;
Select * from pessoa left outer join mecanico on CPF = Pessoa_CPF;


    
