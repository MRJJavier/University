################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../150319/Ficheros.c \
../150319/ListaPersona.c 

OBJS += \
./150319/Ficheros.o \
./150319/ListaPersona.o 

C_DEPS += \
./150319/Ficheros.d \
./150319/ListaPersona.d 


# Each subdirectory must supply rules for building sources it contributes
150319/%.o: ../150319/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross GCC Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


