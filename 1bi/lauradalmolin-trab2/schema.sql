CREATE TABLE contatos (
	nome VARCHAR(60),
	cpf VARCHAR(20) PRIMARY KEY,
	endereco VARCHAR(80)
);

CREATE TABLE telefones (
	telefone VARCHAR(13),
	cpf VARCHAR(20) REFERENCES contatos(cpf)
	
);

DROP TABLE contatos;
DROP TABLE telefones