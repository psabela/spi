/*
 * gpio_assembly.h
 *
 *  Created on: Jul 9, 2025
 *      Author: peter
 */

#ifndef GPIO_ASSEMBLY_H_
#define GPIO_ASSEMBLY_H_

extern void GPIOE_MODER_Set_Alt_Function(void);
extern void GPIOA_MODER_Set_Alt_Function(void);
extern void GPIOE_AFRH_Set_Alt_Function(void);
extern void GPIOA_AFRH_Set_Alt_Function(void);
extern void GPIOE_OSPEEDR_Set(void);
extern void GPIOA_OSPEEDR_Set(void);
extern void GPIOE_PUPDR_Set(void);
extern void GPIOE_PUPDR_MOSI_UP(void);
extern void GPIOE_PUPDR_MOSI_DOWN(void);
extern void GPIOE_PUPDR_MISO_UP(void);
extern void GPIOE_PUPDR_MISO_DOWN(void);
extern void GPIOE_PUPDR_SCK_UP(void);
extern void GPIOE_PUPDR_SCK_DOWN(void);
extern void GPIOE_PUPDR_NSS_UP(void);
extern void GPIOE_PUPDR_NSS_DOWN(void);
extern void GPIOE_PUPDR_RDY_UP(void);
extern void GPIOE_PUPDR_RDY_DOWN(void);
extern void GPIOE_PUPDR_CLEAR(uint32_t x);

extern void GPIOE_MODER_BUSY_INPUT(void);
extern void GPIOE_PURDR_BUSY_NPUPD(void);
extern void GPIOE_PURDR_BUSY_UP(void);
extern void GPIOD_MODER_DIO_INPUT(void);
extern void GPIOD_PUPDR_DIO_NPUPD(void);
extern uint16_t GPIOD_IDR_DIO_GET(void);
extern uint16_t GPIOE_IDR_BUSY_GET(void);

#endif /* GPIO_ASSEMBLY_H_ */
