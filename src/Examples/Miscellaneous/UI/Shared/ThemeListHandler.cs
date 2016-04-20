using System;
using System.Collections.Generic;
using System.Linq;

namespace Ext.Net.Examples.Examples.Miscellaneous.UI.Shared
{
    public class ThemeListHandler
    {
        /// <summary>
        /// Enumerated list of all available theme names. Including the 'none' theme.
        /// </summary>
        public static List<Ext.Net.Theme> ThemeList = (Enum.GetValues(typeof(Ext.Net.Theme)).Cast<Ext.Net.Theme>()).ToList();

        /// <summary>
        /// Get the Ext.Net.Theme from the provided string representation of numeric id.
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static Ext.Net.Theme GetThemeFromId(string id)
        {
            int themeId;
            if (int.TryParse(id, out themeId))
            {
                return GetThemeFromId(themeId);
            }
            else
            {
                return Ext.Net.Theme.None;
            }
        }

        /// <summary>
        /// Get the Ext.Net.Theme from the provided integer id.
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static Ext.Net.Theme GetThemeFromId(int id)
        {
            if (id >= 0 && id < ThemeList.Count())
            {
                return ThemeList[id];
            }
            else
            {
                return Ext.Net.Theme.None;
            }
        }

        /// <summary>
        /// Adds the list of themes to the specified combobox reference.
        /// </summary>
        /// <param name="comboBox"></param>
        public static void AddThemeListTo(ref ComboBox comboBox)
        {
            foreach (var theme in ThemeList)
            {
                if (theme != Theme.Aria) // Aria theme is not supported for UI
                {
                    comboBox.AddItem(theme.ToString(), ((int)theme).ToString());
                }
            }
        }
    }
}