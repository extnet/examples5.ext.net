using System;

namespace Ext.Net.Examples
{
    public class Util
    {
        /// <summary>
        /// Turns uppercase characters within string into space + character.
        /// </summary>
        /// <example>ThisString => This String</example>
        /// <param name="what">String to be transformed.</param>
        /// <returns>String with spaces between lower and uppercase characters.</returns>
        public static string UpperCaseToSpace(string what)
        {
            if (what == null || what.Length < 2)
            {
                return what;
            }
            else
            {
                var retVal = what.Substring(0, 1);
                for (var i = 1; i < what.Length; i++)
                {
                    if (Char.IsUpper(what, i))
                    {
                        retVal += " ";
                    }
                    retVal += what[i];
                }

                return retVal;
            }
        }
    }
}