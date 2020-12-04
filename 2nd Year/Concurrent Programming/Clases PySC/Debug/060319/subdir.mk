################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../060319/Puns.c \
../060319/estructuras.c \
../060319/intercambiar.c \
../060319/invierte.c \
../060319/suma.c \
../060319/vocales.c 

OBJS += \
./060319/Puns.o \
./060319/estructuras.o \
./060319/intercambiar.o \
./060319/invierte.o \
./060319/suma.o \
./060319/vocales.o 

C_DEPS += \
./060319/Puns.d \
./060319/estructuras.d \
./060319/intercambiar.d \
./060319/invierte.d \
./060319/suma.d \
./060319/vocales.d 


# Each subdirectory must supply rules for building sources it contributes
060319/%.o: ../060319/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross GCC Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


