#include <stdio.h>
#include <stdint.h>
#include "stm32u585xx.h"
#include "core_cm33.h"

#include "rcc_assembly.h"
#include "gpio_assembly.h"
#include "spi_master_assembly.h"
#include "nvic_assembly.h"
#include "tim8_assembly.h"

void RCC_init(void);
void GPIO_SPI_init(void);
void SPI_init(void);
void TIM8_init(void);
void SPI_start(void);
void TIM8_start(void);
void NVIC_Interupts_Enable(void);

int _write(int file, char *ptr, int len){
	for(int i = 0; i < len; i++){
		ITM_SendChar(*ptr++);
	}
	return len;
}


uint8_t *ptr_tx_buffer = NULL; //tx_buffer;
uint8_t Opcode = 0x80;
uint8_t STDBY_RC = 0;
uint8_t tx_buffer[3];
uint32_t rx_buffer;

int stop_flag = 0;

int main(void){

	ASM_RCC_AHB2ENR1_GPIOEEN_Set();
	ASM_RCC_AHB2ENR1_GPIODEN_Set();
	GPIOE_MODER_BUSY_INPUT();
	GPIOE_PURDR_BUSY_UP();
	GPIOD_MODER_DIO_INPUT();
	GPIOD_PUPDR_DIO_NPUPD();

	RCC_init();
	TIM8_init();
	SPI_init();

	NVIC_Interupts_Enable();

	tx_buffer[0] = Opcode;
	tx_buffer[1] = STDBY_RC;
	tx_buffer[2] = '$';
	ptr_tx_buffer = tx_buffer;

//	ASM_SPI_CR1_SSI_1();
	TIM8_start();
//
//	ASM_SPI_CR1_SSI_1();
//	ASM_SPI_CR1_SSI_0();

	//SPI_start();
	ASM_SPI_CR1_SPE_1(); //enable spi
	ASM_SPI_CR1_SSI_0(); //select slave
	//ASM_SPI_CR1_CSTART_1(); //start spi

	while(1){

//		if (GPIOE_IDR_BUSY_GET() & (0x1U << 7))
//		{
//			printf("%d \n", 11);
//		}
//		else
//		{
//			//printf("%d \n", 0);
//		}

	}
}

void NVIC_Interupts_Enable(){
	NVIC_TIM8_Enable_Interupt();
	NVIC_SPI1_Enable_Interupt();
}

int tim_flag = 0;
void TIM8_UP_IRQHandler(){
	if(TIM8_Get_SR_Status() & 0x1){  //UIF on
		TIM8_Clear_UIF_Flag();
		tim_flag ^= 1;
		//printf("%i \n", tim_flag);
	}
}

