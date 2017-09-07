require 'tk'
require 'tkextlib/bwidget'
require './models.rb'

def clearInicio
	$entry1.destroy
	$label1.destroy
	$button1.destroy
	$entry2.destroy
	$label2.destroy
end

def clearAdmin
	$f1.destroy
	$f2.destroy
	$f3.destroy
	$f4.destroy
end

def clearUsuario
	$g1.destroy
	$g2.destroy
	$g3.destroy
	$g4.destroy
end

def clearEditaUsuario
	$f5.destroy
end

def clearEditaAnotacao
	$g5.destroy
end

def appendEditaAnotacao(anotacao)
	$g5 = TkFrame.new($root) {
	   relief 'groove'
	   borderwidth 1
	   background "lavender"
	   padx 15
	   pady 20
	   pack('side' => 'left')
	}
	TkLabel.new($g5) {
		text 'Nome:'
		pack('fill' => 'x')
	}
	$entrada8 = TkEntry.new($g5) {
		pack('fill' => 'x')
	}
	$entrada8.set(anotacao.titulo)
	TkLabel.new($g5) {
		text 'Descrição:'
		pack('fill' => 'x')
	}
	$entrada9 = TkEntry.new($g5) {
		pack('fill' => 'x')
	}
	$entrada9.set(anotacao.descricao)
	TkLabel.new($g5) {
		pack('fill' => 'x')
		text 'Data-Hora:'
	} 
	$entrada10 = TkEntry.new($g5) {
		pack('fill' => 'x')
	}
	$entrada10.set(anotacao.dataHora.to_s)
	$botao5 = TkButton.new($g5) {
		pack('fill' => 'x')
		command (proc {salvaEdicaoAnotacao(anotacao.id)})
		text "Enviar"
	}
	
end

def appendEditaUsuario(usuario)
	$f5 = TkFrame.new($root) {
	   relief 'groove'
	   borderwidth 1
	   background "lavender"
	   padx 15
	   pady 20
	   pack('side' => 'left')
	}
	TkLabel.new($f5) {
		text 'Nome:'
		pack('fill' => 'x')
	}
	$entry8 = TkEntry.new($f5) {
		pack('fill' => 'x')
	}
	$entry8.set(usuario.nome)
	TkLabel.new($f5) {
		text 'Login:'
		pack('fill' => 'x')
	}
	$entry9 = TkEntry.new($f5) {
		pack('fill' => 'x')
	}
	$entry9.set(usuario.login)
	TkLabel.new($f5) {
		pack('fill' => 'x')
		text 'Senha:'
	} 
	$entry10 = TkEntry.new($f5) {
		show '*'
		pack('fill' => 'x')
	}
	$entry10.set(usuario.senha)
	$button5 = TkButton.new($f5) {
		pack('fill' => 'x')
		command (proc {salvaEdicaoUsuario(usuario.id)})
		text "Enviar"
	}
	
end

def appendAdmin
	$f1 = TkFrame.new($root) {
	   relief 'groove'
	   borderwidth 1
	   background "lavender"
	   padx 15
	   pady 20
	   pack('side' => 'left')
	}
	$f2 = TkFrame.new($root) {
	   relief 'groove'
	   borderwidth 1
	   background "yellow"
	   padx 15
	   pady 20
	   pack('side' => 'right')
	}
	$f3 = TkFrame.new($root) {
	   relief 'groove'
	   borderwidth 1
	   background "white"
	   padx 15
	   pady 20
	   pack('side' => 'right')
	}
	$f4 = TkFrame.new($root) {
	   relief 'groove'
	   borderwidth 1
	   background "pink"
	   padx 15
	   pady 20
	   pack('side' => 'right')
	}
	TkLabel.new($f1) {
	   text 'Adicionar'
	   pack('fill' => 'x')
	}
	TkLabel.new($f2) {
	   text 'Remover'
	   pack('fill' => 'x')
	}
	TkLabel.new($f3) {
	   text 'Listar'
	   pack('fill' => 'x')
	}
	TkLabel.new($f4) {
	   text 'Editar'
	   pack('fill' => 'x')
	}
	TkLabel.new($f1) {
		text 'Nome:'
		pack('fill' => 'x')
	}
	$entry3 = TkEntry.new($f1) {
		pack('fill' => 'x')
	}
	TkLabel.new($f1) {
		text 'Login:'
		pack('fill' => 'x')
	}
	$entry4 = TkEntry.new($f1) {
		pack('fill' => 'x')
	}
	TkLabel.new($f1) {
		pack('fill' => 'x')
		text 'Senha:'
	} 
	$entry5 = TkEntry.new($f1) {
		show '*'
		pack('fill' => 'x')
	}
	$button2 = TkButton.new($f1) {
		pack('fill' => 'x')
		command (proc {adicionaUsuario})
		text "Enviar"
	}
	$list_usuarios = TkListbox.new($f3) do
		width 40
		height 20
		setgrid 1
		listvariable $varlista
		pack('fill' => 'x')
	end
	TkLabel.new($f2) {
		pack('fill' => 'x')
		text 'Digite o código do usuário a ser excluído:'
	} 
	$entry6 = TkEntry.new($f2) {
		pack('fill' => 'x')
	}

	$button3 = TkButton.new($f2) {
		pack('fill' => 'x')
		command (proc {excluiUsuario})
		text "Enviar"
	}
	TkLabel.new($f4) {
		pack('fill' => 'x')
		text 'Digite o código do usuário a ser editado:'
	} 
	$entry7 = TkEntry.new($f4) {
		pack('fill' => 'x')
	}

	$button4 = TkButton.new($f4) {
		pack('fill' => 'x')
		command (proc {editaUsuario})
		text "Enviar"
	}

