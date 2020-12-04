################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include Practicas/Practica2/subdir.mk
-include Practicas/Practica1/subdir.mk
-include Practicas/Practica\ 3/subdir.mk
-include Estructuras/subdir.mk
-include Ejercicios/Ejercicios2/LinkedList/subdir.mk
-include Ejercicios/Ejercicios2/DoubleLinkedList/subdir.mk
-include Ejercicios/Ejercicios1/subdir.mk
-include Básico/subdir.mk
-include subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 

# All Target
all: PySC

# Tool invocations
PySC: $(OBJS) $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: Cross GCC Linker'
	gcc  -o "PySC" $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(EXECUTABLES)$(OBJS)$(C_DEPS) PySC
	-@echo ' '

.PHONY: all clean dependents

-include ../makefile.targets
