# Variables de herramientas
CC = iverilog
FLAGS = -Wall
OUT = simulation.vvp
VCD = mult_32_TB.vcd

# Regla por defecto
all: compile simulate

# Compilación: Asegúrate de que no haya caracteres raros en los .v
compile:
	$(CC) $(FLAGS) -o $(OUT) mult_32.v mult_32_TB.v

# Ejecución
simulate:
	vvp $(OUT)

# Ver ondas
waves:
	gtkwave $(VCD)

clean:
	rm -f $(OUT) $(VCD)