end

def appendUsuario
	$g1 = TkFrame.new($root) {
	   relief 'groove'
	   borderwidth 1
	   background "lavender"
	   padx 15
	   pady 20
	   pack('side' => 'left')
	}
	$g2 = TkFrame.new($root) {
	   relief 'groove'
	   borderwidth 1
	   background "yellow"
	   padx 15
	   pady 20
	   pack('side' => 'right')
	}
	$g3 = TkFrame.new($root) {
	   relief 'groove'
	   borderwidth 1
	   background "white"
	   padx 15
	   pady 20
	   pack('side' => 'right')
	}
	$g4 = TkFrame.new($root) {
	   relief 'groove'
	   borderwidth 1
	   background "pink"
	   padx 15
	   pady 20
	   pack('side' => 'right')
	}
	TkLabel.new($g1) {
	   text 'Adicionar'
	   pack('fill' => 'x')
	}
	TkLabel.new($g2) {
	   text 'Remover'
	   pack('fill' => 'x')
	}
	TkLabel.new($g3) {
	   text 'Listar'
	   pack('fill' => 'x')
	}
	TkLabel.new($g4) {
	   text 'Editar'
	   pack('fill' => 'x')
	}
	TkLabel.new($g1) {
		text 'Título:'
		pack('fill' => 'x')
	}
	$entrada3 = TkEntry.new($g1) {
		pack('fill' => 'x')
	}
	TkLabel.new($g1) {
		text 'Descricao:'
		pack('fill' => 'x')
	}
	$entrada4 = TkEntry.new($g1) {
		pack('fill' => 'x')
	}
	TkLabel.new($g1) {
		pack('fill' => 'x')
		text 'Data-Hora:'
	} 
	$entrada5 = TkEntry.new($g1) {
		pack('fill' => 'x')
	}
	$botao2 = TkButton.new($g1) {
		pack('fill' => 'x')
		command (proc {adicionaAnotacao})
		text "Enviar"
	}
	$list_anotacao = TkListbox.new($g3) do
		width 60
		height 20
		setgrid 1
		listvariable $varlista2
		pack('fill' => 'x')
	end
	TkLabel.new($g2) {
		pack('fill' => 'x')
		text 'Digite o código do usuário a ser excluído:'
	} 
	$entrada6 = TkEntry.new($g2) {
		pack('fill' => 'x')
	}

	$botao3 = TkButton.new($g2) {
		pack('fill' => 'x')
		command (proc {excluiAnotacao})
		text "Enviar"
	}
	TkLabel.new($g4) {
		pack('fill' => 'x')
		text 'Digite o código do usuário a ser editado:'
	} 
	$entrada7 = TkEntry.new($g4) {
		pack('fill' => 'x')
	}

	$botao4 = TkButton.new($g4) {
		pack('fill' => 'x')
		command (proc {editaAnotacao})
		text "Enviar"
	}

end

def criaVetor(usuarios)
	vetorz = []
	usuarios.each do |usuario|
		vetorz.push("Login: " + usuario.login + " | Nome: " + usuario.nome + " | Id: " + usuario.id.to_s)
	end
	return vetorz
