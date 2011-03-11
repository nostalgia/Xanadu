/**
 *
 */
module	Xanadu.Anything;

/**
 *
 */
private import  std.traits;
private import  Xanadu.Core;

/**
 *
 */
union	xValue
{
	bool	            _bool;

	char	            _char;
	wchar	            _wchar;
	dchar	            _dchar;

	byte	            _byte;
	short	            _short;
	int		            _int;
	long	            _long;

	ubyte	            _ubyte;
	ushort	            _ushort;
	uint	            _uint;
	ulong	            _ulong;

	float	            _float;
	double	            _double;
	real	            _real;

	ifloat	            _ifloat;
	idouble	            _idouble;

	cfloat	            _cfloat;
	cdouble	            _cdouble;

	void*			    _Pointer;
	void[]			    _Array;
	Object			    _Object;
	void    delegate()  _Delegate;
	void    function()  _Function;
}

/**
 *
 */
enum	xKind	:	int
{
	Unknown,
	Primitive,
	AssociativeArray,
	StaticArray,
	DynamicArray,
	Class,
	Interface,
	Struct,
	Typedef,
	Enum,
	Pointer,
	Delegate,
	Function,
}

/**
 *
 */
union	xConvert(T)
{
	T		Array;
	void*	Pointer;
}

/**
 *
 */
bool    IsTypeHandller(T)(TypeInfo _Info, string _StringOf)
{
    return  typeid(T) == _Info;
}

/**
 *  Summary
 *
 *  Description
 *
 */
class   xAnything    :   xCore
{
public:
protected:
	bool    function(TypeInfo, string)	m_IsTypeHandller;
	TypeInfo                            m_Info;
	xValue								m_Value;
	xKind								m_Kind;
	bool								m_Immutabled;
	bool								m_Shared;
	string								m_Signature;

private:

public:
protected:
private:

public:
    TypeInfo    GetTypeInfo()
    {
        return  m_Info;
    }

    T   Get(T)()
    {
        if (IsType!(T) == false)
        {
            assert(0);
        }

        static if ((__traits(isArithmetic, T) == true) && (is(T == enum) == false) && (is(T == typedef) == false))
        {
            mixin("return   m_Value._" ~ T.stringof ~ ";");
        }
        else static if (__traits(isAssociativeArray, T) == true)
        {
            return  cast(T)(m_Value._Pointer);
        }
        else static if (isStaticArray!(T) == true)
        {
            return  cast(T)(m_Value._Array);
        }
        else static if (isDynamicArray!(T) == true)
        {
            return  cast(T)(m_Value._Array);
        }
        else static if (is(T == class))
        {
            return  cast(T)(m_Value._Object);
        }
        else static if (is(T == interface))
        {
            return  cast(T)(m_Value._Pointer);
        }
        else static if (is(T == struct))
        {
            return  *(cast(T*)(m_Value._Pointer));
        }
        else static if (is(T R == return))
        {
            static if (is(T F == delegate))
            {
                return  cast(T)(m_Value._Delegate);
            }
            else static if (is(T F == function))
            {
                return  cast(T)(m_Value._Function);
            }
            else static if (is(T F == F*))
            {
                return  cast(T)(m_Value._Function);
            }
        }
        else static if (is(T : void*))
        {
            return  cast(T)(m_Value._Pointer);
        }
        else static if (is(T B == typedef))
        {
            return  cast(T)(this.Get!(B));
        }
        else static if (is(T B == enum))
        {
            return  cast(T)(this.Get!(B));
        }
    }

	xAnything   SetType(T)()
	{
		m_Kind = xKind.Unknown;
		m_Info = typeid(T);

		m_Immutabled = is(T == immutable);
		m_Shared     = is(T == shared);
		m_Signature  = T.stringof;

        static if ((__traits(isArithmetic, T) == true) && (is(T == enum) == false) && (is(T == typedef) == false))
        {
            m_Kind = xKind.Primitive;
        }
        else static if (__traits(isAssociativeArray, T) == true)
        {
            m_Kind = xKind.AssociativeArray;
        }
        else static if (isStaticArray!(T) == true)
        {
            m_Kind = xKind.StaticArray;
        }
        else static if (isDynamicArray!(T) == true)
        {
            m_Kind = xKind.DynamicArray;
        }
        else static if (is(T == class))
        {
            m_Kind = xKind.Class;
        }
        else static if (is(T == interface))
        {
            m_Kind = xKind.Interface;
        }
        else static if (is(T == struct))
        {
            m_Kind = xKind.Struct;
        }
        else static if (is(T R == return))
        {
            static if (is(T F == delegate))
            {
                m_Kind = xKind.Delegate;
            }
            else static if (is(T F == function))
            {
                m_Kind = xKind.Function;
            }
            else static if (is(T F == F*))
            {
                m_Kind = xKind.Function;
            }
        }
        else static if (is(T : void*))
        {
            m_Kind = xKind.Pointer;
        }
        else static if (is(T B == typedef))
        {
            m_Kind = xKind.Typedef;
        }
        else static if (is(T B == enum))
        {
            m_Kind = xKind.Enum;
        }

		return	this;
	}

