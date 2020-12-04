################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../210219/EstructurasControl.c \
../210219/HolaMundo.c \
../210219/MapaMemoria.c \
../210219/ModeloBits.c \
../210219/TiposBasicos.c 

OBJS += \
./210219/EstructurasControl.o \
./210219/HolaMundo.o \
./210219/MapaMemoria.o \
./210219/ModeloBits.o \
./210219/TiposBasicos.o 

C_DEPS += \
./210219/EstructurasControl.d \
./210219/HolaMundo.d \
./210219/MapaMemoria.d \
./210219/ModeloBits.d \
./210219/TiposBasicos.d 


# Each subdirectory must supply rules for building sources it contributes
210219/%.o: ../210219/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross GCC Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