void SPI1_IRQHandler(){

	/**
	* Bit 3 EOT: end of transfer
	* EOT is set by hardware as soon as a full transfer is complete, that is when SPI is re-enabled
	* or when TSIZE number of data have been transmitted and/or received on the SPI. EOT is
	* cleared when SPI is re-enabled or by writing 1 to EOTC bit of SPI_IFCR optionally.
	* EOT flag triggers an interrupt if EOTIE bit is set.
	* If DXP flag is used until TXTF flag is set and DXPIE is cleared, EOT can be used to
	* download the last packets contained into RxFIFO in one-shot.
	* 0: transfer is ongoing or not started
	* 1: transfer complete
	* In master, EOT event terminates the data transaction and handles SS output optionally.
	* When CRC is applied, the EOT event is extended over the CRC frame transaction.
	* To restart the internal state machine properly, SPI is strongly suggested to be disabled and
	* re-enabled before next transaction starts despite its setting is not changed.
	*/
	if(ASM_SPI_SR_Get() & (0x1U << 3)){
		printf("transfer complete.\n");
//		ASM_SPI_CR1_SSI_1();
		ASM_SPI_IFCR_EOTC_Clear();
		// to-do:
		//* In master, EOT event terminates the data transaction and handles SS output optionally.
		//* To restart the internal state machine properly, SPI is strongly suggested to be disabled and
		//* re-enabled before next transaction starts despite its setting is not changed.
//		ASM_SPI_CR1_SPE_0();
//		if(!stop_flag){
//			SPI_init();
//			SPI_start();
//		}
	}


	/**
	* Bit 1 TXP: Tx-packet space available
	* 0: not enough free space at TxFIFO to host next data packet
	* 1: enough free space at TxFIFO to host at least one data packet
	* TXP flag can be changed only by hardware. Its value depends on the physical size of the
	* FIFO and its threshold (FTHLV[3:0]), data frame size (DSIZE[4:0] in SPI mode), and actual
	* communication flow. If the data packet is stored by performing consecutive write operations
	* to SPI_TXDR, TXP flag must be checked again once a complete data packet is stored at
	* TxFIFO. TXP is set despite SPI TxFIFO becomes inaccessible when SPI is reset or
	* disabled.
	*/
	if(ASM_SPI_SR_Get() & (0x1U << 1)){
		printf("Data packet space available\n");

		if(ptr_tx_buffer != NULL){
			//ASM_SPI_CR1_SSI_0();
			for(int i = 0; i<2000; i++){}

			//printf("----------------->>>>   %x \n", *ptr_tx_buffer);
			//ASM_SPI_TXDR_Set(*ptr_tx_buffer);
			//ptr_tx_buffer++;
		}

	}
	else{
		printf("Data packet space NOT available\n");
	}

	//Bit 6 OVR: overrun
	if(ASM_SPI_SR_Get() & (0x1U << 6)){
		printf("Overrun.\n");
		ASM_SPI_IFCR_OVRC();
	}

	/**
	* Bit 4 TXTF: transmission transfer filled
	* 0: upload of TxFIFO is ongoing or not started
	* 1: TxFIFO upload is finished
	* TXTF is set by hardware as soon as all of the data packets in a transfer have been submitted
	* for transmission by application software or DMA, that is when TSIZE number of data have
	* been pushed into the TxFIFO.
	* This bit is cleared by software write 1 to TXTFC bit of SPI_IFCR exclusively.
	* TXTF flag triggers an interrupt if TXTFIE bit is set.
	* TXTF setting clears the TXPIE and DXPIE masks so to off-load application software from
	* calculating when to disable TXP and DXP interrupts.
	*/
	if(ASM_SPI_SR_Get() & (0x1U << 4)){
		printf("TxFIFO upload is finished.\n");
		ASM_SPI_IFCR_TXTFC();
	}

	/*
	* Bit 0 RXP: Rx-packet available
	* 0: RxFIFO is empty or an incomplete data packet is received
	* 1: RxFIFO contains at least one data packet
	* The flag is changed by hardware. It monitors the total number of data currently available at
	* RxFIFO if SPI is enabled. RXP value depends on the FIFO threshold (FTHLV[3:0]), data
	* frame size (DSIZE[4:0] in SPI mode), and actual communication flow. If the data packet is
	* read by performing consecutive read operations from SPI_RXDR, RXP flag must be
	* checked again once a complete data packet is read out from RxFIFO.
	*/
	while(ASM_SPI_SR_Get() & (0x1U)){
		rx_buffer = ASM_SPI_RXDR_Get();
		printf("RxFIFO contains at least one data packet\n");
//		ASM_SPI_CR1_SSI_1(); //unselect slave
//		ASM_SPI_CR1_SPE_0(); //disable SPI1
	}

}

void RCC_init(){

	ASM_RCC_CR_HSI16();
	while(!ASM_RCC_CR_HSI16RDY());

	ASM_RCC_PLL1CFGR_PLL1SRC_HSI16();
	ASM_RCC_PLL1CFGR_PLL1M_3();
	ASM_RCC_PLL1DIVR_PLL1N_4();
	ASM_RCC_PLL1CFGR_PLL1REN();
	ASM_RCC_PLL1CFGR_PLL1PEN();
	ASM_RCC_PLL1CFGR_PLL1QEN();


	ASM_RCC_CR_PLL1();
	while(!ASM_RCC_CR_PLL1RDY());

	//Activate MCO gpio pin PA8
	ASM_RCC_AHB2ENR1_GPIOAEN_Set();
	GPIOA_MODER_Set_Alt_Function();
	GPIOA_AFRH_Set_Alt_Function();
	GPIOA_OSPEEDR_Set();

	// Read clock frequency
			//ASM_RCC_CFGR1_MCOSEL_HSIor STM32U516();
			//ASM_RCC_CFGR1_MCOSEL_HSI48();
	 ASM_RCC_CFGR1_MCOSEL_SYSCLK();
			//ASM_RCC_CFGR1_MCOSEL_MSIK();
			//ASM_RCC_CFGR1_MCOSEL_MSIS();
			//ASM_RCC_CFGR1_MCOSEL_HSE();
			//ASM_RCC_CFGR1_MCOSEL_PLL1();

//	  ASM_RCC_CFGR1_SW_PLL1();
//	  while(!(ASM_RCC_CFGR1_SWS() & 0x3U));
}

