################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../070319/Pila.c \
../070319/ejercicios.c \
../070319/estructuras.c 

OBJS += \
./070319/Pila.o \
./070319/ejercicios.o \
./070319/estructuras.o 

C_DEPS += \
./070319/Pila.d \
./070319/ejercicios.d \
./070319/estructuras.d 


# Each subdirectory must supply rules for building sources it contributes
070319/%.o: ../070319/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross GCC Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


