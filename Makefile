# Makefile for the project moodlamp

PROJECT=moodlamp
SOURCES=main.c
CC=avr-gcc
OBJCOPY=avr-objcopy
MMCU=attiny85
F_CPU=8000000
PROGRAMMER=dragon_hvsp
CFLAGS=-mmcu=$(MMCU) -Wall -DF_CPU=$(F_CPU) -Os

$(PROJECT).hex: $(PROJECT).out
	$(OBJCOPY) -j .text -O ihex $(PROJECT).out $(PROJECT).hex

$(PROJECT).out: $(SOURCES)
	$(CC) $(CFLAGS) -I./ -o $(PROJECT).out $(SOURCES)

# may require root rights for locating usb for avr dragon
program: $(PROJECT).hex
	avrdude -p t85 -c $(PROGRAMMER) -P usb -e -U flash:w:$(PROJECT).hex
clean:
	rm -f $(PROJECT).out
	rm -f $(PROJECT).hex
