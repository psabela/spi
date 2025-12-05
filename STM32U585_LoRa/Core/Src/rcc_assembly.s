/*
 * rcc_assembly.s
 *
 *  Created on: Jul 7, 2025
 *      Author: peter
 */

.syntax unified
.cpu cortex-m33
.fpu softvfp
.thumb

.text

.global ASM_RCC_AHB2ENR1_GPIOEEN_Set
.global ASM_RCC_AHB2ENR1_GPIOAEN_Set
.global ASM_RCC_AHB2ENR1_GPIODEN_Set
.global ASM_RCC_AHB2ENR1_GPIOCEN_Set

.global ASM_RCC_APB2ENR_SPI1_Set
.global ASM_RCC_APB2ENR_TIM8EN_Set
.global ASM_RCC_CCIPR1_SPI1SEL_HSI16
.global ASM_RCC_CCIPR1_SPI1SEL_PCLK2
.global ASM_RCC_CCIPR1_SPI1SEL_SYSCLK
.global ASM_RCC_CCIPR1_SPI1SEL_MSIK
.global ASM_RCC_CFGR2_HPRE_2
.global ASM_RCC_CFGR2_PCLK2_2
.global ASM_RCC_CFGR1_MCOSEL_HSI16
.global ASM_RCC_CFGR1_MCOSEL_HSI48
.global ASM_RCC_CFGR1_MCOSEL_SYSCLK
.global ASM_RCC_CFGR1_MCOSEL_MSIK
.global ASM_RCC_CFGR1_MCOSEL_MSIS
.global ASM_RCC_CFGR1_MCOSEL_HSE
.global ASM_RCC_CFGR1_MCOSEL_PLL1
.global ASM_RCC_CR_HSI16
.global ASM_RCC_CR_HSI16RDY
.global ASM_RCC_CR_HSI48
.global ASM_RCC_CR_HSI48RDY
.global ASM_RCC_CR_SYSCLK
.global ASM_RCC_CR_SYSCLKRDY
.global ASM_RCC_CR_MSIK
.global ASM_RCC_CR_MSIKRDY
.global ASM_RCC_CR_MSIS
.global ASM_RCC_CR_MSISRDY
.global ASM_RCC_CR_HSE
.global ASM_RCC_CR_HSERDY
.global ASM_RCC_CR_PLL1
.global ASM_RCC_CR_PLL1RDY
.global ASM_RCC_PLL1CFGR_PLL1SRC_HSI16
.global ASM_RCC_PLL1CFGR_PLL1PEN
.global ASM_RCC_PLL1CFGR_PLL1QEN
.global ASM_RCC_PLL1CFGR_PLL1REN
.global ASM_RCC_PLL1CFGR_PLL1M_3
.global ASM_RCC_PLL1DIVR_PLL1N_4
.global ASM_RCC_PLL1DIVR_PLL1N_5
.global ASM_RCC_PLL1DIVR_PLL1N_6
.global ASM_RCC_CFGR1_SW_PLL1
.global ASM_RCC_CFGR1_SWS
.global ASM_RCC_ICSCR1_MSIKRANGE_SET
.global ASM_RCC_ICSCR1_MSIRGSEL_1

.global RUN_COUNTER
.global RESET_COUNTER



.equ RCC_BASE_ADDR, 		0x46020C00U
.equ RCC_ICSCR1_OFFSET, 	0x008
.equ RCC_AHB2ENR1_OFFSET, 	0x8CU
.equ RCC_APB2ENR_OFFSET, 	0xA4U
.equ RCC_CCIPR1_OFFSET, 	0x0E0U
.equ RCC_CFGR2_OFFSET, 		0x020U
.equ RCC_CFGR1_OFFSET,		0x01CU
.equ RCC_PLL1CFGR_OFFSET,   0x028U
.equ RCC_PLL1DIVR_OFFSET, 	0x034U




ASM_RCC_APB2ENR_TIM8EN_Set:
	LDR		R1, =RCC_BASE_ADDR
	LDR		R2, =RCC_APB2ENR_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x01
	LSLS	R2, #13
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

ASM_RCC_AHB2ENR1_GPIOEEN_Set:
	//enable clock on GPIOE
	LDR		R1, =RCC_BASE_ADDR
	LDR		R2, =RCC_AHB2ENR1_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #4 //Bit 4 GPIOEEN: I/O port E clock enable
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

ASM_RCC_AHB2ENR1_GPIOAEN_Set:
	//enable clock on GPIOH
	LDR		R1, =RCC_BASE_ADDR
	LDR		R2, =RCC_AHB2ENR1_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	//Bit 1 GPIOAEN: I/O port A clock enable
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

