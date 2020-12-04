################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../130319/Lista.c \
../130319/Pila.c \
../130319/driver.c 

OBJS += \
./130319/Lista.o \
./130319/Pila.o \
./130319/driver.o 

C_DEPS += \
./130319/Lista.d \
./130319/Pila.d \
./130319/driver.d 


# Each subdirectory must supply rules for building sources it contributes
130319/%.o: ../130319/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross GCC Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


