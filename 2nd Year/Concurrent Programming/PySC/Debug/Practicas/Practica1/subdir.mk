################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Practicas/Practica1/driver.c \
../Practicas/Practica1/driver1.c \
../Practicas/Practica1/manejador.c \
../Practicas/Practica1/practica1.c 

OBJS += \
./Practicas/Practica1/driver.o \
./Practicas/Practica1/driver1.o \
./Practicas/Practica1/manejador.o \
./Practicas/Practica1/practica1.o 

C_DEPS += \
./Practicas/Practica1/driver.d \
./Practicas/Practica1/driver1.d \
./Practicas/Practica1/manejador.d \
./Practicas/Practica1/practica1.d 


# Each subdirectory must supply rules for building sources it contributes
Practicas/Practica1/%.o: ../Practicas/Practica1/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross GCC Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


