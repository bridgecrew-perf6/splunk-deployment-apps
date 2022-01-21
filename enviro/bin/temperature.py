#!/usr/bin/python3

from envirophat import weather

temp = weather.temperature()
fahrenheit = (temp * 9/5) + 32
int = (round(fahrenheit))

print(int)
