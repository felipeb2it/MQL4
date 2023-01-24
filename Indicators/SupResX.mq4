//+------------------------------------------------------------------+
//|                                                      SupResX.mq4 |
//|                        Copyright 2022, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property indicator_chart_window

#property indicator_chart_window
#property indicator_buffers 4
#property indicator_color1 Blue
#property indicator_color2 Red
#property indicator_color3 Green
#property indicator_color4 Green

double resistance[];
double support[];
double broken_resistance[];
double broken_support[];

int previous_bar;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
{
   // Set the indicator buffers
   SetIndexBuffer(0, resistance);
   SetIndexBuffer(1, support);
   SetIndexBuffer(2, broken_resistance);
   SetIndexBuffer(3, broken_support);

   // Set the colors for the indicator lines
   SetIndexStyle(0, DRAW_LINE, STYLE_SOLID, 2);
   SetIndexStyle(1, DRAW_LINE, STYLE_SOLID, 2);
   SetIndexStyle(2, DRAW_HISTOGRAM, EMPTY, 1);
   SetIndexStyle(3, DRAW_HISTOGRAM, EMPTY, 1);

   // Set the width of the indicator lines
   // SetIndexWidth(0, 2);
   // SetIndexWidth(1, 2);
   // SetIndexWidth(2, 2);
   // SetIndexWidth(3, 2);

   // Initialize the previous bar value
   previous_bar = -1;

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
   int bars = Bars;

   // Iterate through the bars
   for (int i = 0; i < bars; i++)
   {
      // Check if the current bar is the first bar of the day
      if (TimeHour(i) == 0 && TimeMinute(i) == 0)
      {
         // Calculate the resistance and support levels for the current bar
         resistance[i] = High[i] + (High[i] - Low[i]) * 0.5;
         support[i] = Low[i] - (High[i] - Low[i]) * 0.5;
         
         // Check if the resistance or support levels were broken in the previous bar
         if (previous_bar >= 0)
         {
            if (High[previous_bar] > resistance[i])
            {
               // Resistance was broken
               broken_resistance[i] = resistance[i];
            }
            if (Low[previous_bar] < support[i])
            {
               // Support was broken
               broken_support[i] = support[i];
            }
         }
         
         // Update the previous bar value
         previous_bar = i;
      }
      else
      {
         // Use the same values as the previous bar
         resistance[i] = resistance[i - 1];
         support[i] = support[i - 1];
         broken_resistance[i] = broken_resistance[i - 1];
         broken_support[i] = broken_support[i - 1];
      }
   }

   // Success
   return(0);
}




