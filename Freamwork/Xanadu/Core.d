/**
 *
 */
module	Xanadu.Core;

/**
 *
 */

/**
 *  Summary
 *
 *  Description
 *
 */
class	xCore
{
/**
 *
 */
public:
protected:
private:

/**
 *
 */
public:
    this()
    {
    }
    ~this()
    {
    }

protected:
private:

/**
 *
 */
public:
    override    string  toString()
    {
        return  super.toString();
    }

    string  ToString()
    {
        return this.classinfo.name;
    }
    string  ToString()  immutable
    {
        return this.classinfo.name;
    }
    string  ToString()  const
    {
        return this.classinfo.name;
    }
    string  ToString()  shared
    {
        return this.classinfo.name;
    }
    string  ToString()  shared  const
    {
        return this.classinfo.name;
    }

    string  ToString(const(char)[] _Format)
    {
        return  this.ToString();
    }
    string  ToString(const(char)[] _Format) immutable
    {
        return  this.ToString();
    }
    string  ToString(const(char)[] _Format) const
    {
        return  this.ToString();
    }
    string  ToString(const(char)[] _Format) shared
    {
        return  this.ToString();
    }
    string  ToString(const(char)[] _Format) shared  const
    {
        return  this.ToString();
    }

    hash_t  ToHash()
    {
        return  hash_t.init;
    }
    hash_t  ToHash()    immutable
    {
        return  hash_t.init;
    }
    hash_t  ToHash()    const
    {
        return  hash_t.init;
    }
    hash_t  ToHash()    shared
    {
        return  hash_t.init;
    }
    hash_t  ToHash()    shared  const
    {
        return  hash_t.init;
    }

    void Notify()   shared
    {
    }
    void Notify()   shared  const
    {
    }
    void NotifyAll()    shared
    {
    }
    void NotifyAll()    shared  const
    {
    }
    void Wait() shared
    {
    }
    void Wait() shared  const
    {
    }
    bool Wait(uint _TimeOut)    shared
    {
        return  true;
    }
    bool Wait(uint _TimeOut)    shared  const
    {
        return  true;
    }

protected:
private:

/**
 *
 */
public:
    @property
    {
    }
protected:
private:

/**
 *
 */
public:
protected:
private:
}


/**
 *  Summary
 *
 *  Description
 *
 */
class	xException  :   Throwable
{
/**
 *
 */
public:
protected:
private:

/**
 *
 */
public:
    this()
    {
        super("");
    }
    this(string _Message, Throwable _Next = null)
    {
        super(_Message, _Next);
    }

    this(string _Message, string _File, size_t _Line, Throwable _Next = null)
    {
        super(_Message, _File, _Line, _Next);
    }

protected:
private:

/**
 *
 */
public:
    override    string  toString()
    {
        return  super.toString();
    }
    string  ToString()
    {
        return  this.toString();
    }
protected:
private:

/**
 *
 */
public:
protected:
private:

/**
 *
 */
public:
protected:
private:
}
