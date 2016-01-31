using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;

namespace Ext.Net.Examples.Northwind
{
    public partial class Employee
    {
        public static List<Employee> GetAll()
        {
            NorthwindDataContext db = new NorthwindDataContext();

            return db.Employees.ToList();
        }

        public static Employee GetEmployee(int id)
        {
            NorthwindDataContext db = new NorthwindDataContext();

            return GetEmployee(id, db);
        }

        public static Employee GetEmployee(int id, NorthwindDataContext db)
        {
            return db.Employees.Single(e => e.EmployeeID == id);
        }

        public static List<Employee> GetEmployeesFilter(int start, int limit, DataSorter sort, out int count)
        {
            NorthwindDataContext db = new NorthwindDataContext();
            IQueryable<Employee> result = db.Employees.Select(e => e);

            if (sort != null)
            {
                ParameterExpression param = Expression.Parameter(typeof(Employee), "e");
                
                if (sort.Property == "BirthDate" || sort.Property == "HireDate")
                {
                    Expression<Func<Employee, DateTime?>> sortExpression = Expression.Lambda<Func<Employee, DateTime?>>(Expression.Property(param, sort.Property), param);
                    if (sort.Direction == SortDirection.DESC)
                    {
                        result = result.OrderByDescending(sortExpression);
                    }
                    else
                    {
                        result = result.OrderBy(sortExpression);
                    }
                }
                else
                {
                    Expression<Func<Employee, object>> sortExpression = Expression.Lambda<Func<Employee, object>>(Expression.Property(param, sort.Property), param);
                    if (sort.Direction == SortDirection.DESC)
                    {
                        result = result.OrderByDescending(sortExpression);
                    }
                    else
                    {
                        result = result.OrderBy(sortExpression);
                    }
                }
            }

            if (start >= 0 && limit > 0)
            {
                result = result.Skip(start).Take(limit);
            }

            count = db.Employees.Count();

            return result.ToList();
        }
    }
}
