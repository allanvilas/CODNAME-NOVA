extends NinePatchRect

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const lite = preload("res://lib/novo.gdns")
onready var db = lite.new()

var cena 

var id = 1
var valor = ""
var query = ""
var id_consulta = ""

func _ready():
	print(cena)
	if (!db.open_db("res://db/teste.sql")):
		print("Cannot open database.");
		return;
	else: 
		print("database opened.")
		print("ID =" + str(id))
		print(db.fetch_array("SELECT num FROM teste WHERE = "+str(id) +";"))
		print(db.fetch_array("SELECT * FROM teste WHERE = "+str(id) +";"))
	pass

#ID DO BANCO
func _on_inserir_text_entered(new_text):
	id = new_text
	pass # replace with function body
	
#valor a ser inserido
func _on_valor_text_entered(new_text):
	valor = new_text
	pass 
	
#botão de ação para dar update
func _on_inserir2_pressed():
	query += "UPDATE teste"
	query += " set num = "
	query += str(valor)
	query += " WHERE id = " + str(id) + ";"
	print(query)
	db.query(query)
	print(db.fetch_array("SELECT num FROM teste WHERE = "+str(id) + ";"))
	query = ""
	pass 

func _on_fechar_pressed():
	pass 

func _on_consultar_text_entered(new_text):
	id_consulta = new_text
	pass 
	
func _on_resultado2_pressed():
	var result = db.fetch_array("SELECT num FROM teste WHERE = "+str(id_consulta)+";")
	$resultado.set_text("Rsultado:" + str(result))
	pass 