using System;
using System.Collections.Generic;
using System.Linq;

//<summary>
//Summary description for Enumerable
//</summary>
public static class EnumerableExtension
{
    private static TSerializableEntity ToTSerializableEntity<TEntity, TSerializableEntity>(TEntity entity)
        where TEntity : class, new()
        where TSerializableEntity : SerializableEntity<TEntity>, new()
    {
        TSerializableEntity serializable = new TSerializableEntity { Entity = entity };
        return serializable;
    }

    //
    // Summary:
    //     Creates an array from a System.Collections.Generic.IEnumerable<T>.
    //
    // Parameters:
    //   source:
    //     An System.Collections.Generic.IEnumerable<T> to create an array from.
    //
    // Type parameters:
    //   TSource:
    //     The type of the elements of source.
    //
    // Returns:
    //     An array that contains the elements from the input sequence.
    //
    // Exceptions:
    //   System.ArgumentNullException:
    //     source is null.
    public static TSerializableEntity[] ToArray<TSource, TSerializableEntity>(this IEnumerable<TSource> source)
        where TSource : class, new()
        where TSerializableEntity : SerializableEntity<TSource>, new()
    {
        return source.ToList<TSource, TSerializableEntity>().ToArray();
    }

    //Summary:
    //    Creates a System.Collections.Generic.List<T> from an System.Collections.Generic.IEnumerable<T>.

    //Parameters:
    //  source:
    //    The System.Collections.Generic.IEnumerable<T> to create a System.Collections.Generic.List<T>
    //    from.

    //Type parameters:
    //  TSource:
    //    The type of the elements of source.

    //Returns:
    //    A System.Collections.Generic.List<T> that contains elements from the input
    //    sequence.

    //Exceptions:
    //  System.ArgumentNullException:
    //    source is null.
    public static List<TSerializableEntity> ToList<TSource, TSerializableEntity>(this IEnumerable<TSource> source)
        where TSource : class, new()
        where TSerializableEntity : SerializableEntity<TSource>, new()
    {
        List<TSerializableEntity> list = new List<TSerializableEntity>();

        foreach (TSource entity in source)
        {
            list.Add(ToTSerializableEntity<TSource, TSerializableEntity>(entity));
        }
        return list;
    }
}