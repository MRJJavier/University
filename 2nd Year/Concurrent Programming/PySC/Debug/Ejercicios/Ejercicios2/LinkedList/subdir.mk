################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Ejercicios/Ejercicios2/LinkedList/FindTheBugs.c \
../Ejercicios/Ejercicios2/LinkedList/LinkedList.c 

OBJS += \
./Ejercicios/Ejercicios2/LinkedList/FindTheBugs.o \
./Ejercicios/Ejercicios2/LinkedList/LinkedList.o 

C_DEPS += \
./Ejercicios/Ejercicios2/LinkedList/FindTheBugs.d \
./Ejercicios/Ejercicios2/LinkedList/LinkedList.d 


# Each subdirectory must supply rules for building sources it contributes
Ejercicios/Ejercicios2/LinkedList/%.o: ../Ejercicios/Ejercicios2/LinkedList/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross GCC Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


