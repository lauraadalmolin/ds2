CREATE TABLE alunos (
	nome VARCHAR(60),
	cpf SERIAL PRIMARY KEY,
);

CREATE TABLE atendimentos (
	data_hora_inicio VARCHAR(40),
	data_hora_fim VARCHAR(40),
	duvidas VARCHAR(200),
	professor VARCHAR(60),
	cpf VARCHAR(20) REFERENCES contatos(cpf)	
);

DROP TABLE alunos;
DROP TABLE atendimentos;