void GPIO_SPI_init(){

	ASM_RCC_AHB2ENR1_GPIOEEN_Set();
	ASM_RCC_AHB2ENR1_GPIODEN_Set();

	//Configure GPIOE
	GPIOE_MODER_Set_Alt_Function();
	GPIOE_AFRH_Set_Alt_Function();
	GPIOE_OSPEEDR_Set();
  //GPIOE_PUPDR_Set();

	GPIOE_PUPDR_MOSI_UP();
  //GPIOE_PUPDR_MOSI_DOWN();
	GPIOE_PUPDR_MISO_UP();
  //GPIOE_PUPDR_MISO_DOWN();

  //** GPIO_PUPDR_SCK register bit value gets overwritten by SPI_CPOL bit (clock polarity)
  //GPIOE_PUPDR_SCK_UP();
  //GPIOE_PUPDR_CLEAR(26);
  //GPIOE_PUPDR_SCK_DOWN();
  //** GPIOE_PUPDR_NSS register bit value gets overwritten by SPI_SSIOP bit (SS input/output polarity)
	GPIOE_PUPDR_NSS_UP();
  //GPIOE_PUPDR_NSS_DOWN();
	//GPIOE_PUPDR_RDY_UP();
    GPIOE_PUPDR_RDY_DOWN();
}

