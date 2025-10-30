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
