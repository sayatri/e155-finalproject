/*  DWT.c
    Receives an audio signal from the master PIC
    Performs dynamic time warping to find similarity to signals in bank
    Sends string corresponding to signal of closest-matched signal
*/

#include <P32xxxx.h>

void initspi(void) {
    char junk;

    SPI2CONbits.ON = 0;     // disable SPI to reset previous state
    junk = SPI2BUF;         // read SPI buffer to clear receive buffer
    SPI2BRG = 7;            // set BAUD rate to 1.25MHz, with Pclk at 20MHz
    SPI2CONbits.MSSEN = 1;  // enable slave select SPI support
    SPI2CONbits.SSEN = 1;   // enable SS pin for slave mode
    SPI2CONbits.MSTEN = 0;  // enable slave mode
    SPI2CONbits.CKE = 1;    // set clock-to-data timing (centered on rising SCK)
    SPI2CONbits.MODE32 = 0; // set SPI to 8 bit data width 
    SPI2CONbits.MODE16 = 0; //
    SPI2CONbits.ON = 1;     // turn SPI on
}

char spireceivebyte(void) {
    while (!SPI2STATbits.SPIBUSY);  // wait until receive buffer fills
    return SPI2BUF;                 // return the received data
}

void spisendbyte(char data) {
    SPI2BUF = data;
    while (!SPI2STATbits.SPIBUSY); // wait until received buffer fills
    char received = SPI2BUF;       // clear the read buffer full
}

char processAudio(char* inputAudio, char bankSignalA, char bankSignalB) {
    // TODO: Do some dynamic time warping against the bank here
    return bankSignalA;
}

int main(void) {
    // Configure TRISB/TRISD to be all outputs
    TRISB = 0x0000;
    TRISD = 0x0000;

    // Set transmit flag to low
    TRISBbits.RB3 = 0;

    // Create a char to store the received byte in
    // char data;

    while (1) {
        // Create a char array to store the bytes of data in
        char inputSignal[5000] = {0};
        char bankSignalA;
        char bankSignalB;

        while (SPI2SS3 != 0);    // Wait for the master to be ready

        // // Once receiving begins, receive the entire audio file and the two
        // //    chars representing which files in the bank had the highest scores
        // for (int i = 0; i < 5000; i++) {
        //     inputSignal[i] = spireceivebyte();
        // }

        // bankSignalA = spireceivebyte();
        // bankSignalB = spireceivebyte();

        // // Process the audio
        // char result = processAudio(inputSignal, bankSignalA, bankSignalB);

        //TODO: TESTING WITH LEDS
        char result = spireceivebyte();
        PORTD = result;

        // Set the flag to indicate to the master that PIC is ready to transmit
        PORTBbits.RB3 = 1;

        while (SPI2SS3 != 0);    // Wait for the master to pay attention
        spisendbyte(result);     // Then transmit the result

        // // Receive the data
        // if (SPISS3 == 0) {
        //     data = spireceivebyte();
        // }

        // // Write the received data to the LEDs
        // PORTD = data;
    }
}