ASM_RCC_AHB2ENR1_GPIODEN_Set:
	//enable clock on GPIOD
	LDR		R1, =RCC_BASE_ADDR
	LDR		R2, =RCC_AHB2ENR1_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #3 //Bit 3 GPIODEN: I/O port D clock enable
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

ASM_RCC_AHB2ENR1_GPIOCEN_Set:
	//enable clock on GPIOC
	LDR		R1, =RCC_BASE_ADDR
	LDR		R2, =RCC_AHB2ENR1_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #2 //Bit 2 GPIOCEN: I/O port C clock enable
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR


ASM_RCC_APB2ENR_SPI1_Set:
	//Bit 12 SPI1EN: SPI1 clock enable
	LDR		R1, =RCC_BASE_ADDR
	LDR		R2, =RCC_APB2ENR_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #12
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

//Bits 21:20 SPI1SEL[1:0]: SPI1 kernel clock source selection
//These bits are used to select the SPI1 kernel clock source.
//00: PCLK2 selected
//01: SYSCLK selected
//10: HSI16 selected
//11: MSIK selected
//Note: The SPI1 is functional in Stop 0 and Stop 1 mode only when the kernel clock is HSI16 or
//MSIK.

ASM_RCC_CCIPR1_SPI1SEL_MSIK:
	LDR		R1, =RCC_BASE_ADDR
	LDR		R2, =RCC_CCIPR1_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x3
	LSLS	R2, #20
	MVNS	R2, R2
	ANDS	R0, R2	//clear bits
	MOVS	R2, 0x3
	LSLS	R2, #20
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

ASM_RCC_CCIPR1_SPI1SEL_HSI16:
	LDR		R1, =RCC_BASE_ADDR
	LDR		R2, =RCC_CCIPR1_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x3
	LSLS	R2, #20
	MVNS	R2, R2
	ANDS	R0, R2	//clear bits
	MOVS	R2, 0x2
	LSLS	R2, #20
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

ASM_RCC_CCIPR1_SPI1SEL_PCLK2:
	LDR		R1, =RCC_BASE_ADDR
	LDR		R2, =RCC_CCIPR1_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x3
	LSLS	R2, #20
	MVNS	R2, R2
	ANDS	R0, R2	//clear bits
	STR		R0, [R1]
	BX LR

ASM_RCC_CCIPR1_SPI1SEL_SYSCLK:
	LDR		R1, =RCC_BASE_ADDR
	LDR		R2, =RCC_CCIPR1_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x3
	LSLS	R2, #20
	MVNS	R2, R2
	ANDS	R0, R2	//clear bits
	MOVS	R2, 0x1
	LSLS	R2, #20
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR


/*
Bits 3:0 HPRE[3:0]: AHB prescaler
This bitfiled is set and cleared by software to control the division factor of the AHB clock
(HCLK).
Caution: Depending on the device voltage range, the software must set these bits correctly to
ensure that the system frequency does not exceed the maximum allowed frequency
(for more details, refer to Table 114). After a write operation to these bits and before
decreasing the voltage range, this register must be read to be sure that the new
value is taken into account.
0xxx: SYSCLK not divided
1000: SYSCLK divided by 2
1001: SYSCLK divided by 4
1010: SYSCLK divided by 8
1011: SYSCLK divided by 16
1100: SYSCLK divided by 64
1101: SYSCLK divided by 128
1110: SYSCLK divided by 256
1111: SYSCLK divided by 512
*/
ASM_RCC_CFGR2_HPRE_2:
	LDR		R1, =RCC_BASE_ADDR
	LDR		R2, =RCC_CFGR2_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0xf
	MVNS	R2, R2
	ANDS	R0, R2	//clear bits
	MOVS	R2, 0x8
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR


/*
Bits 10:8 PPRE2[2:0]: APB2 prescaler
This bitfiled is set and cleared by software to control the division factor of APB2 clock
(PCLK2).
0xx: PCLK2 not divided
100: PCLK2 divided by 2
101: PCLK2 divided by 4
110: PCLK2 divided by 8
111: PCLK2 divided by 16
*/
ASM_RCC_CFGR2_PCLK2_2:
	LDR		R1, =RCC_BASE_ADDR
	LDR		R2, =RCC_CFGR2_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x7
	LSLS 	R2, #8
	MVNS	R2, R2
	ANDS	R0, R2	//clear bits
	MOVS	R2, 0x4
	LSLS 	R2, #8
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

