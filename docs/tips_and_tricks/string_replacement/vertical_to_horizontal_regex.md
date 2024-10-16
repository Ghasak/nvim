# Horizontal to Vertical

Assume that we have the following:

```py

class Employee:

    def __init(self, first_name:str = None, last_name :str = None; age: int = 0, salary:float  t=0.0)->None:

        self, first_name:str = None, last_name :str = None; age: int = 0, salary:float  t=0.0

```

1. We can applye firt `vip` or `shift + v` for the enitr line.
2. Now, we use the cmdline: `'<,'>s/\,\s*/\r/cig` this will be expalined `\r` which is adding `Enter`.

```py


class Employee:

    def __init(self, first_name:str = None, last_name :str = None; age: int = 0, salary:float  t=0.0)->None:

first_name:str = None
last_name :str = None;
age: int = 0
salary:float  t=0.0
```

3. We can also add indentation `vip` then `'<,'>norm I        ` this will add indentation to the correct position.

```py

class Employee:

    def __init(self, first_name:str = None, last_name :str = None; age: int = 0, salary:float  t=0.0)->None:

        first_name:str = None
        last_name :str = None; age: int = 0
        salary:float  t=0.0

```
