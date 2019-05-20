extends KinematicBody2D

onready var cena 
onready var highscore

# normal = 0 *** teste = 1
export var mode = 0
var mode_cena

var cell_position = []
var cell_magnitude = [] 
var cell_weight = []

export var vida = 50
var mana = 50
var xp = 0
var nivel = 1

#danos
export var dano_minimo = 12.0
export var dano_maximo = 25.0

onready var ray_up = $up
onready var ray_down = $down
onready var ray_left = $left
onready var ray_right = $right

var move_up = true
var move_down = true
var move_left = true
var move_right = true

var selv_position
var free_move = false
var can_move = false
var attack_move = false
var solve_attack_move = false
var velocidade = Vector2(0,0)
var velocidade_de_mov = 2500

var state = {move = 0,
			 attack_move = 0,
			 idle = 0,
			 patrol = 0,
			 free = 0}
var player
var player_position 

var direction_size
var direction = {
	up = Vector2(0,-1),
	down =	Vector2(0,1),
	left =	Vector2(1,0),
	right = Vector2(-1,0)}
# Vector2(X,Y)
# index (0,-1) = cima // (0,1) = baixo // Vector2(1,0) = direita // Vector2(-1,0) = esquerda
var attack_tipe = 0

var dir 

var id

var dead = false

var direction_solve = Vector2(0,0)

var all_cells = []
#var i = 0

var spawn_ref
var cena_ref
var root_group 
func _ready():
	
	root_group = get_tree().get_nodes_in_group("root")
	for i in root_group.size():
		print("------------------------------")
		print(root_group[i])
		print(root_group[i].get_name())
		if root_group[i].get_name() == "Cena":
			cena_ref = root_group[i]
			cena = root_group[i]
			print(cena_ref)
			pass
		if root_group[i].get_name() == "Spawn":
			spawn_ref = root_group[i]
			print(spawn_ref)
			pass
		if root_group[i].get_name() == "highscore":
			highscore = root_group[i]
			print(highscore)
			pass
		print("------------------------------")
		pass
		
	mode_cena = cena.mode
	if mode_cena == 0:
		pass
	elif mode_cena == 1:
		if mode == 0:
			$Camera2D.make_current()
		pass
	else:
		#nothing
		pass
		
	if mode == 1:
		queue_free()
		pass
	id = cena.enemies.size() + 1
	cena.enemies[id] = self
	print(cena.enemies)
	player = cena.player
	all_cells.resize(cena.cell_magnitude.size())
	print(set_position((spawn_ref.cell_position[(round(rand_range(0.0,float(spawn_ref.cell_position.size())))-1)])+Vector2(16,16)))
	
	pass
	
func calculate_magnitude():
	for i in cell_position.size():
		cell_magnitude.resize(cell_position.size())
		var celula_alvo = cell_position[i]
		var shelf_position = get_global_position()
		var magnitude = celula_alvo - shelf_position
		var h = (sqrt(magnitude.x * magnitude.x + magnitude.y * magnitude.y))
		cell_magnitude[i] = floor(h)
		#print(cell_magnitude)
	pass
	
func calculate_nearest():
	#print(cell_magnitude.min())
	var value = 1
	var nearest 
	var base = cell_magnitude[0]
	
	for i in cell_magnitude.size():
		if i <=11:
			value += 1
			pass
		if cell_magnitude[i] == null:
			return print("cell magnitude = null")
		if base >= cell_magnitude[i]:
			base = cell_magnitude[i]
			nearest = base
			#print("meu Nearest: "+str(nearest))
			#print("Index"+str( ))
		else:
			nearest = base
			#print("meu Nearest: "+str(nearest))
			pass
		
	pass
func patroll_move():
	
	if cena_ref != null:
		self.cell_position = cena_ref.cell_position 
		calculate_magnitude()
		calculate_nearest()
		#for i in cena_ref.cell_position.size():
			#print(cena_ref.cell_position)
		pass
	else:
		print("Patroll move deu muito errado")
		print(cena_ref)
	pass
	
	
	
func _physics_process(delta):
	sprite_orientation()
	#movimentação básica do personagem
	if dead == false and can_move == true:
		print("pode andar")
		move_and_slide(dir * velocidade_de_mov)
		
	
	#movimentação de ataque do personagem
	if dead == false:
		if attack_move == true:
			$Sprite.set_rotation(get_angle_to(player.get_position()) - deg2rad(92))
			selv_position = get_global_position()
			player_position = player.get_global_position()
			var direc = (player_position - selv_position).normalized()
			move_and_slide(direc * velocidade_de_mov * delta)
			pass
		#MOVIMENTO DE CORREÇÃO DE ATAQUE
		if solve_attack_move == true:
			solve_attack_move = attck_move_direction_solve()
			move_and_slide(solve_attack_move * velocidade_de_mov * delta)
			solve_attack_move = false
			pass
			#MOVIMENTO DE EVASAO + ATAQUE
		if free_move == true:
			#$Sprite.set_rotation(get_angle_to((player.get_position())) - deg2rad(92))
			selv_position = get_global_position()
			player_position = player.get_global_position()
			var direc = (player_position - selv_position).normalized()	
			move_and_slide((-direc) * velocidade_de_mov * delta)
			var mag = player_position - selv_position
			mag = sqrt(mag.x * mag.x + mag.y * mag.y)
			if mag >= randi()%100+25:
				attack_move = true
				free_move = false
			pass
		else:
			#pass
			pass
	#se o personagem colidir com a parede ele muda sua direção
	if can_move == true and is_on_wall() == true and dead == false:
		dir = move()
	pass
	
