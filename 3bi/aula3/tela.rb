require 'tk'
require 'tkextlib/bwidget'

=begin

# exemplo 1
root = TkRoot.new { 
	title "Hello World!"
}

# ou TkLabel.new() do -> quando tiver só uma janela no arquivo
TkLabel.new(root) do
	text 'Hello, World!'
	font '150px'
	background "blue"
	pack { 
		padx 15;
		pady 15;
		side 'left'
	}
end

# criando dois TkLabel duas mensagens são exibidas na caixa
TkLabel.new(root) do
	text 'Olá Mundo'
	pack { 
		padx 15;
		pady 15;
		side 'right'
	}
end
Tk.mainloop

############

# exemplo 2

require "tk"

f1 = TkFrame.new {
   relief 'sunken'
   borderwidth 3
   background "red"
   padx 15
   pady 20
   pack('side' => 'left')
}
f2 = TkFrame.new {
   relief 'groove'
   borderwidth 1
   background "yellow"
   padx 10
   pady 10
   pack('side' => 'right')
}

TkButton.new(f1) {
   text 'Button1'
   # dentro dos commands é que se faz a persistência
   # tem que chamar o dao, pegar os dados do usuário, etc
   command {print "push button1!!\n"}
   pack('fill' => 'x')
}
TkButton.new(f1) {
   text 'Button2'
   command {print "push button2!!\n"}
   pack('fill' => 'x')
}
TkButton.new(f2) {
   text 'Quit'
   command 'exit'
   pack('fill' => 'x')
}
TkLabel.new() {
	text "Oi..."
	pack('padx' => '15px', 'pady' => '15px')
}
Tk.mainloop
=end

root = TkRoot.new
root.title = "Window"
root.height = 400
root.width = 250

entry1 = TkEntry.new(root)
label1 = TkLabel.new(root) do 
	text 'Nome:'
end

entry2 = TkEntry.new(root) do
	show '*'
end
label2 = TkLabel.new(root) do 
	text 'Senha:'
end

list = TkListbox.new(root) do
	width 20
	height 10
	setgrid 1
	selectmode 'multiple'
	pack('fill' => 'x')
end

list.insert 0, "yellow", "gray", "green", "blue", "violet"

combobox = Tk::BWidget::ComboBox.new(root)
combobox.values =  ['Tobias', 'Rex', 'Tobby', 'Bota']
combobox.place('height' => 25, 'width' => 100, 'x' => 10, 'y' => 300)

def myproc(entry1, entry2, list)
	recebido = entry1.get
	recebido = recebido + "\n" + entry2.get + "\n"
	recebido = recebido + list.get(list.curselection[0])

	#retornando
	msgBox = Tk.messageBox(
		'type' => "ok",
		'icon' => "info",
		'title' => "Informações",
		'message' => recebido
	)
end

def func(combobox)

	msgBox = Tk.messageBox(
		'type' => "ok",
		'icon' => "info",
		'title' => "Informações",
		'message' => combobox.text
	)
end

button1 = TkButton.new(root) do
	text "Ok1"
	command (proc {myproc(entry1, entry2, list)})
end

button2 = TkButton.new(root) do
	text "Ok2"
	command (proc {func(combobox)})
end

entry1.place('height' => 25, 'width' => 150, 'x' => 55, 'y' => 10)
label1.place('height' => 25, 'width' => 45, 'x' => 5, 'y' => 10)
button1.place('height' => 25, 'width' => 45, 'x' => 5, 'y' => 80)
button2.place('height' => 25, 'width' => 45, 'x' => 55, 'y' => 80)
entry2.place('height' => 25, 'width' => 150, 'x' => 55, 'y' => 40)
label2.place('height' => 25, 'width' => 45, 'x' => 5, 'y' => 40)
list.place('height' => 100, 'width' => 100, 'x' => 5, 'y' => 150)

Tk.mainloop