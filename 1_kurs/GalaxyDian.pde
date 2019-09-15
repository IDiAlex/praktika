import processing.serial.*;
Wert wer;          // каретка и пулька

Serial serial;     // создаем объект последовательного порта
int received;      // данные, получаемые с последовательного порта
float x = 710;     // для каретки
float y = 700;     // для каретки
float x1 = 375;    // для врагов
float x2 = 745;          // для врагов
float dim = 80.0;  // размер каретки
int i;             // счётчик врагов
float [] a = new float[30];
float f=0;         // флаг для ввода массива
PImage bg;
PImage allien;
PImage bullet;
PImage spaceship;
PImage bgs;
PImage bge;
PImage bgl;
PImage tomatos;
int d;   // для вызова начального экрана
int start = 0; // кнопка для старта
int cnt = 0; // счётчик убитых врагов
float y4 = 805;
float y5 = 805;
float y6 = 805;



void setup() 
{
  size(1500, 800);
  noStroke();
  String port = Serial.list()[0];
  serial = new Serial(this, port, 9600); 
  wer = new Wert ();
  bg = loadImage("space1.jpg");
  allien = loadImage("im1.png");
  bullet = loadImage("imgBu.png");
  spaceship = loadImage("ship.png");
  bgs = loadImage("1323.jpg");
  bge = loadImage("win.jpg");
  bgl = loadImage("lose.jpg");
  tomatos = loadImage("tesla.png");
}
 
 
 
  void serialEvent(Serial myPort) 
{
  received = myPort.read(); // считываем данные
  //println(received);
}
  
  void keyPressed()
{
  switch ( key )
  {
    case ('\n'):
      start = 1; delay(700); break;
  }
}
  
  
  void draw() 
{
  switch(d)
  {
    case(0):
    {
      background(bgs);  
      if (start == 1)
      {
        d++;
      }
      break;
    }
    case(1):
    {
      background(bg); 
      wer.move();
      wer.display(); 
      break;
    }
    case(2):
    delay(700); background(bge); break;
    case(3):
    delay(700); background(bgl); break;
  }
}  



  class Wert
{
  float [] a = new float[30];
  float dim, dim1, x, y, z, h;    
  float x1, y1, ddim, ddim1;
  float x2, y2, pdim, pdim1;
  float x3, y3;
  float x4, x5, x6;
  float y4=900;
  float y5=900;
  float y6=900;
  float dir=5;
  int n;

  Wert()
  {
    x = 710;
    y = 700;
    dim = 80;
    dim1 = 80;
    ddim = 40;
    ddim1 = 40;
    x1 = 375;
  }
   
  Wert(float x2, float y2, float pdim, float pdim1) 
  {
    x = x2;
    y = y2;
    dim = pdim;
    dim1 = pdim1;
    y2=y-10;
    
  }
   
  void display()
{
    image(spaceship, x-20, y-20);
    image(bullet, x2, y2);
    i=0;
    
    if(f==0)
    {
       for(i=0; i<30; i++)
      {
         a[i] = 1.0;
      }
      f++;
    } 
     
    boolean flag_isZero = true;
    for(i=0; i<30; ++i)
    {
     if(a[i]==1)
     {
       flag_isZero = !flag_isZero;
       break;
     }
    }
    
    if (flag_isZero)
      d = 2;    
    
    for (int j=0;j<3;++j)
    {
      for (int k=0;k<10;++k)
      {
        z=(k*60)+x1;
        y1=50*j+h;
         
        if((y2<=y1+140)&&(x2>=z)&&(x2<=z+40)&&(y2>=y1+60))
        {
           if (a[j*10+k]==1)
           {
               y2=700;
               x2=x+35;
           }
            a[j*10+k]=0; 
            cnt++;
        }  //<>//
         
        if (a[j*10+k]==1)
        {
           rect(z, y1 + 100, 40.0, 40.0);
           image(allien, z, y1 + 100);
           if((y1+100)> 600)
           d=3;
        }
      } 
    }
    
    // движение томато
        //rect(x4, y4, 40, 40);
        image(tomatos, x4-20, y4-20);
       // rect(x5, y5, 40, 40);
        image(tomatos, x5-20, y5-20);
        //rect(x6, y6, 40, 40);
        image(tomatos, x6-20, y6-20);
        

 
}
 
  void move()
{
    
    // движение пулек
    
    y2-=10;
    
    if (y2<0)
    {
       y2=700;
       x2=x+35;
    }
     
    pdim = dim-70;
    pdim1 = dim1-65;
    
    // движение каретки
    
    switch (received)
    {
      case 51:
        x=x-10; break;
      case 50:
        x=x+10; break;
      default:
        x=x; break;
    }

    if ( x + dim > 1500)
      x = 1500 - dim;
        
    if ( x < 0 )
      x = 0;
      
      // движение врагов
      
     x1+=dir;
    
    if (x1 > 750)
    {
      dir*=-1;
      h+=10;
    }
      
    if (x1 < 150)
    {
      dir*=-1;
      h+=10;  
    }
    
      //движение томатос
      
      
      y4+=3;
      y5+=3;
      y6+=3;
      if ((y4 > 900)&&(y5 > 900)&&(y6 > 900))
        {
          y4=-50;
          y5=-50;
          y6=-50;
          x4 = (int)random(15,1486);
          x5 = (int)random(15,1486);
          x6 = (int)random(15,1486);
        }
        
     if ((x4 >= x-20)&&(x4 <= x+100)&&(y4+40 >= y)&&(y4+40 <= y+80) || (x5 >= x-20)&&(x5 <= x+100)&&(y5+40 >= y)&&(y5+40 <= y+80) || (x6 >= x-20)&&(x6 <= x+100)&&(y6+40 >= y)&&(y6+40 <= y+80))
     d=3;
     
  }
}
