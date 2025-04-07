extends Node2D

var random = RandomNumberGenerator.new()
var grid_size = 10
var cell_size = 40
var population_size = 50
var gene_length = 10
var generations = 100
var mutation_rate = 0.1
var default_font = ThemeDB.fallback_font
var default_font_size = ThemeDB.fallback_font_size

# Định nghĩa nút của cây nhị phân
class TreeNode:
	var value
	var left = null
	var right = null

	func _init(value):
		self.value = value

# Khởi tạo quần thể ban đầu
func initialize_population(population_size: int, gene_length: int) -> Array:
	var population = []
	for i in range(population_size):
		var chromosome = []
		for j in range(gene_length):
			chromosome.append(random.randi_range(1, 100))  # Tạo gene ngẫu nhiên (1 đến 100)
		population.append(chromosome)
	return population

# Hàm đánh giá (Fitness Function)
func fitness_function(chromosome: Array) -> float:
	var fitness = 0.0
	for gene in chromosome:
		fitness += gene  # Ví dụ: tính tổng các gene
	return fitness

# Đánh giá quần thể
func evaluate_population(population: Array) -> Array:
	var fitness_values = []
	for chromosome in population:
		fitness_values.append(fitness_function(chromosome))
	return fitness_values

# Chọn lọc theo giải đấu (Tournament Selection)
func tournament_selection(population: Array, fitness_values: Array, tournament_size: int) -> Array:
	var selected = []
	for i in range(tournament_size):
		var best = null
		var best_fitness = -INF
		for j in range(tournament_size):
			var index = random.randi() % population.size()
			if fitness_values[index] > best_fitness:
				best = population[index]
				best_fitness = fitness_values[index]
		selected.append(best)
	return selected

# Lai ghép một điểm (One-Point Crossover)
func one_point_crossover(parent1: Array, parent2: Array) -> Array:
	var crossover_point = random.randi() % parent1.size()
	var child1 = parent1.slice(0, crossover_point) + parent2.slice(crossover_point, parent2.size())
	var child2 = parent2.slice(0, crossover_point) + parent1.slice(crossover_point, parent1.size())
	return [child1, child2]

# Đột biến đơn điểm (Single-Point Mutation)
func mutate(chromosome: Array, mutation_rate: float) -> Array:
	for i in range(chromosome.size()):
		if random.randf() < mutation_rate:
			chromosome[i] = random.randi_range(1, 100)  # Thay đổi gene ngẫu nhiên (1 đến 100)
	return chromosome

# Thay thế quần thể cũ bằng quần thể mới
func replace_population(population: Array, new_population: Array) -> Array:
	return new_population

# Thuật toán di truyền hoàn chỉnh
func genetic_algorithm(population_size: int, gene_length: int, generations: int, mutation_rate: float) -> Array:
	var population = initialize_population(population_size, gene_length)
	for generation in range(generations):
		var fitness_values = evaluate_population(population)
		var selected_parents = tournament_selection(population, fitness_values, population_size / 2)
		var new_population = []
		while new_population.size() < population_size:
			var parent1 = selected_parents[random.randi() % selected_parents.size()]
			var parent2 = selected_parents[random.randi() % selected_parents.size()]
			var children = one_point_crossover(parent1, parent2)
			new_population.append(mutate(children[0], mutation_rate))
			new_population.append(mutate(children[1], mutation_rate))
		population = replace_population(population, new_population)
	return population

# Vẽ lưới 10x10
func _draw():
	for i in range(grid_size):
		for j in range(grid_size):
			draw_rect(Rect2(i * cell_size, j * cell_size, cell_size, cell_size), Color(1, 1, 1), false)

# Hiển thị quá trình di chuyển của robot
func display_path(path: Array):
	for gene in path:
		var x = (gene - 1) % grid_size
		var y = (gene - 1) / grid_size
		draw_rect(Rect2(x * cell_size, y * cell_size, cell_size, cell_size), Color(0, 1, 0), true)

# Tạo cây nhị phân từ đường đi
func create_binary_tree(path: Array) -> TreeNode:
	if path.size() == 0:
		return null
	var root = TreeNode.new(path[0])
	var current = root
	for i in range(1, path.size()):
		if i % 2 == 0:
			current.left = TreeNode.new(path[i])
			current = current.left
		else:
			current.right = TreeNode.new(path[i])
			current = current.right
	return root

# Hiển thị cây nhị phân
func display_binary_tree(node: TreeNode, x: int, y: int, level: int):
	if node == null:
		return
	draw_circle(Vector2(x, y), 10, Color(1, 0, 0))
	draw_string(default_font, Vector2(x - 5, y + 5), str(node.value), HORIZONTAL_ALIGNMENT_LEFT, -1, default_font_size)
	if node.left != null:
		draw_line(Vector2(x, y), Vector2(x - 40, y + 40), Color(1, 1, 1))
		display_binary_tree(node.left, x - 40, y + 40, level + 1)
	if node.right != null:
		draw_line(Vector2(x, y), Vector2(x + 40, y + 40), Color(1, 1, 1))
		display_binary_tree(node.right, x + 40, y + 40, level + 1)

# Ví dụ sử dụng
func _ready():
	var final_population = genetic_algorithm(population_size, gene_length, generations, mutation_rate)
	var best_path = final_population[0]  # Lấy đường đi tốt nhất
	display_path(best_path)
	var binary_tree = create_binary_tree(best_path)
	display_binary_tree(binary_tree, 400, 50, 0)