/*
Bits 27:24 MCOSEL[3:0]: microcontroller clock output
This bitfield is set and cleared by software.
0000: MCO output disabled, no clock on MCO
0001: SYSCLK system clock selected
0010: MSIS clock selected
0011: HSI16 clock selected
0100: HSE clock selected
0101: Main PLL clock pll1_r_ck selected
0110: LSI clock selected
0111: LSE clock selected
1000: Internal HSI48 clock selected
1001: MSIK clock selected
Others: reserved
*/
ASM_RCC_CFGR1_MCOSEL_HSI16:
	LDR		R1, =RCC_BASE_ADDR
	LDR		R2, =RCC_CFGR1_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0xf
	LSLS 	R2, #24
	MVNS	R2, R2
	ANDS	R0, R2	//clear bits
	MOVS	R2, 0x3
	LSLS 	R2, #24
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

ASM_RCC_CFGR1_MCOSEL_HSE:
	LDR		R1, =RCC_BASE_ADDR
	LDR		R2, =RCC_CFGR1_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0xf
	LSLS 	R2, #24
	MVNS	R2, R2
	ANDS	R0, R2	//clear bits
	MOVS	R2, 0x4
	LSLS 	R2, #24
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

ASM_RCC_CFGR1_MCOSEL_MSIS:
	LDR		R1, =RCC_BASE_ADDR
	LDR		R2, =RCC_CFGR1_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0xf
	LSLS 	R2, #24
	MVNS	R2, R2
	ANDS	R0, R2	//clear bits
	MOVS	R2, 0x2
	LSLS 	R2, #24
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

ASM_RCC_CFGR1_MCOSEL_MSIK:
	LDR		R1, =RCC_BASE_ADDR
	LDR		R2, =RCC_CFGR1_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0xf
	LSLS 	R2, #24
	MVNS	R2, R2
	ANDS	R0, R2	//clear bits
	MOVS	R2, 0x9
	LSLS 	R2, #24
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

ASM_RCC_CFGR1_MCOSEL_SYSCLK:
	LDR		R1, =RCC_BASE_ADDR
	LDR		R2, =RCC_CFGR1_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0xf
	LSLS 	R2, #24
	MVNS	R2, R2
	ANDS	R0, R2	//clear bits
	MOVS	R2, 0x1
	LSLS 	R2, #24
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

ASM_RCC_CFGR1_MCOSEL_HSI48:
	LDR		R1, =RCC_BASE_ADDR
	LDR		R2, =RCC_CFGR1_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0xf
	LSLS 	R2, #24
	MVNS	R2, R2
	ANDS	R0, R2	//clear bits
	MOVS	R2, 0x8
	LSLS 	R2, #24
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

ASM_RCC_CFGR1_MCOSEL_PLL1:
	LDR		R1, =RCC_BASE_ADDR
	LDR		R2, =RCC_CFGR1_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0xf
	LSLS 	R2, #24
	MVNS	R2, R2
	ANDS	R0, R2	//clear bits
	MOVS	R2, 0x5
	LSLS 	R2, #24
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

/*
Bit 8 HSION: HSI16 clock enable
This bit is set and cleared by software. It is cleared by hardware to stop the HSI16 oscillator
when entering Stop, Standby, or Shutdown mode. This bit is set by hardware to force
the HSI16 oscillator on when STOPWUCK = 1 when leaving Stop modes, or in case of failure
of the HSE crystal oscillator. This bit is set by hardware if the HSI16 is used directly or
indirectly as system clock.
0: HSI16 oscillator off
1: HSI16 oscillator on
*/
ASM_RCC_CR_HSI16:
	LDR		R1, =RCC_BASE_ADDR
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS 	R2, #8
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

/*
Bit 10 HSIRDY: HSI16 clock ready flag
This bit is set by hardware to indicate that HSI16 oscillator is stable. It is set only when HSI16
is enabled by software (by setting HSION).
0: HSI16 oscillator not ready
1: HSI16 oscillator ready
Note: Once the HSION bit is cleared, HSIRDY goes low after six HSI16 clock cycles.
*/
ASM_RCC_CR_HSI16RDY:
	LDR		R1, =RCC_BASE_ADDR
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS 	R2, #10
	ANDS	R0, R2, R0
	BX LR


ASM_RCC_CR_HSI48:
	LDR		R1, =RCC_BASE_ADDR
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS 	R2, #12
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

ASM_RCC_CR_HSI48RDY:
	LDR		R1, =RCC_BASE_ADDR
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS 	R2, #13
	ANDS	R0, R2, R0
	BX LR

