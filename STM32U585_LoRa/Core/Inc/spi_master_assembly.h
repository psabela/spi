/*
 * spi_master_assembly.h
 *
 *  Created on: Jul 10, 2025
 *      Author: peter
 */

#ifndef SPI_MASTER_ASSEMBLY_H_
#define SPI_MASTER_ASSEMBLY_H_

extern void ASM_SPI_CFG2_MASTER_Set(void);
extern void ASM_SPI_CFG2_COMM_Full_Duplex(void);
extern void ASM_SPI_CFG2_CPOL_0(void);
extern void ASM_SPI_CFG2_CPOL_1(void);
extern void ASM_SPI_CFG2_CPHA_0(void);
extern void ASM_SPI_CFG2_SSM_0(void);
extern void ASM_SPI_CFG2_SSM_1(void);
extern void ASM_SPI_CFG2_SSOE_1(void);
extern void ASM_SPI_CFG2_SSOM_1(void);
extern void ASM_SPI_CFG2_SSOM_0(void);
extern void ASM_SPI_CFG2_MIDI_Set(void);
extern void ASM_SPI_CFG2_MSSI_Set(void);
extern void ASM_SPI_CFG2_LSBFRST_LSB(void);
extern void ASM_SPI_CFG2_LSBFRST_MSB(void);
extern void ASM_SPI_CFG2_AFCNTR_1(void);
extern void ASM_SPI_CFG2_SSIOP_0(void);
extern void ASM_SPI_CFG2_SSIOP_1(void);
extern void ASM_SPI_CFG1_MBR_256(void);
extern void ASM_SPI_CFG1_MBR_64(void);
extern void ASM_SPI_CFG1_MBR_4(void);
extern void ASM_SPI_CFG1_BPASS_0(void);
extern void ASM_SPI_CFG1_BPASS_1(void);
extern void ASM_SPI_CFG1_DSIZE_8(void);
extern void ASM_SPI_CFG1_FTHLV_2(void);
extern void ASM_SPI_CFG1_FTHLV_1(void);
extern void ASM_SPI_CR1_SPE_1(void);
extern void ASM_SPI_CR1_CSTART_1(void);
extern uint8_t ASM_SPI_TXDR_Set(uint8_t x);
extern void ASM_SPI_IFCR_OVRC(void);
extern void ASM_SPI_CR1_SPE_0(void);
extern void ASM_SPI_IFCR_TXTFC(void);
extern void ASM_SPI_IFCR_EOTC_Clear(void);
extern void ASM_SPI_IER_EOTIE_Set(void);
extern void ASM_SPI_IER_TXPIE_Set(void);
extern void ASM_SPI_IER_TXTFIE_Set(void);
extern uint32_t ASM_SPI_SR_Get(void);
extern void ASM_SPI_CR2_TSIZE(void);
extern void ASM_SPI_IER_RXPIE_Set(void);
extern uint8_t ASM_SPI_RXDR_Get(void);
extern void ASM_SPI_CR1_SSI_0(void);
extern void ASM_SPI_CR1_SSI_1(void);
extern void ASM_SPI_CFG2_RDIOM_1_SIMULATE_RDY(void);

#endif /* SPI_MASTER_ASSEMBLY_H_ */
