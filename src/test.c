#include <Arduino.h>
#include <HardwareSerial.h>

int main(void)
{
    init();

#if defined(USBCON)
    USBDevice.attach();
#endif
    
    setup();
    
    for (;;) 
    {
        loop();

        if (serialEventRun)
        {
            serialEventRun();
        }
        
    }
        
    return 0;
}

void setup()
{
    // initialize digital pin LED_BUILTIN as an output.
    pinMode(LED_BUILTIN, OUTPUT);
}

void loop()
{
    digitalWrite(LED_BUILTIN, HIGH); // turn the LED on (HIGH is the voltage level)
    delay(1000);                     // wait for a second
    digitalWrite(LED_BUILTIN, LOW);  // turn the LED off by making the voltage LOW
    delay(1000);                     // wait for a second
}
