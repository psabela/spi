/*
 * nvic_assembly.s
 *
 *  Created on: Sep 7, 2025
 *      Author: peter
 */


.syntax unified
.cpu cortex-m33
.fpu softvfp
.thumb

.text

//.global NVIC_ADC12_Enable_Interupt
.global NVIC_TIM8_Enable_Interupt
.global NVIC_SPI1_Enable_Interupt
.global NVIC_EXTI15_Enable_Interupt
.global NVIC_IPR6_EXTI15_priority
//.global NVIC_DMA1_Enable_Interupt
//.global NVIC_TIM2_Enable_Interupt
//.global NVIC_DMA_CH15_Enable_Interupt
//.global NVIC_IPR11_GPDMA_CH15_Set

//0xE000E100 NVIC_ISER RW 0x00000000 Interrupt Set-Enable Register
.equ NVIC_ISER_BASE,		0xE000E100U
.equ NVIC_TIM8,				0xE000E104U //52
.equ NVIC_TIM8_PIN, 		20			//52-32
.equ NVIC_SPI1,				0xE000E104U
.equ NVIC_SPI1_PIN,			27//26

//setup priority
//EXTI15 has irq_num =  26
//irq_num / 4 = 6 is Index 6 (IPR6)
//(irq_num % 4) * 8 = 16 is Bit 16
.equ NVIC_IPR0,	0xE000E400UL
.equ NVIC_IPR1,	0xe000e404UL
.equ NVIC_IPR2,	0xe000e408UL
.equ NVIC_IPR3,	0xe000e40cUL
.equ NVIC_IPR4,	0xe000e410UL
.equ NVIC_IPR5,	0xe000e414UL
.equ NVIC_IPR6,	0xe000e418UL


#define NVIC_BASE      (0xE000E100UL)


//26 34 Settable EXTI15EXTI Line15 interrupt  0x0000 00A8
.equ NVIC_EXTI15,			0xE000E100U
.equ NVIC_EXTI15_PIN,		26


//position 52 TIM8 update  0x00000110
NVIC_TIM8_Enable_Interupt:
	LDR		R1, =NVIC_TIM8
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, NVIC_TIM8_PIN
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

NVIC_SPI1_Enable_Interupt:
	LDR		R1, =NVIC_SPI1
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, NVIC_SPI1_PIN
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

NVIC_EXTI15_Enable_Interupt:
	LDR		R1, =NVIC_EXTI15
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, NVIC_EXTI15_PIN
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR


//NVIC_ICER_EXTI15_Clear_Interupt
//Each NVIC priority register (e.g., NVIC_IPR0) is 32 bits wide
//and controls four different interrupts (8 bits per interrupt). 
//The Register Index: Divide the IRQ number by 4. For IRQ 26, \(26\div 4=6.5\).
//This means the priority is in NVIC_IPR6 (the 7th register, index 6).
//The Bit Offset: Use the modulo operator \((IRQ\quad (\mod 4))\times 8\).
//For IRQ 26, \(26\quad (\mod 4)=2\), and \(2\times 8=16\).
//The 8 bits for EXTI15 start at bit 16.
//Active Bits: While 8 bits are reserved per IRQ,
//most STM32 MCUs only implement the upper 4 bits of that byte for priority (0–15 levels). 
//    uint32_t irq_num = 26;
//    uint32_t reg_idx = irq_num / 4;   // Index 6 (IPR6)
//    uint32_t bit_pos = (irq_num % 4) * 8; // Bit 16
NVIC_IPR6_EXTI15_priority:
	LDR		R1, =NVIC_IPR6
	LDR		R0, [R1]
	MOVS	R2, 0xFF
	LSLS	R2, 16
	MVNS	R2, R2
	ANDS 	R0, R2
	MOVS	R2, 0x00	//priority 0
	LSLS	R2, 16
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR






