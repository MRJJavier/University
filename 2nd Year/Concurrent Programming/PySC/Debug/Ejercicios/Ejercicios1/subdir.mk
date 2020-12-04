################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Ejercicios/Ejercicios1/Invierte.c \
../Ejercicios/Ejercicios1/Suma.c \
../Ejercicios/Ejercicios1/Vocales.c 

OBJS += \
./Ejercicios/Ejercicios1/Invierte.o \
./Ejercicios/Ejercicios1/Suma.o \
./Ejercicios/Ejercicios1/Vocales.o 

C_DEPS += \
./Ejercicios/Ejercicios1/Invierte.d \
./Ejercicios/Ejercicios1/Suma.d \
./Ejercicios/Ejercicios1/Vocales.d 


# Each subdirectory must supply rules for building sources it contributes
Ejercicios/Ejercicios1/%.o: ../Ejercicios/Ejercicios1/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross GCC Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


