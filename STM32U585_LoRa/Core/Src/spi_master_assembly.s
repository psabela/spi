/*
 * spi_master_assembly.s
 *
 *  Created on: Jul 10, 2025
 *      Author: peter
 */
.syntax unified
.cpu cortex-m33
.fpu softvfp
.thumb

.text

.global ASM_SPI_CFG2_MASTER_Set
.global ASM_SPI_CFG2_COMM_Full_Duplex
.global ASM_SPI_CFG2_CPOL_0
.global ASM_SPI_CFG2_CPOL_1
.global ASM_SPI_CFG2_CPHA_0
.global ASM_SPI_CFG2_SSM_0
.global ASM_SPI_CFG2_SSM_1
.global ASM_SPI_CFG2_SSOE_1
.global ASM_SPI_CFG2_SSOM_1
.global ASM_SPI_CFG2_SSOM_0
.global ASM_SPI_CFG2_MIDI_Set
.global ASM_SPI_CFG2_MSSI_Set
.global ASM_SPI_CFG2_LSBFRST_LSB
.global ASM_SPI_CFG2_LSBFRST_MSB
.global ASM_SPI_CFG2_AFCNTR_1
.global ASM_SPI_CFG2_SSIOP_0
.global ASM_SPI_CFG2_SSIOP_1
.global ASM_SPI_CFG1_DSIZE_8
.global ASM_SPI_CFG1_FTHLV_2
.global ASM_SPI_CFG1_MBR_256
.global ASM_SPI_CFG1_MBR_64
.global ASM_SPI_CFG1_MBR_4
.global ASM_SPI_CFG1_BPASS_0
.global ASM_SPI_CFG1_BPASS_1
.global ASM_SPI_CR1_SPE_1
.global ASM_SPI_CR1_SPE_0
.global ASM_SPI_CR1_CSTART_1
.global ASM_SPI_IFCR_OVRC
.global ASM_SPI_IFCR_TXTFC
.global ASM_SPI_IFCR_EOTC_Clear
.global ASM_SPI_IER_EOTIE_Set
.global ASM_SPI_IER_TXPIE_Set
.global ASM_SPI_IER_TXTFIE_Set
.global ASM_SPI_SR_Get
.global ASM_SPI_CR2_TSIZE
.global ASM_SPI_TXDR_Set
.global ASM_SPI_IER_RXPIE_Set
.global ASM_SPI_RXDR_Get
.global ASM_SPI_CR1_SSI_0
.global	ASM_SPI_CR1_SSI_1
.global ASM_SPI_CFG2_RDIOM_1_SIMULATE_RDY

.equ SPI_BASE_ADDR,			0x40013000
.equ SPI_CR1_OFFSET, 		0x00
.equ SPI_CR2_OFFSET,		0x04
.equ SPI_CFG1_OFFSET,		0x08
.equ SPI_CFG2_OFFSET,		0x0C
.equ SPI_IER_OFFSET,		0x10
.equ SPI_SR_OFFSET,			0x14
.equ SPI_IFCR_OFFSET,		0x18
.equ SPI_AUTOCR_OFFSET,		0x1C
.equ SPI_TXDR_OFFSET,		0x20
.equ SPI_RXDR_OFFSET,		0x30
.equ SPI_CRCPOLY_OFFSET, 	0x40
.equ SPI_TXCRC_OFFSET,		0x44
.equ SPI_RXCRC_OFFSET,		0x48
.equ SPI_UDRDR_OFFSET,		0x4C

//SPI_CR2

ASM_SPI_IER_EOTIE_Set:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_IER_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #3
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

ASM_SPI_IER_TXPIE_Set:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_IER_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #1
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

/*
Bit 0 RXPIE: RXP interrupt enable
0: RXP interrupt disabled
1: RXP interrupt enabled
*/
ASM_SPI_IER_RXPIE_Set:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_IER_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR



ASM_SPI_IER_TXTFIE_Set:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_IER_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #4
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

ASM_SPI_SR_Get:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_SR_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	BX LR

ASM_SPI_IFCR_EOTC_Clear:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_IFCR_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #3
	ORRS 	R0, R2
	STR		R0, [R1]
	BX LR

ASM_SPI_IFCR_OVRC:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_IFCR_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #6
	ORRS 	R0, R2
	STR		R0, [R1]
	BX LR

