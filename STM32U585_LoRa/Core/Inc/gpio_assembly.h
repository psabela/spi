/*
 * gpio_assembly.h
 *
 *  Created on: Jul 9, 2025
 *      Author: peter
 */

#ifndef GPIO_ASSEMBLY_H_
#define GPIO_ASSEMBLY_H_

// PORT A
extern void GPIOA_MODER_Set_Alt_Function(void);
extern void GPIOA_AFRH_Set_Alt_Function(void);
extern void GPIOA_OSPEEDR_Set(void);
// PORT E
extern void GPIOE_MODER_Set_Alt_Function(void);
extern void GPIOE_AFRH_Set_Alt_Function(void);
extern void GPIOE_OSPEEDR_Set(void);
extern void GPIOE_PUPDR_Set(void);
extern void GPIOE_PUPDR_MOSI_UP(void);
extern void GPIOE_PUPDR_MOSI_DOWN(void);
extern void GPIOE_PUPDR_MISO_UP(void);
extern void GPIOE_PUPDR_MISO_DOWN(void);
extern void GPIOE_PUPDR_SCK_UP(void);
extern void GPIOE_PUPDR_SCK_DOWN(void);
extern void GPIOE_PUPDR_NSS_UP(void);
extern void GPIOE_PUPDR_NSS_DOWN(void);
extern void GPIOE_PUPDR_CLEAR(uint32_t x);
// PORT C
extern void GPIOC_MODER_Set_Alt_Function(void);
extern void GPIOC_AFRH_Set_Alt_Function(void);
extern void GPIOC_PUPDR_NUND(void);
extern void GPIOC_PUPDR_RDY_UP(void);
extern void GPIOC_PUPDR_RDY_DOWN(void);

#endif /* GPIO_ASSEMBLY_H_ */
