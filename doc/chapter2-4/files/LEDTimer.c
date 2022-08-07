/* 
 * File:   LEDTimer.c
 * Author: a.shuto
 *
 * Created on July 8, 2022, 12:51 AM
 */

#include "mcc_generated_files/mcc.h"

void TMR2_Process(void){
    LED1_Toggle();
    LED3_Toggle();
}

void TMR4_Process(void){
    LED2_Toggle();
    LED4_Toggle();
}

void main(void){
    SYSTEM_Initialize();
    TMR2_SetInterruptHandler(TMR2_Process);
    TMR4_SetInterruptHandler(TMR4_Process);
    INTERRUPT_GlobalInterruptEnable();
    INTERRUPT_PeripheralInterruptEnable();
    TMR4_Stop();
    while(1){
        if(S1_GetValue() = 0){
            LED1_SetHigh();
            LED2_SetHigh();
            LED3_SetHigh();
            LED4_SetHigh();
            TMR4_Start();
        }
    }
}