ASM_RCC_CR_SYSCLK:
	LDR		R1, =RCC_BASE_ADDR
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS 	R2, #8
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

ASM_RCC_CR_SYSCLKRDY:
	LDR		R1, =RCC_BASE_ADDR
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS 	R2, #10
	ANDS	R0, R2, R0
	BX LR

ASM_RCC_CR_MSIK:
	LDR		R1, =RCC_BASE_ADDR
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS 	R2, #4
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

ASM_RCC_CR_MSIKRDY:
	LDR		R1, =RCC_BASE_ADDR
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS 	R2, #5
	ANDS	R0, R2, R0
	BX LR

ASM_RCC_CR_MSIS:
	LDR		R1, =RCC_BASE_ADDR
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS 	R2, #0
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

ASM_RCC_CR_MSISRDY:
	LDR		R1, =RCC_BASE_ADDR
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS 	R2, #2
	ANDS	R0, R2, R0
	BX LR

ASM_RCC_CR_HSE:
	LDR		R1, =RCC_BASE_ADDR
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS 	R2, #16
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

ASM_RCC_CR_HSERDY:
	LDR		R1, =RCC_BASE_ADDR
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS 	R2, #17
	ANDS	R0, R2, R0
	BX LR

ASM_RCC_CR_PLL1:
	LDR		R1, =RCC_BASE_ADDR
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS 	R2, #24
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

ASM_RCC_CR_PLL1RDY:
	LDR		R1, =RCC_BASE_ADDR
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS 	R2, #25
	ANDS	R0, R2, R0
	BX LR

/*
Bits 1:0 PLL1SRC[1:0]: PLL1 entry clock source
This bitfield is set and cleared by software to select PLL1 clock source. It can be written only
when the PLL1 is disabled. In order to save power, when no PLL1 is used, this bitfield value
must be zero.
00: No clock sent to PLL1
01: MSIS clock selected as PLL1 clock entry
10: HSI16 clock selected as PLL1 clock entry
11: HSE clock selected as PLL1 clock entry
*/
ASM_RCC_PLL1CFGR_PLL1SRC_HSI16:
	LDR		R1, =RCC_BASE_ADDR
	LDR 	R2, =RCC_PLL1CFGR_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x3
	MVNS	R2, R2
	ANDS	R0, R2
	MOVS	R2, #0x2
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

/*RCC_CFGR1_MCOSEL_PLL1:
	LDR		R1, =RCC_BASE_ADDR
	LDR		R2, =RCC_CFGR1_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0xf
	LSLS 	R2, #24
	MVNS	R2, R2
	ANDS	R0, R2	//clear bits
	MOVS	R2, 0x5
	LSLS 	R2, #24
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR
Bit 16 PLL1PEN: PLL1 DIVP divider output enable
This bit is set and reset by software to enable the pll1_p_ck output of the PLL1. To save
power, PLL1PEN and PLL1P bits must be set to 0 when pll1_p_ck is not used.
0: pll1_p_ck output disabled
1: pll1_p_ck output enabled
*/
ASM_RCC_PLL1CFGR_PLL1PEN:
	LDR		R1, =RCC_BASE_ADDR
	LDR 	R2, =RCC_PLL1CFGR_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, #0x1
	LSLS 	R2, #16
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

ASM_RCC_PLL1CFGR_PLL1QEN:
	LDR		R1, =RCC_BASE_ADDR
	LDR 	R2, =RCC_PLL1CFGR_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, #0x1
	LSLS 	R2, #17
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

ASM_RCC_PLL1CFGR_PLL1REN:
	LDR		R1, =RCC_BASE_ADDR
	LDR 	R2, =RCC_PLL1CFGR_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, #0x1
	LSLS 	R2, #18
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

/*
Bits 11:8 PLL1M[3:0]: Prescaler for PLL1
This bitfield is set and cleared by software to configure the prescaler of the PLL1. The VCO1
input frequency is PLL1 input clock frequency/PLL1M.
This bit can be written only when the PLL1 is disabled (PLL1ON = 0 and PLL1RDY = 0).
0000: division by 1 (bypass)
0001: division by 2
0010: division by 3
...
1111: division by 16
*/
ASM_RCC_PLL1CFGR_PLL1M_3:
	LDR		R1, =RCC_BASE_ADDR
	LDR 	R2, =RCC_PLL1CFGR_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, #0xf
	LSLS 	R2, #8
	MVNS	R2, R2
	ANDS 	R0, R2	//clear bits
	MOVS	R2, #2
	LSLS	R2, #8
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR


