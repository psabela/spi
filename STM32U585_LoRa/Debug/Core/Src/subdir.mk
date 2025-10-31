################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (12.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_SRCS += \
../Core/Src/gpio_assembly.s \
../Core/Src/nvic_assembly.s \
../Core/Src/rcc_assembly.s \
../Core/Src/spi_master_assembly.s \
../Core/Src/tim8_assembly.s 

C_SRCS += \
../Core/Src/main.c 

OBJS += \
./Core/Src/gpio_assembly.o \
./Core/Src/main.o \
./Core/Src/nvic_assembly.o \
./Core/Src/rcc_assembly.o \
./Core/Src/spi_master_assembly.o \
./Core/Src/tim8_assembly.o 

S_DEPS += \
./Core/Src/gpio_assembly.d \
./Core/Src/nvic_assembly.d \
./Core/Src/rcc_assembly.d \
./Core/Src/spi_master_assembly.d \
./Core/Src/tim8_assembly.d 

C_DEPS += \
./Core/Src/main.d 


# Each subdirectory must supply rules for building sources it contributes
Core/Src/%.o: ../Core/Src/%.s Core/Src/subdir.mk
	arm-none-eabi-gcc -mcpu=cortex-m33 -g3 -DDEBUG -c -x assembler-with-cpp -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-sp-d16 -mfloat-abi=hard -mthumb -o "$@" "$<"
Core/Src/%.o Core/Src/%.su Core/Src/%.cyclo: ../Core/Src/%.c Core/Src/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m33 -std=gnu11 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32U585xx -c -I"/home/peter/Documents/stm_projects/STM/wks2/spi/STM32U585_LoRa/Drivers/CMSIS/Device" -I"/home/peter/Documents/stm_projects/STM/wks2/spi/STM32U585_LoRa/Drivers/CMSIS/Include" -I"/home/peter/Documents/stm_projects/STM/wks2/spi/STM32U585_LoRa/Core/Inc" -I"/home/peter/Documents/stm_projects/STM/wks2/spi/STM32U585_LoRa/sx126x_driver/inc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Core-2f-Src

clean-Core-2f-Src:
	-$(RM) ./Core/Src/gpio_assembly.d ./Core/Src/gpio_assembly.o ./Core/Src/main.cyclo ./Core/Src/main.d ./Core/Src/main.o ./Core/Src/main.su ./Core/Src/nvic_assembly.d ./Core/Src/nvic_assembly.o ./Core/Src/rcc_assembly.d ./Core/Src/rcc_assembly.o ./Core/Src/spi_master_assembly.d ./Core/Src/spi_master_assembly.o ./Core/Src/tim8_assembly.d ./Core/Src/tim8_assembly.o

.PHONY: clean-Core-2f-Src