void SPI_init(){

	/**
	 * Configure GPIO pins for SPI
	 */

	GPIO_SPI_init();

	/**
	 * Select clock for SPI
	 */

		//ASM_RCC_CCIPR1_SPI1SEL_HSI16();
	ASM_RCC_CCIPR1_SPI1SEL_PCLK2();
	  //ASM_RCC_CCIPR1_SPI1SEL_SYSCLK();
	  //ASM_RCC_CFGR2_HPRE_2();
	  //ASM_RCC_CFGR2_PCLK2_2();
	ASM_RCC_APB2ENR_SPI1_Set();

	/**
	 * Configure SPI
	 */

	/**
	 * SSIOP: SS input/output polarity.
	 * 0: low level is active for SS signal
	 * 1: high level is active for SS signal
	 */
	ASM_SPI_CFG2_SSIOP_0();
	//ASM_SPI_CFG2_SSIOP_1();  //High is active for SS signal

	/**
	 * SSOM: SS output management in Master mode
	 * This bit is taken into account in Master mode when SSOE is enabled.
	 * It allows the SS output to be configured between two consecutive data transfers.
	 * 0: SS is kept at active level till data transfer is completed,
	 *    it becomes inactive with with EOT flag
	 * 1: SPI data frames are interleaved with SS non active pulses when MIDI[3:0]>1
	 */
	//ASM_SPI_CFG2_SSOM_1();	//SS output management, interleave with non-active pulse
    ASM_SPI_CFG2_SSOM_0(); //SS output management, SS keep active till EOT flag

	/**
	 * Bits 7:4 MIDI[3:0]: master Inter-Data Idleness
	 * Specifies minimum time delay (expressed in SPI clock cycles periods)
	 * inserted between two consecutive data frames in Master mode.
	 * 0000: no delay
	 * 0001: 1 clock cycle period delay
	 * ...
	 * 1111: 15 clock cycle periods delay
	 * Note: This feature is not supported in TI mode.
	 */
	ASM_SPI_CFG2_MIDI_Set();

	/**
	 * Bit 26 SSM: software management of SS signal input
	 * 0: SS input value is determined by the SS PAD
	 * 1: SS input value is determined by the SSI bit
	 * When master uses hardware SS output (SSM = 0 and SSOE = 1)
	 * the SS signal input is forced to not active state internally
	 * to prevent master mode fault error.
	 */
  //ASM_SPI_CFG2_SSM_0();
    ASM_SPI_CFG2_SSM_1();

	/**
	 * Bit 29 SSOE: SS output enable
	 * This bit is taken into account in Master mode only
	 * 0: SS output is disabled and the SPI can work in multimaster configuration
	 * 1: SS output is enabled. The SPI cannot work in a multimaster environment.
	 * It forces the SS pin at inactive level after the transfer is completed
	 * or SPI is disabled with respect to SSOM, MIDI, MSSI, SSIOP bits setting
	 */
	ASM_SPI_CFG2_SSOE_1();	//SS output enabled(master mode only)

	/**
	 * Bit 22 MASTER: SPI Master
	 * 0: SPI Slave
	 * 1: SPI Master
	 */
	ASM_SPI_CFG2_MASTER_Set();

	/**
	 * Bits 18:17 COMM[1:0]: SPI Communication Mode
	 * 00: full-duplex
	 * 01: simplex transmitter
	 * 10: simplex receiver
	 * 11: half-duplex
	 */
	ASM_SPI_CFG2_COMM_Full_Duplex();

	/**
	 * Bit 25 CPOL: clock polarity
	 * 0: SCK signal is at 0 when idle
	 * 1: SCK signal is at 1 when idle
	 */
	ASM_SPI_CFG2_CPOL_0();

	/**
	 * Bit 24 CPHA: clock phase
	 * 0: the first clock transition is the first data capture edge
	 * 1: the second clock transition is the first data capture edge
	 */
	ASM_SPI_CFG2_CPHA_0();

	/**
	 * Bits 4:0 DSIZE[4:0]: number of bits in at single SPI data frame
	 * 00000: not used
	 * 00001: not used
	 * 00010: not used
	 * 00011: 4 bits
	 * 00100: 5 bits
	 * 00101: 6 bits
	 * 00110: 7 bits
	 * 00111: 8 bits
	 * .....
	 * 11101: 30 bits
	 * 11110: 31 bits
	 * 11111: 32 bits
	 */
	ASM_SPI_CFG1_DSIZE_8();

	/**
	* Bits 8:5 FTHLV[3:0]: FIFO threshold level
	* Defines number of data frames at single data packet. Size of the packet should not exceed
	* 1/2 of FIFO space.
	* 0000: 1-data
	* 0001: 2-data
	* 0010: 3-data
	* 0011: 4-data
	* 0100: 5-data
	* 0101: 6-data
	* 0110: 7-data
	* 0111: 8-data
	* 1000: 9-data
	* 1001: 10-data
	* 1010: 11-data
	* 1011: 12-data
	* 1100: 13-data
	* 1101: 14-data
	* 1110: 15-data
	* 1111: 16-data
	* SPI interface is more efficient if configured packet sizes are aligned with data register access
	* parallelism:
	* – If SPI data register is accessed as a 16-bit register and DSIZE ≤ 8 bit, better to select
	* FTHLV = 2, 4, 6.
	* – If SPI data register is accessed as a 32-bit register and DSIZE> 8 bit, better to select
	* FTHLV = 2, 4, 6, while if DSIZE ≤ 8bit, better to select FTHLV = 4, 8, 12.
	* Note: FTHLV[3:2] bits are reserved at instances with limited set of features
	*/
	ASM_SPI_CFG1_FTHLV_2();

	/**
	 * Bits 3:0 MSSI[3:0]: Master SS Idleness
	 * Specifies an extra delay, expressed in number of SPI clock cycle periods,
	 * inserted additionally between active edge of SS opening a session
	 * and the beginning of the first data frame of the session in Master mode when SSOE is enabled.
	 * 0000: no extra delay
	 * 0001: 1 clock cycle period delay added
	 * ...
	 * 1111: 15 clock cycle periods delay added
	 * Note: This feature is not supported in TI mode.
	 * To include the delay, the SPI must be disabled and re-enabled between sessions.
	 */
  //ASM_SPI_CFG2_MSSI_Set();  //default

	/**
	 * Bits 30:28 MBR[2:0]: master baud rate prescaler
	 * 000: SPI master clock/2
	 * 001: SPI master clock/4
	 * 010: SPI master clock/8
	 * 011: SPI master clock/16
	 * 100: SPI master clock/32
	 * 101: SPI master clock/64
	 * 110: SPI master clock/128
	 * 111: SPI master clock/256
	 */
  //ASM_SPI_CFG1_MBR_256();
  //ASM_SPI_CFG1_MBR_64();
  //ASM_SPI_CFG1_MBR_4();  //APB2ENR bus is 48MHz / 4 = 12MHz for SPI lora

	/**
	 * Bit 31 BPASS: bypass of the prescaler at master baud rate clock generator
	 * 0: bypass is disabled
	 * 1: bypass is enabled
	 */
  //ASM_SPI_CFG1_BPASS_0();
	ASM_SPI_CFG1_BPASS_1();

	/**
	 * Bit 23 LSBFRST: data frame format
	 * 0: MSB transmitted first
	 * 1: LSB transmitted first
	 */
	ASM_SPI_CFG2_LSBFRST_MSB();

	/**
	 * Bit 31 AFCNTR: alternate function GPIOs control
	 * This bit is taken into account when SPE = 0 only
	 * 0: The peripheral takes no control of GPIOs while it is disabled
	 * 1: The peripheral keeps always control of all associated GPIOs
	 * When SPI must be disabled temporary for a specific configuration reason
	 * (for example CRC reset, CPHA or HDDIR change) setting this bit prevents
	 * any glitches on the associated outputs configured at alternate function mode
	 * by keeping them forced at state corresponding the current SPI configuration.
	 */
  //ASM_SPI_CFG2_AFCNTR_1();


	/**
	* Bits 15:0 TSIZE[15:0]: number of data (data = data frame) at current transfer
	* When these bits are changed by software, the SPI must be disabled.
	* Endless transaction is initialized when CSTART is set while zero value is stored at TSIZE.
	* TSIZE cannot be set to 0xFFFF respective 0x3FFF value when CRC is enabled.
	* Note: TSIZE[15:10] bits are reserved at limited feature set instances and must be kept at reset
	* value.
	*/
	ASM_SPI_CR2_TSIZE();

	//ASM_SPI_CFG2_RDIOM_1_SIMULATE_RDY();

	//Enable interrupts on SPI1
	ASM_SPI_IER_EOTIE_Set();
	ASM_SPI_IER_TXPIE_Set();
	ASM_SPI_IER_TXTFIE_Set();
	ASM_SPI_IER_RXPIE_Set();

}

