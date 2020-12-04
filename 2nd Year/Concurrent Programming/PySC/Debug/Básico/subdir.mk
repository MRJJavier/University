################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Básico/Arrays.c \
../Básico/EstructurasControl.c \
../Básico/HolaMundo.c \
../Básico/MapaMemoria.c \
../Básico/ModeloBits.c \
../Básico/Punteros.c \
../Básico/TiposBasicos.c \
../Básico/TiposEstructurados.c 

OBJS += \
./Básico/Arrays.o \
./Básico/EstructurasControl.o \
./Básico/HolaMundo.o \
./Básico/MapaMemoria.o \
./Básico/ModeloBits.o \
./Básico/Punteros.o \
./Básico/TiposBasicos.o \
./Básico/TiposEstructurados.o 

C_DEPS += \
./Básico/Arrays.d \
./Básico/EstructurasControl.d \
./Básico/HolaMundo.d \
./Básico/MapaMemoria.d \
./Básico/ModeloBits.d \
./Básico/Punteros.d \
./Básico/TiposBasicos.d \
./Básico/TiposEstructurados.d 


# Each subdirectory must supply rules for building sources it contributes
Básico/%.o: ../Básico/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross GCC Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