	xAnything   opAssign(T)(T _Value)
	{
		m_Kind = xKind.Unknown;
		m_Info = typeid(T);

		m_Immutabled = is(T == immutable);
		m_Shared     = is(T == shared);
		m_Signature  = T.stringof;

        this.Assign!(T)(_Value);

		return	this;
	}

	string	Signature()
	{
		return	m_Signature;
	}

	bool	IsType(T)()
	{
		if (m_Kind == xKind.Unknown)
		{
			return false;
		}

		return  m_Info == typeid(T);
	}
	bool	IsCast(T)()
	{
		if (m_Kind == xKind.Unknown)
		{
			return false;
		}
	}
	bool	IsImplicitCast(T)()
	{
		if (m_Kind == xKind.Unknown)
		{
			return false;
		}

		return  m_Info == typeid(T);
	}
	bool	IsDownCast(T)()
	{
		if (m_Kind == xKind.Unknown)
		{
			return false;
		}
	}
	bool	IsUpCast(T)()
	{
		if (m_Kind == xKind.Unknown)
		{
			return false;
		}
	}


	void	opIndexAssign(K, V)(K _Key, V _Value)
	{
		switch(m_Kind)
		{
		case	xKind.AssociativeArray:
			if (IsType!(V[K]) == false)
			{
				assert(0);
			}

			xConvert!(V[K])	Convert;

			Convert.Pointer = m_Value._Pointer;
			V[K]	Array   = Convert.Array;
			Array[_Key]     = _Value;
			break;
		case	xKind.StaticArray:
		case	xKind.DynamicArray:
			static if (__traits(isArithmetic, K) == false)
			{
				assert(0);
			}
			if (IsType!(V[]) == false)
			{
				assert(0);
			}

			V[]		Array = cast(V[])(m_Value._Array);
			Array[_Key] = _Value;
			break;
		default:
			assert(0);
		}
	}

protected:
    void Assign(T)(T _Value)
    {
        static if ((__traits(isArithmetic, T) == true) && (is(T == enum) == false) && (is(T == typedef) == false))
        {
            mixin("m_Value._" ~ T.stringof ~ " = _Value;");
			if (m_Kind == xKind.Unknown)
			{
				m_Kind = xKind.Primitive;
			}
        }
        else static if (__traits(isAssociativeArray, T) == true)
        {
            m_Value._Pointer = cast(typeof(m_Value._Pointer))(_Value.dup);
			if (m_Kind == xKind.Unknown)
			{
				m_Kind = xKind.AssociativeArray;
			}
        }
        else static if (isStaticArray!(T) == true)
        {
            m_Value._Array = cast(typeof(m_Value._Array))(_Value.dup);
			if (m_Kind == xKind.Unknown)
			{
				m_Kind = xKind.StaticArray;
			}
        }
        else static if (isDynamicArray!(T) == true)
        {
            m_Value._Array = cast(typeof(m_Value._Array))(_Value.dup);
			if (m_Kind == xKind.Unknown)
			{
				m_Kind = xKind.DynamicArray;
			}
        }
        else static if (is(T == class))
        {
            m_Value._Object = cast(typeof(m_Value._Object))_Value;
			if (m_Kind == xKind.Unknown)
			{
				m_Kind = xKind.Class;
			}
        }
        else static if (is(T == interface))
        {
            m_Value._Pointer = cast(typeof(m_Value._Pointer))_Value;
			if (m_Kind == xKind.Unknown)
			{
				m_Kind = xKind.Interface;
			}
        }
        else static if (is(T == struct))
        {
            m_Value._Pointer = cast(typeof(m_Value._Pointer))&_Value;
			if (m_Kind == xKind.Unknown)
			{
				m_Kind = xKind.Struct;
			}
        }
        else static if (is(T R == return))
        {
            static if (is(T F == delegate))
            {
                m_Value._Delegate = cast(typeof(m_Value._Delegate))_Value;
				if (m_Kind == xKind.Unknown)
				{
					m_Kind = xKind.Delegate;
				}
            }
            else static if (is(T F == function))
            {
                m_Value._Function = cast(typeof(m_Value._Function))_Value;
				if (m_Kind == xKind.Unknown)
				{
					m_Kind = xKind.Function;
				}
            }
            else static if (is(T F == F*))
            {
                m_Value._Function = cast(typeof(m_Value._Function))_Value;
				if (m_Kind == xKind.Unknown)
				{
					m_Kind = xKind.Function;
				}
            }
        }
        else static if (is(T : void*))
        {
            m_Value._Pointer = cast(typeof(m_Value._Pointer))_Value;
			if (m_Kind == xKind.Unknown)
			{
				m_Kind = xKind.Pointer;
			}
        }
        else static if (is(T B == typedef))
        {
            Assign(cast(B)_Value);
			if (m_Kind == xKind.Unknown)
			{
				m_Kind = xKind.Typedef;
			}
        }
        else static if (is(T B == enum))
        {
            Assign(cast(B)_Value);
			if (m_Kind == xKind.Unknown)
			{
				m_Kind = xKind.Enum;
			}
        }
    }

private:

public:
    @property
    {
        bool    IsEmpty()
        {
            return  m_Info is null;
        }
    }
protected:
private:

public:
protected:
private:
}