ASM_SPI_IFCR_TXTFC:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_IFCR_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #4
	ORRS 	R0, R2
	STR		R0, [R1]
	BX LR

ASM_SPI_CR2_TSIZE:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_CR2_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, #2 //16
	ORRS 	R0, R2
	STR		R0, [R1]
	BX LR


ASM_SPI_CFG2_MASTER_Set:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_CFG2_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #22
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR


ASM_SPI_CFG2_COMM_Full_Duplex:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_CFG2_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x3
	LSLS	R2, #17
	MVNS	R2, R2
	ANDS 	R0, R2
	STR		R0, [R1]
	BX LR

ASM_SPI_CFG2_CPOL_0:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_CFG2_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #25
	MVNS	R2, R2
	ANDS 	R0, R2
	STR		R0, [R1]
	BX LR

ASM_SPI_CFG2_CPOL_1:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_CFG2_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #25
	ORRS 	R0, R2
	STR		R0, [R1]
	BX LR

ASM_SPI_CFG2_CPHA_0:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_CFG2_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #24
	MVNS	R2, R2
	ANDS 	R0, R2
	STR		R0, [R1]
	BX LR

//Hardware SS management (SSM = 0)
ASM_SPI_CFG2_SSM_0:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_CFG2_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #26
	MVNS	R2, R2
	ANDS 	R0, R2
	STR		R0, [R1]
	BX LR

ASM_SPI_CFG2_SSM_1:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_CFG2_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #26
	ORRS 	R0, R2
	STR		R0, [R1]
	BX LR

//SS output enable (SSOE = 1):
ASM_SPI_CFG2_SSOE_1:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_CFG2_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #29
	ORRS 	R0, R2
	STR		R0, [R1]
	BX LR


//Bit 14 RDIOP: RDY signal input/output polarity
//0: high level of the signal means the slave is ready for communication
//1: low level of the signal means the slave is ready for communication



//SPI_CFG1 Bits 4:0 DSIZE[4:0]: number of bits in at single SPI data frame
ASM_SPI_CFG1_DSIZE_8:
	BX LR

/*
Bits 8:5 FTHLV[3:0]: FIFO threshold level
Defines number of data frames at single data packet. Size of the packet should not exceed
1/2 of FIFO space.
0000: 1-data
0001: 2-data
0010: 3-data
0011: 4-data
*/
ASM_SPI_CFG1_FTHLV_2:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_CFG1_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0xf
	LSLS	R2, #5
	MVNS	R2, R2
	ANDS 	R0, R2	//clear bits
	MOVS	R2, 0x7
	LSLS	R2, #5
	ORRS 	R0, R2
	STR		R0, [R1]
	BX LR

//Bit 30 SSOM: SS output management in Master mode
//0: SS is kept at active level till data transfer is completed, it becomes inactive with EOT flag
//1: SPI data frames are interleaved with SS non active pulses when MIDI[3:0]>1
ASM_SPI_CFG2_SSOM_1:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_CFG2_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #30
	ORRS 	R0, R2
	STR		R0, [R1]
	BX LR

ASM_SPI_CFG2_SSOM_0:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_CFG2_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #30
	MVNS	R2, R2
	ANDS 	R0, R2
	STR		R0, [R1]
	BX LR


//Bits 7:4 MIDI[3:0]: master Inter-Data Idleness
//Specifies minimum time delay (expressed in SPI clock cycles periods) inserted between two
//consecutive data frames in Master mode.
//0000: no delay
//0001: 1 clock cycle period delay
//...
//1111: 15 clock cycle periods delay
ASM_SPI_CFG2_MIDI_Set:
	BX LR

//Bits 3:0 MSSI[3:0]: Master SS Idleness
//Specifies an extra delay, expressed in number of SPI clock cycle periods, inserted
//additionally between active edge of SS opening a session and the beginning of the first data
//frame of the session in Master mode when SSOE is enabled.
//0000: no extra delay
//0001: 1 clock cycle period delay added
//...
//1111: 15 clock cycle periods delay added
ASM_SPI_CFG2_MSSI_Set:
	BX LR

//Bits 30:28 MBR[2:0]: master baud rate prescaler setting
//000: SPI master clock/2
//001: SPI master clock/4
//010: SPI master clock/8
//011: SPI master clock/16
//100: SPI master clock/32
//101: SPI master clock/64
//110: SPI master clock/128
//111: SPI master clock/256


