################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Practicas/Practica\ 3/Cola.c \
../Practicas/Practica\ 3/descifrar.c \
../Practicas/Practica\ 3/pruebacola.c 

OBJS += \
./Practicas/Practica\ 3/Cola.o \
./Practicas/Practica\ 3/descifrar.o \
./Practicas/Practica\ 3/pruebacola.o 

C_DEPS += \
./Practicas/Practica\ 3/Cola.d \
./Practicas/Practica\ 3/descifrar.d \
./Practicas/Practica\ 3/pruebacola.d 


# Each subdirectory must supply rules for building sources it contributes
Practicas/Practica\ 3/Cola.o: ../Practicas/Practica\ 3/Cola.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross GCC Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"Practicas/Practica 3/Cola.d" -MT"Practicas/Practica\ 3/Cola.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

Practicas/Practica\ 3/descifrar.o: ../Practicas/Practica\ 3/descifrar.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross GCC Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"Practicas/Practica 3/descifrar.d" -MT"Practicas/Practica\ 3/descifrar.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

Practicas/Practica\ 3/pruebacola.o: ../Practicas/Practica\ 3/pruebacola.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross GCC Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"Practicas/Practica 3/pruebacola.d" -MT"Practicas/Practica\ 3/pruebacola.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


