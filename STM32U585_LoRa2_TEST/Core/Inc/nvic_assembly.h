/*
 * nvic_assembly.h
 *
 *  Created on: Sep 7, 2025
 *      Author: peter
 */

#ifndef NVIC_ASSEMBLY_H_
#define NVIC_ASSEMBLY_H_

extern void NVIC_TIM8_Enable_Interupt(void);
extern void NVIC_SPI1_Enable_Interupt(void);
extern void NVIC_EXTI15_Enable_Interupt(void);
extern void NVIC_IPR6_EXTI15_priority(void);

#endif /* NVIC_ASSEMBLY_H_ */
