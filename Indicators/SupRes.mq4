//+------------------------------------------------------------------+
//|                                                       SupRes.mq4 |
//|                        Copyright 2022, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property indicator_chart_window

#property indicator_chart_window
#property indicator_buffers 2
#property indicator_color1 Blue
#property indicator_color2 Red

double resistance[];
double support[];

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
{
   // Set the indicator buffers
   SetIndexBuffer(0, resistance);
   SetIndexBuffer(1, support);

   // Set the colors for the indicator lines
   SetIndexStyle(0, DRAW_LINE, STYLE_SOLID, 2);
   SetIndexStyle(1, DRAW_LINE, STYLE_SOLID, 2);

   // Set the width of the indicator lines
   
   // SetIndexWidth(0, 2);
   // SetIndexWidth(1, 2);

   // Success
   return(0);
}

//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
{
   // Success
   return(0);
}

//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
{
   // Get the number of bars on the chart
   int bars = 50;
   int d = 6;

   // Iterate through the bars
   for (int i = 0; i < bars; i++)
   {
      // Calculate the resistance and support levels for the current bar
      
      
      resistance[i] = iHigh(NULL, PERIOD_D1, d) + (iHigh(NULL, PERIOD_D1, d) - iLow(NULL, PERIOD_D1, d)) * 0.5;
      support[i] = iLow(NULL, PERIOD_D1, d) - (iHigh(NULL, PERIOD_D1, d) - iLow(NULL, PERIOD_D1, d)) * 0.5;
   }

   // Success
   return(0);
}