end

def criaVetorAnotacao(anotacoes)
	vetorz = []
	anotacoes.each do |anotacao|
		var = "Título: " + anotacao.titulo + " | Descricao: " + anotacao.descricao + " | Id: " + anotacao.id.to_s + " | DataHora: " + anotacao.dataHora.to_s
		var = var[0, var.length - 9]
		#var = var.gsub! 'T', ' '
		vetorz.push(var)
	end
	return vetorz
end

def testaLogin
	login = $entry1.get
	senha = $entry2.get
	usuarios = Usuario.all
	usuario_teste = Usuario.new
	usuarios.each do |usuario|
		if (usuario.login == login && usuario.senha == senha)
			usuario_teste = usuario
			$usuario_real = Usuario.get(usuario.id)
		end
	end 
	if usuario_teste.login == 'admin' && usuario_teste.senha == senha
		clearInicio
		$root.title = "Administrar Usuários"
		vetUsuarios = Usuario.all
		vetor = criaVetor(vetUsuarios)
		$varlista = TkVariable.new(vetor)
		appendAdmin	
	else 
		clearInicio
		$root.title = "Anotações"
		vetor = criaVetorAnotacao($usuario_real.anotacaos)
		$varlista2 = TkVariable.new(vetor)
		appendUsuario
	end
end

def adicionaUsuario 
	nome = $entry3.get
	login = $entry4.get
	senha = $entry5.get
	usuario = Usuario.new
	usuario.nome = nome
	usuario.login = login
	usuario.senha = senha
	usuario.save
	$entry3.set("")
	$entry4.set("")
	$entry5.set("")
	#$button2.destroy
end

def adicionaAnotacao
	titulo = $entrada3.get
	descricao = $entrada4.get
	dataHora = $entrada5.get	
	anotacao = Anotacao.new
	anotacao.titulo = titulo
	anotacao.descricao = descricao
	anotacao.dataHora = dataHora
	anotacao.usuario = $usuario_real
	anotacao.save
	$entrada3.set("")
	$entrada4.set("")
	$entrada5.set("")
	#$button2.destroy
end

def excluiUsuario
	id = $entry6.get
	usuario = Usuario.get(id)
	if usuario != nil
		if usuario.login != 'admin' 
			usuario.destroy
		end
	end
	clearAdmin
	appendAdmin
end

def excluiAnotacao
	id = $entrada6.get
	anotacao = Anotacao.get(id)
	if anotacao != nil
		anotacao.destroy
	end
	clearUsuario
	appendUsuario
end

def editaUsuario
	id = $entry7.get
	usuario = Usuario.get(id)
	if (usuario != nil)
		clearAdmin
		appendEditaUsuario(usuario)
	end
end

def editaAnotacao
	id = $entrada7.get
	anotacao = Anotacao.get(id)
	if (anotacao != nil)
		clearUsuario
		appendEditaAnotacao(anotacao)
	end
end

def salvaEdicaoUsuario(id)
	usuario = Usuario.get(id)
	usuario.update(:nome => $entry8.get, :login => $entry9.get, :senha => $entry10.get)
	clearEditaUsuario
	appendAdmin
end

def salvaEdicaoAnotacao(id)
	anotacao = Anotacao.get(id)
	anotacao.update(:titulo => $entrada8.get, :descricao => $entrada9.get, :dataHora => $entrada10.get)
	clearEditaAnotacao
	appendUsuario
end


$root = TkRoot.new
$root.title = "Window"
$root.height = 400
$root.width = 400

$entry1 = TkEntry.new($root)
$label1 = TkLabel.new($root) do 
	text 'Nome:'
end		

$entry2 = TkEntry.new($root) do
	show '*'
end
$label2 = TkLabel.new($root) do 
	text 'Senha:'
end

$button1 = TkButton.new($root) do
	text "Enviar"
	command (proc {testaLogin})
end

$entry1.place('height' => 25, 'width' => 150, 'x' => 55, 'y' => 10)
$label1.place('height' => 25, 'width' => 45, 'x' => 5, 'y' => 10)
$button1.place('height' => 25, 'width' => 45, 'x' => 5, 'y' => 80)
$entry2.place('height' => 25, 'width' => 150, 'x' => 55, 'y' => 40)
$label2.place('height' => 25, 'width' => 45, 'x' => 5, 'y' => 40)



Tk.mainloop