/*
its 8:0 PLL1N[8:0]: Multiplication factor for PLL1 VCO
This bitfield is set and reset by software to control the multiplication factor of the VCO. It can be
written only when the PLL is disabled (PLL1ON = 0 and PLL1RDY = 0).
0x003: PLL1N = 4
0x004: PLL1N = 5
0x005: PLL1N = 6
...
0x080: PLL1N = 129 (default after reset)
...
0x1FF: PLL1N = 512
Others: reserved
VCO output frequency = Fref1_ck x PLL1N, when fractional value 0 has been loaded in PLL1FRACN,
with:
–
PLL1N between 4 and 512
–
input frequency Fref1_ck between 4 and 16 MHz
*/
ASM_RCC_PLL1DIVR_PLL1N_4:
	LDR		R1, =RCC_BASE_ADDR
	LDR 	R2, =RCC_PLL1DIVR_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R3, #0xf	//1111
	LSLS 	R2, R3, #4	//11110000
	ORRS	R2, R3		//11111111
	LSLS	R2, #2		//1111111100
	ORRS	R2, 0x3
	MVNS	R2, R2
	ANDS 	R0, R2		//clear 8 bits
	MOVS	R3, #0x003
	ORRS	R0, R3
	STR		R0, [R1]
	BX LR

ASM_RCC_PLL1DIVR_PLL1N_5:
	LDR		R1, =RCC_BASE_ADDR
	LDR 	R2, =RCC_PLL1DIVR_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R3, #0xf	//1111
	LSLS 	R2, R3, #4	//11110000
	ORRS	R2, R3		//11111111
	LSLS	R2, #2		//1111111100
	ORRS	R2, 0x3
	MVNS	R2, R2
	ANDS 	R0, R2		//clear 8 bits
	MOVS	R3, #0x004
	ORRS	R0, R3
	STR		R0, [R1]
	BX LR

ASM_RCC_PLL1DIVR_PLL1N_6:
	LDR		R1, =RCC_BASE_ADDR
	LDR 	R2, =RCC_PLL1DIVR_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R3, #0xf	//1111
	LSLS 	R2, R3, #4	//11110000
	ORRS	R2, R3		//11111111
	LSLS	R2, #2		//1111111100
	ORRS	R2, 0x3
	MVNS	R2, R2
	ANDS 	R0, R2		//clear 8 bits
	MOVS	R3, #0x005
	ORRS	R0, R3
	STR		R0, [R1]
	BX LR




	/*
	Bits 1:0 SW[1:0]: system clock switch
This bitfield is set and cleared by software to select system clock source (SYSCLK). It is
configured by hardware to force MSIS oscillator selection when exiting Standby or Shutdown
mode. This bitfield is configured by hardware to force MSIS or HSI16 oscillator selection
when exiting Stop mode or in case of HSE oscillator failure, depending on STOPWUCK.
00: MSIS selected as system clock
01: HSI16 selected as system clock
10: HSE selected as system clock
11: PLL pll1_r_ck selected as system clock
*/
ASM_RCC_CFGR1_SW_PLL1:
	LDR		R1, =RCC_BASE_ADDR
	LDR		R2, =RCC_CFGR1_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x3
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

ASM_RCC_CFGR1_SWS:
	LDR		R1, =RCC_BASE_ADDR
	LDR		R2, =RCC_CFGR1_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	BX LR

RUN_COUNTER:
	MOVS r6, #0
	iloop:
		ADDS r6, r6, #1
		b iloop
	bx lr

RESET_COUNTER:
	MOVS R0, R6
	MOVS R6, #0
	bx lr

ASM_RCC_ICSCR1_MSIKRANGE_SET:
	LDR R1, =RCC_BASE_ADDR
	LDR R2, =RCC_ICSCR1_OFFSET
	ADDS R1, R2
	LDR R3, [R1]
	MOVS R2, 0xf
	LSLS R2, #24
	MVNS R2, R2
	ANDS R3, R2  //clear bits
	MOVS R2, R0
	LSLS R2, #24
	ORRS R3, R2
	STR R3, [R1]
	BX LR




ASM_RCC_ICSCR1_MSIRGSEL_1:
	LDR R1, =RCC_BASE_ADDR
	LDR R2, = RCC_ICSCR1_OFFSET
	ADDS R1, R2
	LDR R0, [R1]
	MOV R2, 0x1
	LSLS R2, #23
	ORRS R0, R2
	STR R0, [R1]
	BX LR
