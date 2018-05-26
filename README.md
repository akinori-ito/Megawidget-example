# An example of using tk::Megawidget for creating a megawidget

## How to write a megawidget

- Use `tk::Megawidget` to create the class of a megawidget.

```
tk::Megawidget create mymegawidget tk::SimpleWidget {
    variable w hull options
    method Create {} {
      ...
    }
    method GetSpecs {} {
      ...
   }
   ...
}
```

- Variables `w`, `hull` and `options` should be declared. (Defined in the superclass `tk::SimpleWidget`)
- The variable `w` holds the name of the instance.
- The method `Create` is called when an instance of the widget is created. The variable `hull` holds a frame widget into which new widgets are aligned. The array variable `options` holds all of specified options and their values.
- The method `GetSpecs` should return a list of available options and its resources.
