const int axisX=A0; // ось C подключена к A0
const int axisY=A1; // ось Z подключена к A1
//const int axisZ=A2; // ось Y подключена к A2
//const int axisC=A3; // ось X подключена к A3

int valX, valY, valZ, valC = 0; // переменные для хранения значений осей
int x=5;
void setup()
{
Serial.begin(9600);
}
void loop() {
valX = analogRead(axisX); // значение оси Х
valY = analogRead(axisY); // значение оси Y
//valZ = analogRead(axisZ); // значение оси Z
//valC = analogRead(axisC); // значение оси C
// выводим значения в монитор
if ( valX==0 )
 x=2;//vpravo
if ( valY==0 )
 x=3;//vlevo
//if ( valZ==0 )
// x=0;//UP
//if ( valC==0 )
// x=1;//Down
Serial.print(x);
delay(100);
x=5;
}
