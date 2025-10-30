/*
 * rcc_assembly.h
 *
 *  Created on: Jul 9, 2025
 *      Author: peter
 */

#ifndef RCC_ASSEMBLY_H_
#define RCC_ASSEMBLY_H_

extern void ASM_RCC_AHB2ENR1_GPIOEEN_Set(void);
extern void ASM_RCC_AHB2ENR1_GPIOAEN_Set(void);
extern void ASM_RCC_AHB2ENR1_GPIODEN_Set(void);
extern void ASM_RCC_APB2ENR_SPI1_Set(void);
extern void ASM_RCC_APB2ENR_TIM8EN_Set(void);
extern void ASM_RCC_CCIPR1_SPI1SEL_HSI16(void);
extern void ASM_RCC_CCIPR1_SPI1SEL_PCLK2(void);
extern void ASM_RCC_CCIPR1_SPI1SEL_SYSCLK(void);
extern void ASM_RCC_CFGR2_HPRE_2(void);
extern void ASM_RCC_CFGR2_PCLK2_2(void);
extern void ASM_RCC_CFGR1_MCOSEL_HSI16(void);
extern void ASM_RCC_CFGR1_MCOSEL_HSI48(void);
extern void ASM_RCC_CFGR1_MCOSEL_SYSCLK(void);
extern void ASM_RCC_CFGR1_MCOSEL_MSIK(void);
extern void ASM_RCC_CFGR1_MCOSEL_MSIS(void);
extern void ASM_RCC_CFGR1_MCOSEL_HSE(void);
extern void ASM_RCC_CFGR1_MCOSEL_PLL1(void);
extern void ASM_RCC_CR_HSI16(void);
extern uint32_t ASM_RCC_CR_HSI16RDY(void);
extern void ASM_RCC_CR_HSI48(void);
extern uint32_t ASM_RCC_CR_HSI48RDY(void);
extern void ASM_RCC_CR_SYSCLK(void);
extern uint32_t ASM_RCC_CR_SYSCLKRDY(void);
extern void ASM_RCC_CR_MSIK(void);
extern uint32_t ASM_RCC_CR_MSIKRDY(void);
extern void ASM_RCC_CR_MSIS(void);
extern uint32_t ASM_RCC_CR_MSISRDY(void);
extern void ASM_RCC_CR_HSE(void);
extern uint32_t ASM_RCC_CR_HSERDY(void);
extern void ASM_RCC_CR_PLL1(void);
extern uint32_t ASM_RCC_CR_PLL1RDY(void);
extern void ASM_RCC_PLL1CFGR_PLL1SRC_HSI16(void);
extern void ASM_RCC_PLL1CFGR_PLL1PEN(void);
extern void ASM_RCC_PLL1CFGR_PLL1QEN(void);
extern void ASM_RCC_PLL1CFGR_PLL1REN(void);
extern void ASM_RCC_PLL1CFGR_PLL1M_3(void);
extern void ASM_RCC_PLL1DIVR_PLL1N_4(void);
extern void ASM_RCC_PLL1DIVR_PLL1N_5(void);
extern void ASM_RCC_PLL1DIVR_PLL1N_6(void);
extern void ASM_RCC_CFGR1_SW_PLL1(void);
extern uint32_t ASM_RCC_CFGR1_SWS(void);


#endif /* RCC_ASSEMBLY_H_ */
