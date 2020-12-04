################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Practicas/Practica2/arbolbb.c \
../Practicas/Practica2/p2.c 

OBJS += \
./Practicas/Practica2/arbolbb.o \
./Practicas/Practica2/p2.o 

C_DEPS += \
./Practicas/Practica2/arbolbb.d \
./Practicas/Practica2/p2.d 


# Each subdirectory must supply rules for building sources it contributes
Practicas/Practica2/%.o: ../Practicas/Practica2/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross GCC Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


