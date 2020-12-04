################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../270219/Arrays.c \
../270219/TiposEstructurados.c 

OBJS += \
./270219/Arrays.o \
./270219/TiposEstructurados.o 

C_DEPS += \
./270219/Arrays.d \
./270219/TiposEstructurados.d 


# Each subdirectory must supply rules for building sources it contributes
270219/%.o: ../270219/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross GCC Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


