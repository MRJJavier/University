################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Ejercicios/Ejercicios2/DoubleLinkedList/DoubleLinkedList.c \
../Ejercicios/Ejercicios2/DoubleLinkedList/FindTheBugs.c 

OBJS += \
./Ejercicios/Ejercicios2/DoubleLinkedList/DoubleLinkedList.o \
./Ejercicios/Ejercicios2/DoubleLinkedList/FindTheBugs.o 

C_DEPS += \
./Ejercicios/Ejercicios2/DoubleLinkedList/DoubleLinkedList.d \
./Ejercicios/Ejercicios2/DoubleLinkedList/FindTheBugs.d 


# Each subdirectory must supply rules for building sources it contributes
Ejercicios/Ejercicios2/DoubleLinkedList/%.o: ../Ejercicios/Ejercicios2/DoubleLinkedList/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross GCC Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