ASM_SPI_CFG1_MBR_4:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_CFG1_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x7
	LSLS	R2, #28
	MVNS	R2, R2 //clear bits
	ANDS 	R0, R2
	MOVS	R2, #1
	LSLS	R2, #28
	ORRS 	R0, R2
	STR		R0, [R1]
	BX LR

ASM_SPI_CFG1_MBR_256:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_CFG1_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x7
	LSLS	R2, #28
	ORRS 	R0, R2
	STR		R0, [R1]
	BX LR

ASM_SPI_CFG1_MBR_64:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_CFG1_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x5
	LSLS	R2, #28
	ORRS 	R0, R2
	STR		R0, [R1]
	BX LR

//Bit 31 BPASS: bypass of the prescaler at master baud rate clock generator
//0: bypass is disabled
//1: bypass is enabled
ASM_SPI_CFG1_BPASS_0:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_CFG1_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #31
	MVNS	R2, R2
	ANDS 	R0, R2
	STR		R0, [R1]
	BX LR

ASM_SPI_CFG1_BPASS_1:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_CFG1_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #31
	ORRS 	R0, R2
	STR		R0, [R1]
	BX LR

ASM_SPI_CFG2_LSBFRST_MSB:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_CFG2_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #23
	MVNS	R2, R2
	ANDS 	R0, R2
	STR		R0, [R1]
	BX LR

ASM_SPI_CFG2_LSBFRST_LSB:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_CFG2_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #23
	ORRS 	R0, R2
	STR		R0, [R1]
	BX LR

//Bit 31 AFCNTR: alternate function GPIOs control
//This bit is taken into account when SPE = 0 only
//0: The peripheral takes no control of GPIOs while it is disabled
//1: The peripheral keeps always control of all associated GPIOs
ASM_SPI_CFG2_AFCNTR_1:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_CFG2_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #31
	ORRS 	R0, R2
	STR		R0, [R1]
	BX LR

//Bit 0 SPE: serial peripheral enable
//This bit is set by and cleared by software.
//0: Serial peripheral disabled.
//1: Serial peripheral enabled
ASM_SPI_CR1_SPE_1:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_CR1_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #0
	ORRS 	R0, R2
	STR		R0, [R1]
	BX LR

ASM_SPI_CR1_SPE_0:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_CR1_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #0
	MVNS 	R2, R2
	ANDS 	R0, R2
	STR		R0, [R1]
	BX LR

//Bit 9 CSTART: master transfer start
//This bit can be set by software if SPI is enabled only to start an SPI communication. it is
//cleared by hardware when end of transfer (EOT) flag is set or when a transaction suspend
//request is accepted.
//0: master transfer is at idle
//1: master transfer is ongoing or temporary suspended by automatic suspend
ASM_SPI_CR1_CSTART_1:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_CR1_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #9
	ORRS 	R0, R2
	STR		R0, [R1]
	BX LR

//Bit 12 SSI: internal SS signal input level
//This bit has an effect only when the SSM bit is set. The value of this bit is forced onto the
//peripheral SS input internally and the I/O value of the SS pin is ignored.
ASM_SPI_CR1_SSI_1:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_CR1_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #12
	ORRS 	R0, R2
	STR		R0, [R1]
	BX LR

ASM_SPI_CR1_SSI_0:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_CR1_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #12
	MVNS	R2, R2
	ANDS 	R0, R2
	STR		R0, [R1]
	BX LR



ASM_SPI_TXDR_Set:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_TXDR_OFFSET
	ADDS	R1, R2
	LDR		R3, [R1]
	ORRS 	R3, R0
	STR		R3, [R1]
	BX LR

ASM_SPI_RXDR_Get:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_RXDR_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	BX LR


/**
 * SSIOP: SS input/output polarity.
 * 0: low level is active for SS signal
 * 1: high level is active for SS signal
 */
ASM_SPI_CFG2_SSIOP_0:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_CFG2_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #28
	MVNS	R2, R2
	ANDS 	R0, R2
	STR		R0, [R1]
	BX LR

ASM_SPI_CFG2_SSIOP_1:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_CFG2_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #28
	ORRS 	R0, R2
	STR		R0, [R1]
	BX LR

ASM_SPI_CFG2_RDIOM_1_SIMULATE_RDY:
	LDR		R1, =SPI_BASE_ADDR
	LDR		R2, =SPI_CFG2_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #13
	ORRS 	R0, R2
	STR		R0, [R1]
	BX LR



