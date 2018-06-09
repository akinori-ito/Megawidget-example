package provide ComposedWidget 0.1

tk::Megawidget create ComposedWidget tk::SimpleWidget {
    variable w hull options forwardlist
    method Create {} {
        set forwardlist {}
    }
    method GetSpecs {} {
        next
    }
    method configure {optsw val} {
        foreach {widget optionlist} $forwardlist {
            if {[lsearch $optionlist $optsw] >= 0} {
                $widget configure $optsw $val
            }
        }
    }
    method forwardoption {} {
        # optlist: {widget optionlist widget optionlist ... }
        foreach {optsw val} [array get options] {
            $w configure $optsw $val
        }
   }
   method forward {parts cmd arg} {
      return [eval [concat $hull.$parts $cmd $arg]]
   }
}
