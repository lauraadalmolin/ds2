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

def clearEditaVarinha
	$f5.destroy
end

def appendEditaVarinha(varinha)
	$f5 = TkFrame.new($root) {
	   relief 'groove'
	   borderwidth 1
	   background "lavender"
	   padx 15
	   pady 20
	   pack('side' => 'left')
	}
	TkLabel.new($f5) {
		text 'Madeira:'
		pack('fill' => 'x')
	}
	$entry8 = TkEntry.new($f5) {
		pack('fill' => 'x')
	}
	$entry8.set(varinha.wood)
	TkLabel.new($f5) {
		text 'Flexibilidade:'
		pack('fill' => 'x')
	}
	$entry9 = TkEntry.new($f5) {
		pack('fill' => 'x')
	}
	$entry9.set(varinha.flexibility)
	TkLabel.new($f5) {
		pack('fill' => 'x')
		text 'Núcleo:'
	} 
	$entry10 = TkEntry.new($f5) {
		pack('fill' => 'x')
	}
	$entry10.set(varinha.core)
	$button5 = TkButton.new($f5) {
		pack('fill' => 'x')
		command (proc {salvaEdicaoVarinha(varinha.id)})
		text "Enviar"
	}
	
end

def appendAdmin
	$f1 = TkFrame.new($root) {
	   relief 'groove'
	   borderwidth 1
	   background "#2e294e"
	   padx 15
	   pady 20
	   pack('side' => 'left')
	}
	$f2 = TkFrame.new($root) {
	   relief 'groove'
	   borderwidth 1
	   background "#dbad6a"
	   padx 15
	   pady 20
	   pack('side' => 'right')
	}
	$f3 = TkFrame.new($root) {
	   relief 'groove'
	   borderwidth 1
	   background "#7fb685"
	   padx 70
	   pady 20
	   pack('side' => 'left')
	}
	$f4 = TkFrame.new($root) {
	   relief 'groove'
	   borderwidth 1
	   background "#468189"
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
		text 'Madeira:'
		pack('fill' => 'x')
	}
	$entry3 = TkEntry.new($f1) {
		pack('fill' => 'x')
	}
	TkLabel.new($f1) {
		text 'Flexibilidade:'
		pack('fill' => 'x')
	}
	$entry4 = TkEntry.new($f1) {
		pack('fill' => 'x')
	}
	TkLabel.new($f1) {
		pack('fill' => 'x')
		text 'Núcleo:'
	} 
	$entry5 = TkEntry.new($f1) {
		pack('fill' => 'x')
	}
	$button2 = TkButton.new($f1) {
		pack('fill' => 'x')
		command (proc {adicionaVarinha})
		text "Enviar"
	}
	$list_varinhas = TkListbox.new($f3) do
		width 60
		height 20
		setgrid 1
		listvariable $varlista
		pack('fill' => 'x')
	end
	TkLabel.new($f2) {
		pack('fill' => 'x')
		text 'Digite o código da varinha a ser excluída:'
	} 
	$entry6 = TkEntry.new($f2) {
		pack('fill' => 'x')
	}

	$button3 = TkButton.new($f2) {
		pack('fill' => 'x')
		command (proc {excluiVarinha})
		text "Enviar"
	}
	TkLabel.new($f4) {
		pack('fill' => 'x')
		text 'Digite o código da varinha a ser editada:'
	} 
	$entry7 = TkEntry.new($f4) {
		pack('fill' => 'x')
	}

	$button4 = TkButton.new($f4) {
		pack('fill' => 'x')
		command (proc {editaVarinha})
		text "Enviar"
	}

end


def criaVetor(varinhas)
	vetorz = []
	varinhas.each do |varinha|
		vetorz.push("Id: " + varinha.id.to_s +  " | Madeira: " + varinha.wood + " | Flexibilidade: " + varinha.flexibility + " | Núcleo: " + varinha.core)
	end
	return vetorz
end


def testaLogin
	if ($entry1.get != "" && $entry2.get != "")
		login = $entry1.get
		senha = $entry2.get
		flag = false
		usuarios = Usuario.all
		usuarios.each do |usuario|
			if (usuario.login == login && usuario.password == senha)
					flag = true
					$usuario_real = Usuario.get(usuario.id)
					clearInicio
					$root.title = "Administrar Usuários"
					vetVarinhas = Wand.all
					vetor = criaVetor(vetVarinhas)
					$varlista = TkVariable.new(vetor)
					appendAdmin	
			end
		end
		if (flag == false)
			Tk::messageBox :message => 'Sua senha ou o seu usuário estão errados'
		end
	else
		Tk::messageBox :message => 'Você precisa preencher todos os campos'
	end
end

def adicionaVarinha 
	if ($entry3.get != "" && $entry4.get != "" && $entry5.get != "")
		wood = $entry3.get
		flexibility = $entry4.get
		core = $entry5.get
		wand = Wand.new
		wand.wood = wood
		wand.flexibility = flexibility
		wand.core = core
		wand.save
		$entry3.set("")
		$entry4.set("")
		$entry5.set("")
		vetVarinhas = Wand.all
		vetor = criaVetor(vetVarinhas)
		$varlista = TkVariable.new(vetor)
		clearAdmin
		appendAdmin
	else 
		Tk::messageBox :message => 'Você precisa preencher todos os campos'
	end
	#$button2.destroy
end


def excluiVarinha
	if ($entry6.get != "")
		id = $entry6.get
		if Wand.get(id)
			varinha = Wand.get(id)
			varinha.destroy
			vetVarinhas = Wand.all
			vetor = criaVetor(vetVarinhas)
			$varlista = TkVariable.new(vetor)
			clearAdmin
			appendAdmin
		else
			Tk::messageBox :message => 'Não foi encontrada uma varinha para este id'
		end
	else 
		Tk::messageBox :message => 'Você precisa preencher o campo'
	end
end

def editaVarinha
	if ($entry7.get != "")
		id = $entry7.get
		if (Wand.get(id))
			varinha = Wand.get(id)
			clearAdmin
			appendEditaVarinha(varinha)
		else
	 		Tk::messageBox :message => 'Não foi encontrada uma varinha para este id'
		end
	else
	 	Tk::messageBox :message => 'Você precisa preencher o campo'
	end
end

def salvaEdicaoVarinha(id)
	varinha = Wand.get(id)
	varinha.update(:wood => $entry8.get, :flexibility => $entry9.get, :core => $entry10.get)
	vetVarinhas = Wand.all
	vetor = criaVetor(vetVarinhas)
	$varlista = TkVariable.new(vetor)
	clearEditaVarinha
	appendAdmin
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