void SPI_start(){
	/**
	 * Bit 0 SPE: serial peripheral enable
	 * This bit is set by and cleared by software.
	 * 0: Serial peripheral disabled.
	 * 1: Serial peripheral enabled
	 */
	ASM_SPI_CR1_SPE_1();

	/**
	 * Bit 9 CSTART: master transfer start
	 * This bit can be set by software if SPI is enabled only to start an SPI communication.
	 * it is cleared by hardware when end of transfer (EOT) flag is set
	 * or when a transaction suspend request is accepted.
	 * 0: master transfer is at idle
	 * 1: master transfer is ongoing or temporary suspended by automatic suspend
	 * In SPI mode, the bit is taken into account at master mode only.
	 * If transmission is enabled, communication starts or continues
	 * only if any data is available 	 * in the transmission FIFO.
	*/
	ASM_SPI_CR1_CSTART_1();
}

void TIM8_init(){

	ASM_RCC_APB2ENR_TIM8EN_Set();
	//configure TIM2 timer
	TIM8_Set_PSC_Value();
	TIM8_Set_ARR_Value();
	TIM8_Clear_UIF_Flag();
	TIM8_Set_CCnS_To_Channel_Output();
	TIM8_Set_DITHEN_False();
	TIM8_Set_CCRn_WaveGen_Value();
	TIM8_Set_DIR_UpCounter();
	TIM8_Set_MMS_Update_Trigger_Output();
	//TIM8_Set_OCnM_To_Toggle_Mode();
	TIM8_Set_CC1P_Polarity_ActiveHigh();
	TIM8_Set_CCnE_Output_Enable_To_GPIO();
	TIM8_Set_UIF_Update_Interrupt_Enable();
	TIM8_Set_CC1IE_Update_Interrupt_Enable();
}

void TIM8_start(){
	TIM8_Set_CEN_Counter_Enable();
}

/*
SetStandby()
SetPacketType()
SetRfFrequency()
SetPaConfig()
SetTxParams(...)
SetBufferBaseAddress(...)
WriteBuffer(...)
SetModulationParams(...)
SetPacketParams(...)
SetDioIrqParams(...)
WriteReg(...)
SetTx()



//SetPacketType(...)
Lora | FSK

//SetModulationParams(...)
Modulation BandWidth (BW_L)
Spreading Factor (SF)
Coding Rate (CR)
Low Data Rate Optimization (LDRO)


//SetPacketParams(...)


*/