# FUNÇÃO QUE POSICIONA OS SPRITES NA POSIÇÃO CORRETA
func sprite_orientation():
	
	if (dir == Vector2(0,-1)):
		$Sprite.set_rotation(deg2rad(180))
		$Sprite.set_flip_h(true)
	elif dir == Vector2(0,1):
		$Sprite.set_rotation(deg2rad(0))
		$Sprite.set_flip_h(false)
		
	elif dir == Vector2(1,0):
		$Sprite.set_rotation(deg2rad(270))
		$Sprite.set_flip_h(true)
		
	elif dir == Vector2(-1,0):
		$Sprite.set_rotation(deg2rad(90))
		$Sprite.set_flip_h(false)
		
	else:
		$Sprite.set_rotation(deg2rad(0))
		$Sprite.set_flip_h(false)
	pass
	
#FUNÇÃO QUE CORRIGE A DIREÇÃO AO ENTRAR EM MOVIMENTO DE ATAQUE
func attck_move_direction_solve():
	var direction
	if ray_up.is_colliding() == true:
		attack_move = false
		solve_attack_move = true
		direction = Vector2(0,1)
		#print("Colidindo para cima")

	if ray_down.is_colliding() == true:
		attack_move = false
		solve_attack_move = true
		direction= Vector2(0,-1)
		#print("Colidindo para baixo")
		
	if ray_left.is_colliding() == true:
		attack_move = false
		solve_attack_move = true
		direction = Vector2(1,0)
		#print("Colidindo à esquerda")
		
	if ray_right.is_colliding() == true:
		attack_move = false
		solve_attack_move = true
		direction = Vector2(-1,0)
		#print("Colidindo à direita")
	else:
		#print("Livre")
		direction = Vector2(0,0)
		solve_attack_move = false
		attack_move = true
		pass
	return direction
	pass	

# FUNÇÃO QUE DEFINE A DIREÇÃO EM QUE O INIMIGO VAI ANDAR
func move():
	var direc = []
	if ray_up.is_colliding() == false:
		direc.append(Vector2(0,-1))
		#print("up colidindo")

	if ray_down.is_colliding() == false:
		direc.append(Vector2(0,1))
		#print("down colidindo")
		
	if ray_left.is_colliding() == false:
		direc.append(Vector2(1,0))
		#print("left colidindo")
		
	if ray_right.is_colliding() == false:
		direc.append(Vector2(-1,0))
		#print("right colidindo")
		
	#print(direc.size())
	var dir = direc[randi()%direc.size()]
	#print(dir)
	return dir 
	pass

#assim que o player entrar na area de visão da ia
func _on_vision_body_entered(body):
	if body.get_name() == "player":
		player = body
		attack_move = true
		can_move =  false
		free_move = false
		pass
	pass
	
## quando o ia faz contato com o player	
func _on_attack_area_body_entered(body):
	if dead == false and body.get_name() == "player":
		var dano = int(round(rand_range(dano_minimo,dano_maximo)))
		player.damage(dano)
		highscore.total_dano_recebido += dano
		free_move = true
		attack_move = false
		can_move =  false
	pass

## FUNÇÃO DE DECREMENTO DE VIDA
func damage(dano):
	attack_move = true
	vida -= dano
	$damage_text/damage.set_text(str(dano))
	highscore.total_dano_causado += dano
	$damage_text/damage_animation.play("shwo")
	if vida <=0:
		dead = true
		$Sprite.set_animation("dead")
		can_move = false
		attack_move = false
		dir = Vector2(0,0)
		$timers/dead.start()
	pass

#ATTACK TIMER TIMEOUT
func _on_attack_timer_timeout():
	pass

# INICIO DO CICLO DE ANDAR
func _on_walk_timeout():
	
	pass
# FIM DO CICLO DE ANDAR
func _on_stop_timeout():
	
	pass
	
# ASSIM QUE MORREU
func _on_dead_timeout():
	var myname = get_name()
	cena.enemies.erase(myname)
	print("__________Inimigos em Cena__________")
	print("Inimigos: "+str(cena.enemies))
	print("____________________________________")
	cena.add_xp()
	highscore.inimigos_mortos += 1
	queue_free()
	pass

func _on_attack_mov_change_timeout():
	if dead == false and velocidade_de_mov <= 3500:
		velocidade_de_mov += 100
		print(velocidade_de_mov)
	else:
		$timers/attack_mov_change.stop()
		print("stop")
		pass
	pass 

func _on_patrol_timer_timeout():
	patroll_move()
	pass 