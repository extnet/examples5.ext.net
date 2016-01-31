using System;
using System.Collections.Generic;
using System.Globalization;

namespace Ext.Net.Examples
{
    public class ChartData
    {
        public string Name
        {
            get;
            set;
        }

        public double Data1
        {
            get;
            set;
        }

        public double Data2
        {
            get;
            set;
        }

        public double Data3
        {
            get;
            set;
        }

        public double Data4
        {
            get;
            set;
        }

        public double Data5
        {
            get;
            set;
        }

        public double Data6
        {
            get;
            set;
        }

        public double Data7
        {
            get;
            set;
        }

        public double Data8
        {
            get;
            set;
        }

        public double Data9
        {
            get;
            set;
        }

        public static List<ChartData> GenerateData()
        {
            return ChartData.GenerateData(12, 20);
        }

        public static List<ChartData> GenerateData(int n)
        {
            return ChartData.GenerateData(n, 20);
        }

        public static List<ChartData> GenerateData(int n, int floor)
        {
            List<ChartData> data = new List<ChartData>(n);
            Random random = new Random();
            double p = (random.NextDouble() * 11) + 1;

            for (int i = 0; i < n; i++)
            {
                data.Add(new ChartData
                {
                    Name = CultureInfo.InvariantCulture.DateTimeFormat.MonthNames[i % 12],
                    Data1 = Math.Floor(Math.Max(random.NextDouble() * 100, floor)),
                    Data2 = Math.Floor(Math.Max(random.NextDouble() * 100, floor)),
                    Data3 = Math.Floor(Math.Max(random.NextDouble() * 100, floor)),
                    Data4 = Math.Floor(Math.Max(random.NextDouble() * 100, floor)),
                    Data5 = Math.Floor(Math.Max(random.NextDouble() * 100, floor)),
                    Data6 = Math.Floor(Math.Max(random.NextDouble() * 100, floor)),
                    Data7 = Math.Floor(Math.Max(random.NextDouble() * 100, floor)),
                    Data8 = Math.Floor(Math.Max(random.NextDouble() * 100, floor)),
                    Data9 = Math.Floor(Math.Max(random.NextDouble() * 100, floor))
                });
            }

            return data;
        }

        public static List<ChartData> GenerateDataNegative()
        {
            return ChartData.GenerateDataNegative(12, 20);
        }

        public static List<ChartData> GenerateDataNegative(int n, int floor)
        {
            List<ChartData> data = new List<ChartData>(n);
            Random random = new Random();
            double p = (random.NextDouble() * 11) + 1;

            for (int i = 0; i < n; i++)
            {
                data.Add(new ChartData
                {
                    Name = CultureInfo.InvariantCulture.DateTimeFormat.MonthNames[i % 12],
                    Data1 = Math.Floor(Math.Max((random.NextDouble() - 0.5) * 100, floor)),
                    Data2 = Math.Floor(Math.Max((random.NextDouble() - 0.5) * 100, floor)),
                    Data3 = Math.Floor(Math.Max((random.NextDouble() - 0.5) * 100, floor)),
                    Data4 = Math.Floor(Math.Max((random.NextDouble() - 0.5) * 100, floor)),
                    Data5 = Math.Floor(Math.Max((random.NextDouble() - 0.5) * 100, floor)),
                    Data6 = Math.Floor(Math.Max((random.NextDouble() - 0.5) * 100, floor)),
                    Data7 = Math.Floor(Math.Max((random.NextDouble() - 0.5) * 100, floor)),
                    Data8 = Math.Floor(Math.Max((random.NextDouble() - 0.5) * 100, floor)),
                    Data9 = Math.Floor(Math.Max((random.NextDouble() - 0.5) * 100, floor))
                });
            }

            return data;
        }
    }
}