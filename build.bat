@echo off
set PATH=%PATH%;%cd%\ext\avr8-gnu-toolchain-win32_x86_64\bin
set PATH=%PATH%;%cd%\ext\avrdude-v7.0-windows-x64

mkdir build\arduino
set ARDUINO_LIB_FLAGS=-Iext\ArduinoCore-avr-1.8.6\cores\arduino -Iext\ArduinoCore-avr-1.8.6\variants\standard -g -Os -DF_CPU=16000000UL -mmcu=atmega328p -c
avr-gcc %ARDUINO_LIB_FLAGS% -o build/arduino/abi.o ext\ArduinoCore-avr-1.8.6\cores\arduino\abi.cpp
avr-gcc %ARDUINO_LIB_FLAGS% -o build/arduino/CDC.o ext\ArduinoCore-avr-1.8.6\cores\arduino\CDC.cpp
avr-gcc %ARDUINO_LIB_FLAGS% -o build/arduino/HardwareSerial.o ext\ArduinoCore-avr-1.8.6\cores\arduino\HardwareSerial.cpp
avr-gcc %ARDUINO_LIB_FLAGS% -o build/arduino/HardwareSerial0.o ext\ArduinoCore-avr-1.8.6\cores\arduino\HardwareSerial0.cpp
avr-gcc %ARDUINO_LIB_FLAGS% -o build/arduino/HardwareSerial1.o ext\ArduinoCore-avr-1.8.6\cores\arduino\HardwareSerial1.cpp
avr-gcc %ARDUINO_LIB_FLAGS% -o build/arduino/HardwareSerial2.o ext\ArduinoCore-avr-1.8.6\cores\arduino\HardwareSerial2.cpp
avr-gcc %ARDUINO_LIB_FLAGS% -o build/arduino/HardwareSerial3.o ext\ArduinoCore-avr-1.8.6\cores\arduino\HardwareSerial3.cpp
avr-gcc %ARDUINO_LIB_FLAGS% -o build/arduino/IPAddress.o ext\ArduinoCore-avr-1.8.6\cores\arduino\IPAddress.cpp
avr-gcc %ARDUINO_LIB_FLAGS% -o build/arduino/new.o ext\ArduinoCore-avr-1.8.6\cores\arduino\new.cpp
avr-gcc %ARDUINO_LIB_FLAGS% -o build/arduino/PluggableUSB.o ext\ArduinoCore-avr-1.8.6\cores\arduino\PluggableUSB.cpp
avr-gcc %ARDUINO_LIB_FLAGS% -o build/arduino/Print.o ext\ArduinoCore-avr-1.8.6\cores\arduino\Print.cpp
avr-gcc %ARDUINO_LIB_FLAGS% -o build/arduino/Tone.o ext\ArduinoCore-avr-1.8.6\cores\arduino\Tone.cpp
avr-gcc %ARDUINO_LIB_FLAGS% -o build/arduino/USBCore.o ext\ArduinoCore-avr-1.8.6\cores\arduino\USBCore.cpp
avr-gcc %ARDUINO_LIB_FLAGS% -o build/arduino/WInterrupts.o ext\ArduinoCore-avr-1.8.6\cores\arduino\WInterrupts.c
avr-gcc %ARDUINO_LIB_FLAGS% -o build/arduino/wiring.o ext\ArduinoCore-avr-1.8.6\cores\arduino\wiring.c
avr-gcc %ARDUINO_LIB_FLAGS% -o build/arduino/wiring_analog.o ext\ArduinoCore-avr-1.8.6\cores\arduino\wiring_analog.c
avr-gcc %ARDUINO_LIB_FLAGS% -o build/arduino/wiring_digital.o ext\ArduinoCore-avr-1.8.6\cores\arduino\wiring_digital.c
avr-gcc %ARDUINO_LIB_FLAGS% -o build/arduino/wiring_shift.o ext\ArduinoCore-avr-1.8.6\cores\arduino\wiring_shift.c
avr-gcc %ARDUINO_LIB_FLAGS% -o build/arduino/WMath.o ext\ArduinoCore-avr-1.8.6\cores\arduino\WMath.cpp
avr-gcc %ARDUINO_LIB_FLAGS% -o build/arduino/WString.o ext\ArduinoCore-avr-1.8.6\cores\arduino\WString.cpp
avr-gcc %ARDUINO_LIB_FLAGS% -o build/arduino/hooks.o ext\ArduinoCore-avr-1.8.6\cores\arduino\hooks.c

set ARDUINO_SOURCES=build/arduino/abi.o ^
    build/arduino/CDC.o ^
    build/arduino/HardwareSerial.o ^
    build/arduino/HardwareSerial0.o ^
    build/arduino/HardwareSerial2.o ^
    build/arduino/HardwareSerial3.o ^
    build/arduino/IPAddress.o ^
    build/arduino/new.o ^
    build/arduino/PluggableUSB.o ^
    build/arduino/Print.o ^
    build/arduino/Tone.o ^
    build/arduino/USBCore.o ^
    build/arduino/WInterrupts.o ^
    build/arduino/wiring.o ^
    build/arduino/wiring_analog.o ^
    build/arduino/wiring_digital.o ^
    build/arduino/wiring_shift.o ^
    build/arduino/WMath.o ^
    build/arduino/WString.o ^
    build/arduino/hooks.o

avr-g++ -g -Iext\ArduinoCore-avr-1.8.6\cores\arduino -Iext\ArduinoCore-avr-1.8.6\variants\standard -Os -DF_CPU=16000000UL -mmcu=atmega328p -c -o build/test.o src/test.c
avr-g++ -g -mmcu=atmega328p -o build/test.elf build/test.o %ARDUINO_SOURCES%
avr-objcopy -O ihex -R .epprom build/test.elf build/test.hex
avrdude -F -V -c arduino -p ATMEGA328P -P com3 -b 115200 -U flash:w:build/test.hex