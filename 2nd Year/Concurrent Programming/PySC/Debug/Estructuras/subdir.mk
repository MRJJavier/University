################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Estructuras/Estructuras.c \
../Estructuras/Lista.c \
../Estructuras/Persona.c \
../Estructuras/Pila.c 

OBJS += \
./Estructuras/Estructuras.o \
./Estructuras/Lista.o \
./Estructuras/Persona.o \
./Estructuras/Pila.o 

C_DEPS += \
./Estructuras/Estructuras.d \
./Estructuras/Lista.d \
./Estructuras/Persona.d \
./Estructuras/Pila.d 


# Each subdirectory must supply rules for building sources it contributes
Estructuras/%.o: ../Estructuras/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross GCC Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


