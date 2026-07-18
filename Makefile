CC = gcc
CFLAGS = -Wall -g
SRC = src/main.c src/equipement.c src/fichier.c
OBJ = src/main.o src/equipement.o src/fichier.o
TARGET = inventaire

all: $(TARGET)
	@echo "Compilation reussie : ./$(TARGET)"

$(TARGET): $(OBJ)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJ)

src/%.o: src/%.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJ) $(TARGET)
	@echo "Nettoyage effectue."

run: all
	./$(TARGET)