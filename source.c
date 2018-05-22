/*
 * source.c
 *
 *  Created on: Apr 24, 2018
 *      Author: Fadoua
 */
#include "xparameters.h"
#include "xbasic_types.h"
#include "xgpio.h"
#include "xstatus.h"
//declare an XGpio instance
XGpio GpioDevice;
int main (void) {
// Define variables
Xuint32 status;
Xuint32 DataRead;
Xuint32 OldData;
Xuint32 numA;
Xuint32 numB;
Xuint32 op;
long int result;
unsigned  m1;
unsigned  m2;
unsigned  m3;
xil_printf("Hello...\r\n");
// Initialize the GPIO driver
status = XGpio_Initialize(&GpioDevice,XPAR_GPIO_0_DEVICE_ID);
if (status != XST_SUCCESS)
return XST_FAILURE;
// Set the direction for all signals in channel 1 to be outputs
XGpio_SetDataDirection(&GpioDevice, 1, 0x00000000);
// Set the direction for all signals in channel 2 to be inputs
XGpio_SetDataDirection(&GpioDevice, 2, 0xFFFFFFFF);
OldData = 0xFFFFFFFF;
while(1){
// Read the state of the DIP switches
DataRead = XGpio_DiscreteRead(&GpioDevice, 2);
// Bit Masking and bitwise operations to separate the data into two numbers
m1 = ((1 << 10) - 1) << 13;
m3 = (1 << 10) - 1;
numA = DataRead >> 12;
numA=numA & m3;

m2 = (1 << 2) - 1;
op=DataRead>>10;
op=op & m2;


numB = DataRead & m3;
//numB = DataRead & 0xFF00;
//numB = numB >> 8;
// Send the data to the UART if the settings change
result=0;
if(DataRead != OldData){
	xil_printf("Num A = %d\r\n", numA);
	xil_printf("Num B = %d\r\n", numB);
	xil_printf("operation is decoded by: op= %d\r\n",op);
	switch(op)
	{
	case 0:
	    result=numA+numB;
	    xil_printf("Num A + Num B => %d + %d = %d\r\n",numA, numB, result);
	    break;
	case 2:
	    result=numA-numB;
	    if (numA<numB) {result=-((~result)+1);}
	    xil_printf("Num A - Num B => %d - %d = %d\r\n",numA, numB, numA-numB);
	    //xil_printf("result %d = %d\r\n",result);
	    break;
	case 1:
	    result=numA*numB;
	    xil_printf("Num A * Num B => %d * %d = %d\r\n",numA, numB, result);
	    break;
	case 3:
	    result=numA/numB;
	    xil_printf("Num A/ Num B => %d / %d = %d\r\n",numA, numB, result);
	    break;
	}
	if (result>65535) {
		result=65535;
		xil_printf("WARNING: LED output maybe incorrect due to bit width limitations.\r\n");
	}
	//if (result<0) {
		//result=-result+1;}
xil_printf("-------------------------------------------------\r\n");
// Set the GPIO outputs to the switch values
XGpio_DiscreteWrite(&GpioDevice, 1, result);
// Save the DIP switch settings
OldData = DataRead;
}
}
 return 0;
}

